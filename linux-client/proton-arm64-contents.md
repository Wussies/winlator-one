# proton-arm64 contents

- ./ (11 files)
- files/ (1 files)
- files/bin-arm64/ (3 files)
- files/share/ (1 files)
- files/lib/ (0 files)

### version
```
1789159687 experimental-11.0-20260910b-arm64

```

### proton
```
#!/usr/bin/env python3

#script to launch Wine with the correct environment

import fcntl
import array
import fnmatch
import os
import shutil
import errno
import platform
import resource
import stat
import subprocess
import sys
import shlex
import uuid
import json
import time

from ctypes import CDLL
from ctypes import CFUNCTYPE
from ctypes import POINTER
from ctypes import Structure
from ctypes import addressof
from ctypes import cast
from ctypes import get_errno
from ctypes import sizeof
from ctypes import c_int
from ctypes import c_int64
from ctypes import c_uint
from ctypes import c_long
from ctypes import c_char_p
from ctypes import c_void_p
from ctypes import c_size_t
from ctypes import c_ssize_t

from filelock import FileLock
from random import randrange

#To enable debug logging, copy "user_settings.sample.py" to "user_settings.py"
#and edit it if needed.

CURRENT_PREFIX_VERSION="11.0-100"

PFX="Proton: "
ld_path_var = "LD_LIBRARY_PATH"

def file_exists(s, *, follow_symlinks):
    if follow_symlinks:
        #'exists' returns False on broken symlinks
        return os.path.exists(s)
    #'lexists' returns True on broken symlinks
    return os.path.lexists(s)

def nonzero(s):
    return len(s) > 0 and s != "0"

def prepend_to_env_str(env, variable, prepend_str, separator):
    if variable not in env:
        env[variable] = prepend_str
    else:
        env[variable] = prepend_str + separator + env[variable]

def append_to_env_str(env, variable, append_str, separator):
```

### LICENSE
```
Copyright (c) 2018-2022, Valve Corporation
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software without
specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Browse
```

### PATENTS.AV1
```
Alliance for Open Media Patent License 1.0

1. License Terms.

1.1. Patent License. Subject to the terms and conditions of this License, each
     Licensor, on behalf of itself and successors in interest and assigns,
     grants Licensee a non-sublicensable, perpetual, worldwide, non-exclusive,
     no-charge, royalty-free, irrevocable (except as expressly stated in this
     License) patent license to its Necessary Claims to make, use, sell, offer
     for sale, import or distribute any Implementation.

1.2. Conditions.

1.2.1. Availability. As a condition to the grant of rights to Licensee to make,
       sell, offer for sale, import or distribute an Implementation under
       Section 1.1, Licensee must make its Necessary Claims available under
       this License, and must reproduce this License with any Implementation
       as follows:

       a. For distribution in source code, by including this License in the
          root directory of the source code with its Implementation.

       b. For distribution in any other form (including binary, object form,
          and/or hardware description code (e.g., HDL, RTL, Gate Level Netlist,
          GDSII, etc.)), by including this License in the documentation, legal
          notices, and/or other written materials provided with the
          Implementation.

1.2.2. Additional Conditions. This license is directly from Licensor to
       Licensee.  Licensee acknowledges as a condition of benefiting from it
       that no righ
```

### toolmanifest.vdf
```
"manifest"
{
  "version" "2"
  "commandline" "/proton %verb%"
  "require_tool_appid" "4185400"
  "use_sessions" "1"
  "compatmanager_layer_name" "proton"
}

```
