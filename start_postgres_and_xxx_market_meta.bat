@echo off
setlocal

set "SERVICE_NAME=postgresql-x64-18"
set "PROJECT_DIR=%~dp0"
set "BACKEND_DIR=%PROJECT_DIR%backend"

echo [1/3] Pruefe PostgreSQL-Dienst: %SERVICE_NAME%
sc query "%SERVICE_NAME%" >nul 2>&1
if errorlevel 1 (
    echo PostgreSQL-Dienst "%SERVICE_NAME%" wurde nicht gefunden.
    echo Bitte pruefe den Dienstnamen in dieser BAT-Datei.
    pause
    exit /b 1
)

sc query "%SERVICE_NAME%" | findstr /I "RUNNING" >nul
if not errorlevel 1 (
    echo PostgreSQL laeuft bereits.
) else (
    echo PostgreSQL ist nicht aktiv. Starte Dienst...
    net start "%SERVICE_NAME%" >nul 2>&1
    if errorlevel 1 (
        sc query "%SERVICE_NAME%" | findstr /I "RUNNING" >nul
        if not errorlevel 1 (
            echo PostgreSQL laeuft bereits.
            goto :postgres_ok
        )
        echo Konnte PostgreSQL nicht starten.
        echo Starte diese BAT per Rechtsklick als Administrator.
        pause
        exit /b 1
    )
    echo PostgreSQL wurde gestartet.
)

:postgres_ok
echo [2/3] Starte Backend...
cd /d "%BACKEND_DIR%"
if exist "venv\Scripts\python.exe" (
    start "AWS Grocery Backend" "venv\Scripts\python.exe" "run.py"
) else (
    start "AWS Grocery Backend" python "run.py"
)

echo [3/3] Oeffne Webseite...
timeout /t 3 /nobreak >nul
start "" "http://localhost:5000"

echo Fertig.
exit /b 0
