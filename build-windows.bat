@echo off
setlocal
cd /d "%~dp0"

echo.
echo ============================================
echo   Eisenhower Matrix - Windows EXE build
echo ============================================
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo Node.js is not installed. Install Node.js LTS first.
  pause
  exit /b 1
)

where cargo >nul 2>&1
if errorlevel 1 (
  echo Rust is not installed. Install Rust via rustup first.
  pause
  exit /b 1
)

echo Installing frontend / Tauri dependencies...
npm install
if errorlevel 1 goto :fail

echo.
echo Building Windows installer...
npm run tauri build
if errorlevel 1 goto :fail

echo.
echo BUILD COMPLETE.
echo Installer files are in:
 echo src-tauri\target\release\bundle\nsis\
echo.
pause
exit /b 0

:fail
echo.
echo BUILD FAILED.
pause
exit /b 1
