@echo off
cd /d "%~dp0"
start "" /min powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0serve.ps1"
timeout /t 2 >nul
start "" "http://localhost:8123/altynka.html"
