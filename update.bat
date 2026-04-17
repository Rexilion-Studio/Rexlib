@echo off
setlocal

set "INSTALL_DIR=%USERPROFILE%\.rexlib"
set "LUA_FILE=%INSTALL_DIR%\rexlib.lua"
set "TEMP_INSTALL=%TEMP%\rexlib_install.bat"
set "INSTALLER_URL=https://raw.githubusercontent.com/Rexilion-Studio/RexLib/main/install.bat"

cls
echo.
echo ==========================================
echo             RexLib Updater
echo ==========================================
echo.

echo Fetching latest installer...
curl -L "%INSTALLER_URL%" -o "%TEMP_INSTALL%" >nul 2>nul

if errorlevel 1 (
    echo [ERROR] Failed to download installer
    pause
    exit /b
)

echo Running installer...
call "%TEMP_INSTALL%"

echo.
echo Update complete.
pause
exit /b