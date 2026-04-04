@echo off
setlocal enabledelayedexpansion

REM === CONFIG ===
set REPO_URL=https://raw.githubusercontent.com/Rexilion-Studio/RexLib/main/rexlib.lua
set INSTALL_DIR=%USERPROFILE%\.rexlib
set TARGET=%INSTALL_DIR%\rexlib.lua
set TEMP_FILE=%TEMP%\rexlib_new.lua

title RexLib Installer
color 0A

echo.
echo =====================================
echo        RexLib Installer
echo =====================================
echo.

call :progressBar 5 "Initializing..."

REM === CHECK CURL ===
where curl >nul 2>nul
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] curl is not installed.
    pause
    exit /b
)

REM === ENSURE DIRECTORY EXISTS ===
if not exist "%INSTALL_DIR%" (
    call :progressBar 5 "Creating installation directory..."
    mkdir "%INSTALL_DIR%"
)

REM === DOWNLOAD ===
call :progressBar 5 "Downloading latest version..."
curl -L -o "%TEMP_FILE%" "%REPO_URL%" >nul 2>nul

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Download failed.
    pause
    exit /b
)

REM === VERIFY ===
call :progressBar 5 "Verifying files..."

if exist "%TARGET%" (
    for %%A in ("%TARGET%") do set OLD_TIME=%%~tA
    for %%B in ("%TEMP_FILE%") do set NEW_TIME=%%~tB

    if "!OLD_TIME!"=="!NEW_TIME!" (
        echo.
        echo [INFO] RexLib is already up to date.
        del "%TEMP_FILE%" >nul 2>nul
        goto done
    ) else (
        echo.
        echo [INFO] Update found. Replacing old version...
        call :progressBar 5 "Updating..."
        del "%TARGET%" >nul 2>nul
    )
) else (
    echo.
    echo [INFO] Installing RexLib for the first time...
    call :progressBar 5 "Installing..."
)

REM === INSTALL NEW FILE ===
move /Y "%TEMP_FILE%" "%TARGET%" >nul 2>nul

call :progressBar 5 "Finalizing..."

:done
echo.
echo =====================================
echo   RexLib is ready!
echo   Path: %TARGET%
echo =====================================
echo.

pause
exit /b

REM =========================
REM 5-SECOND PROGRESS BAR
REM =========================
:progressBar
set seconds=%~1
set message=%~2
set barLength=25

echo %message%

for /l %%i in (1,1,%barLength%) do (
    set /a percent=%%i*100/%barLength%

    set bar=
    for /l %%a in (1,1,%%i) do set bar=!bar!#
    for /l %%b in (%%i,1,%barLength%) do set bar=!bar!-

    <nul set /p= [!bar!] !percent!%%`r

    set /a wait=%seconds%*1000/%barLength%
    powershell -command "Start-Sleep -Milliseconds !wait!" >nul
)

echo.
exit /b