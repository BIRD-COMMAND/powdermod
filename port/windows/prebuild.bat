@echo off
setlocal enabledelayedexpansion

echo [POWDER Pre-Build] Initializing pre-build environment...

set "REPO_ROOT=%~1"
if "%REPO_ROOT%"=="" set "REPO_ROOT=%~dp0..\.."
if "%REPO_ROOT%"=="." set "REPO_ROOT=%CD%"

pushd "%REPO_ROOT%"
set "REPO_ROOT=%CD%"
popd

:: Locate MSYS2 root
set "MSYS_ROOT="
if exist "C:\msys64\usr\bin\bash.exe" set "MSYS_ROOT=C:\msys64"
if not defined MSYS_ROOT (
    if exist "C:\tools\msys64\usr\bin\bash.exe" set "MSYS_ROOT=C:\tools\msys64"
)
if not defined MSYS_ROOT (
    where bash.exe >nul 2>nul
    if %ERRORLEVEL% equ 0 (
        for /f "delims=" %%B in ('where bash.exe') do (
            if not defined MSYS_ROOT (
                set "BASH_DIR=%%~dpB"
                set "MSYS_ROOT=!BASH_DIR:~0,-8!"
            )
        )
    )
)

if not defined MSYS_ROOT (
    echo [POWDER Error] MSYS2 bash.exe was not found.
    echo Please install MSYS2 to C:\msys64 or add its usr\bin folder to PATH.
    exit /b 1
)

set "BASH_EXE=%MSYS_ROOT%\usr\bin\bash.exe"

:: Convert Windows path to POSIX path for MSYS2
set "WIN_PATH=%REPO_ROOT%"
set "WIN_DRIVE=%WIN_PATH:~0,1%"
set "WIN_REST=%WIN_PATH:~2%"
set "WIN_REST=%WIN_REST:\=/%"
for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    if /i "%WIN_DRIVE%"=="%%L" set "WIN_DRIVE=%%L"
)
set "UNIX_PATH=/%WIN_DRIVE%%WIN_REST%"

:: Clean conflicting terminal flags and isolate toolchain
set "PATH=%MSYS_ROOT%\mingw64\bin;%MSYS_ROOT%\usr\bin;%PATH%"
set "CHERE_INVOKING=1"
set "MSYSTEM=MINGW64"

:: <nul prevents deadlock with any inherited Git Bash/mintty pty
"%BASH_EXE%" -c "cd '%UNIX_PATH%' && ./generate_assets.sh %~2" <nul

set "PREBUILD_EXIT=%ERRORLEVEL%"

if %PREBUILD_EXIT% neq 0 (
    echo [POWDER Error] Asset pipeline returned exit code %PREBUILD_EXIT%.
    exit /b %PREBUILD_EXIT%
)

exit /b 0