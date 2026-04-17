@echo off
setlocal enabledelayedexpansion

set "INSTALL_DIR=%USERPROFILE%\.rexlib"
set "LUA_FILE=%INSTALL_DIR%\rexlib.lua"
set "UPDATE_FILE=%INSTALL_DIR%\update.bat"

set "LUA_URL=https://raw.githubusercontent.com/Rexilion-Studio/RexLib/main/rexlib.lua"
set "UPDATE_URL=https://raw.githubusercontent.com/Rexilion-Studio/RexLib/main/update.bat"

cls
echo.
echo ==========================================
echo             RexLib Installer
echo ==========================================
echo.

echo Creating install directory...
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo Installing RexLib core...
curl -L "%LUA_URL%" -o "%LUA_FILE%" >nul 2>nul

if errorlevel 1 (
    echo [ERROR] Failed to install RexLib
    pause
    exit /b
)

echo Installing updater...
curl -L "%UPDATE_URL%" -o "%UPDATE_FILE%" >nul 2>nul

if errorlevel 1 (
    echo [ERROR] Failed to install updater
    pause
    exit /b
)

echo.
echo ==========================================
echo        RexLib installed successfully
echo ==========================================
echo Location: %INSTALL_DIR%
echo.

pause
exit /b