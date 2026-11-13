Gitleaks findings: 36 {'jwt': 1, 'generic-api-key': 35}
Total 7 packages affected by 14 known vulnerabilities (0 Critical, 3 High, 3 Medium, 2 Low, 6 Unknown) from 1 ecosystem.
Trivy Total: 5 (UNKNOWN: 0, LOW: 2, MEDIUM: 2, HIGH: 1, CRITICAL: 0)
Trivy Total: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 1, HIGH: 0, CRITICAL: 0)
Semgrep findings: 62 {'WARNING': 57, 'ERROR': 5}
  ERROR app/src/androidTest/kotlin/com/winlator/cmod/runtime/system/LogShareTest.kt:15 detected-jwt-token
  ERROR app/src/main/feature/stores/epic/service/EpicConstants.kt:68 detected-generic-secret
  ERROR app/src/main/feature/stores/gog/service/GOGConstants.kt:31 detected-generic-secret
  ERROR app/src/main/runtime/display/environment/components/LinuxProgramLauncherComponent.java:56 command-injection-process-builder
  ERROR app/src/main/runtime/system/ProcessHelper.java:353 command-injection-process-builder
