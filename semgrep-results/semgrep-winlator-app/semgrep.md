## Semgrep 1.185.0
p/java exit=0
p/kotlin exit=0
p/c exit=0
p/secrets exit=0
p/github-actions exit=0
p/insecure-transport exit=0
p/default exit=0
Findings: 2, by severity {'WARNING': 1, 'ERROR': 1}; scan errors: 0

### Top rules
- exported_activity: 1
- command-injection-process-builder: 1

### ERROR-severity findings
- `app/src/main/java/com/winlator/core/ProcessHelper.java:73` command-injection-process-builder

### WARNING-severity (first 60)
- `app/src/main/AndroidManifest.xml:27` exported_activity
