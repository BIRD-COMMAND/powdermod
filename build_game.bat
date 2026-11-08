@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

:: Handle standalone asset regeneration request directly
if /i "%~1"=="assets" (
    echo ========================================================
    echo  [POWDER] Forcing Asset Regeneration
    echo ========================================================
    call "%~dp0port\windows\prebuild.bat" "%~dp0" --force <nul
    exit /b !ERRORLEVEL!
)

:: Default parameters
set "ACTION=/t:Build"
set "CONFIG=Release"
set "CUSTOM_MSBUILD="

:: -------------------------------------------------------------
:: 1. Parse Arguments (supports positional and flagged syntax)
:: -------------------------------------------------------------
:parse_args
if "%~1"=="" goto done_args

if /i "%~1"=="rebuild" (
    set "ACTION=/t:Rebuild"
    shift
    goto parse_args
)
if /i "%~1"=="clean" (
    set "ACTION=/t:Clean"
    shift
    goto parse_args
)
if /i "%~1"=="build" (
    set "ACTION=/t:Build"
    shift
    goto parse_args
)
if /i "%~1"=="release" (
    set "CONFIG=Release"
    shift
    goto parse_args
)
if /i "%~1"=="debug" (
    set "CONFIG=Debug"
    shift
    goto parse_args
)
if /i "%~1"=="/msbuild" (
    set "CUSTOM_MSBUILD=%~2"
    shift
    shift
    goto parse_args
)
if /i "%~1"=="--msbuild" (
    set "CUSTOM_MSBUILD=%~2"
    shift
    shift
    goto parse_args
)

if exist "%~1" (
    set "CUSTOM_MSBUILD=%~1"
    shift
    goto parse_args
)

shift
goto parse_args

:done_args

:: -------------------------------------------------------------
:: 2. Resolve MSBuild Binary
:: -------------------------------------------------------------
set "MSBUILD_EXE="

if defined CUSTOM_MSBUILD (
    if exist "%CUSTOM_MSBUILD%" (
        if exist "%CUSTOM_MSBUILD%\MSBuild.exe" (
            set "MSBUILD_EXE=%CUSTOM_MSBUILD%\MSBuild.exe"
        ) else (
            set "MSBUILD_EXE=%CUSTOM_MSBUILD%"
        )
    )
)

if not defined MSBUILD_EXE if defined MSBUILD_PATH (
    if exist "%MSBUILD_PATH%" (
        if exist "%MSBUILD_PATH%\MSBuild.exe" (
            set "MSBUILD_EXE=%MSBUILD_PATH%\MSBuild.exe"
        ) else (
            set "MSBUILD_EXE=%MSBUILD_PATH%"
        )
    )
)

if not defined MSBUILD_EXE (
    set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
    if exist "!VSWHERE!" (
        for /f "usebackq tokens=*" %%i in (`"!VSWHERE!" -latest -prerelease -products * -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do (
            if not defined MSBUILD_EXE set "MSBUILD_EXE=%%i"
        )
    )
)

if not defined MSBUILD_EXE (
    for %%P in (
        "%ProgramFiles%\Microsoft Visual Studio\18\Insiders\MSBuild\Current\Bin\amd64\MSBuild.exe"
        "%ProgramFiles%\Microsoft Visual Studio\18\Insiders\MSBuild\Current\Bin\MSBuild.exe"
        "%ProgramFiles%\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\amd64\MSBuild.exe"
        "%ProgramFiles%\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin\MSBuild.exe"
        "%ProgramFiles%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\amd64\MSBuild.exe"
    ) do (
        if not defined MSBUILD_EXE if exist "%%~P" set "MSBUILD_EXE=%%~P"
    )
)

if not defined MSBUILD_EXE (
    where msbuild.exe >nul 2>nul
    if %ERRORLEVEL% equ 0 (
        for /f "delims=" %%i in ('where msbuild.exe') do (
            if not defined MSBUILD_EXE set "MSBUILD_EXE=%%i"
        )
    )
)

if not defined MSBUILD_EXE (
    echo [ERROR] MSBuild.exe was not found.
    exit /b 1
)

:: -------------------------------------------------------------
:: 3. Execute Build
:: -------------------------------------------------------------
echo ========================================================
echo  [POWDER] MSBuild: "%MSBUILD_EXE%"
echo  [POWDER] Target:  %ACTION% (%CONFIG% Win32)
echo ========================================================

"%MSBUILD_EXE%" "port\windows\Powder_vc9.sln" ^
    %ACTION% ^
    /p:Configuration=%CONFIG% ^
    /p:Platform=Win32 ^
    /verbosity:minimal ^
    /nologo

set "BUILD_STATUS=%ERRORLEVEL%"

if %BUILD_STATUS% equ 0 (
    echo(
    echo ========================================================
    echo  [POWDER] Build finished successfully!
    echo  Binary: port\windows\%CONFIG%\Powder.exe
    echo ========================================================
) else (
    echo [POWDER] Build failed with exit code %BUILD_STATUS%.
)

exit /b %BUILD_STATUS%