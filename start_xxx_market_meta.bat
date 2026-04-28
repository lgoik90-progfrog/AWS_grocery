@echo off
setlocal

cd /d "%~dp0backend"

if exist "venv\Scripts\python.exe" (
    start "AWS Grocery Backend" "venv\Scripts\python.exe" "run.py"
) else (
    start "AWS Grocery Backend" python "run.py"
)

timeout /t 3 /nobreak >nul
start "" "http://localhost:5000"

