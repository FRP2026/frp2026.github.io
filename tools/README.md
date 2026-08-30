tools/get-adb-fastboot.ps1

This script downloads the official Google Android platform-tools (adb.exe and fastboot.exe) and places them into this tools/ folder.

Usage (from repository root):
  PowerShell -NoProfile -ExecutionPolicy Bypass -File .\tools\get-adb-fastboot.ps1

Notes:
- tools/adb.exe and tools/fastboot.exe are ignored by .gitignore to avoid committing large binaries.
- If you prefer to track binaries, enable Git LFS and update .gitattributes accordingly.
