# Writes loader-info.c: how far the loader's pokedata_workaround stub sits from its _start, which
# tracee/mem.c needs on arm64 (termux generates it with readelf | awk; this does the same portably).
# NEXORA: falls back to the linker map when the symbol table has been stripped (release builds).
execute_process(COMMAND "${READELF}" -sW "${LOADER}"
                OUTPUT_VARIABLE symbols
                RESULT_VARIABLE status)
if(NOT status EQUAL 0)
  message(FATAL_ERROR "could not read the symbols of ${LOADER}")
endif()
string(REGEX MATCH "[ \t]([0-9a-fA-F]+)[ \t]+[0-9]+[ \t]+[A-Z]+[ \t]+[A-Z]+[ \t]+[A-Z]+[ \t]+[0-9A-Z]+[ \t]+pokedata_workaround\n" workaround "${symbols}")
set(workaround "${CMAKE_MATCH_1}")
string(REGEX MATCH "[ \t]([0-9a-fA-F]+)[ \t]+[0-9]+[ \t]+[A-Z]+[ \t]+[A-Z]+[ \t]+[A-Z]+[ \t]+[0-9A-Z]+[ \t]+_start\n" start "${symbols}")
set(start "${CMAKE_MATCH_1}")
if((workaround STREQUAL "" OR start STREQUAL "") AND DEFINED MAP AND EXISTS "${MAP}")
  # lld map rows: VMA LMA Size Align <indent> name
  file(READ "${MAP}" map)
  string(REGEX MATCH "\n[ \t]*([0-9a-fA-F]+)[ \t]+[0-9a-fA-F]+[ \t]+[0-9a-fA-F]+[ \t]+[0-9]+[ \t]+pokedata_workaround[ \t]*\r?\n" workaround "${map}")
  set(workaround "${CMAKE_MATCH_1}")
  string(REGEX MATCH "\n[ \t]*([0-9a-fA-F]+)[ \t]+[0-9a-fA-F]+[ \t]+[0-9a-fA-F]+[ \t]+[0-9]+[ \t]+_start[ \t]*\r?\n" start "${map}")
  set(start "${CMAKE_MATCH_1}")
  message(STATUS "loader-info: symbol table incomplete, using link map: pokedata_workaround=${workaround} _start=${start}")
endif()
if(workaround STREQUAL "" OR start STREQUAL "")
  string(SUBSTRING "${symbols}" 0 3000 head)
  message(STATUS "readelf -sW ${LOADER}:\n${head}")
  if(DEFINED MAP AND EXISTS "${MAP}")
    file(STRINGS "${MAP}" maplines REGEX "pokedata_workaround|_start|\\.text")
    message(STATUS "map lines: ${maplines}")
  endif()
  message(FATAL_ERROR "pokedata_workaround or _start missing from ${LOADER}")
endif()
math(EXPR offset "0x${workaround} - 0x${start}")
file(WRITE "${OUTPUT}.tmp" "#include <unistd.h>\nconst ssize_t offset_to_pokedata_workaround=${offset};\n")
file(RENAME "${OUTPUT}.tmp" "${OUTPUT}")
