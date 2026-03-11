@echo off
REM Chrome Debug Mode Launcher
REM Author: Xingzi
REM Date: 2026-03-11

echo ========================================
echo Chrome Debug Mode Launcher
echo ========================================
echo.

REM Check if Chrome is running
tasklist /FI "IMAGENAME eq chrome.exe" | find /I "chrome.exe" >nul
if %ERRORLEVEL% equ 0 (
    echo [Warning] Chrome is already running!
    echo Please close all Chrome windows and run again.
    echo Or run: taskkill /F /IM chrome.exe
    echo.
    pause
    exit /b 1
)

REM Set Chrome path
set CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe

REM Check if Chrome exists
if not exist "%CHROME_PATH%" (
    echo [Error] Chrome not found: %CHROME_PATH%
    pause
    exit /b 1
)

REM Set user data directory
set USER_DATA_DIR=%LOCALAPPDATA%\Google\Chrome\Debug

REM Create user data directory
if not exist "%USER_DATA_DIR%" (
    echo [Info] Creating user data directory...
    mkdir "%USER_DATA_DIR%"
)

REM Start Chrome debug mode
echo [Info] Starting Chrome debug mode...
echo [Info] Port: 9222
echo.

start "" "%CHROME_PATH%" --remote-debugging-port=9222 --user-data-dir="%USER_DATA_DIR%" --no-first-run

echo.
echo ========================================
echo Chrome debug mode started!
echo ========================================
echo.
echo Verify:
echo   curl http://127.0.0.1:9222/json/version
echo.
echo Closing in 5 seconds...
timeout /t 5 /nobreak >nul

exit /b 0
