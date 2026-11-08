@echo off
setlocal enabledelayedexpansion

set "REPO_ROOT=%~1"
set "TARGET_DIR=%~2"

if "%REPO_ROOT%"=="" set "REPO_ROOT=%~dp0..\.."
if "%TARGET_DIR%"=="" set "TARGET_DIR=%~dp0Release"

pushd "%REPO_ROOT%"
set "REPO_ROOT=%CD%"
popd

:: Check if SDL.dll already exists at target
if exist "%TARGET_DIR%\SDL.dll" (
    echo [POWDER Post-Build] SDL.dll already present in target output.
    exit /b 0
)

:: Detect SDL directory (inside repo root, parent directory, or C:\)
set "SDL_DLL="
if exist "%REPO_ROOT%\SDL-1.2.15\lib\x86\SDL.dll" (
    set "SDL_DLL=%REPO_ROOT%\SDL-1.2.15\lib\x86\SDL.dll"
) else if exist "%REPO_ROOT%\..\SDL-1.2.15\lib\x86\SDL.dll" (
    set "SDL_DLL=%REPO_ROOT%\..\SDL-1.2.15\lib\x86\SDL.dll"
) else if exist "C:\SDL-1.2.15\lib\x86\SDL.dll" (
    set "SDL_DLL=C:\SDL-1.2.15\lib\x86\SDL.dll"
)

if not defined SDL_DLL (
    echo [WARNING] Could not locate SDL.dll to copy.
    echo Expected location: "%REPO_ROOT%\SDL-1.2.15\lib\x86\SDL.dll"
    exit /b 0
)

echo [POWDER Post-Build] Staging SDL.dll to %TARGET_DIR%...
copy /Y "%SDL_DLL%" "%TARGET_DIR%\" >nul

if exist "%TARGET_DIR%\SDL.dll" (
    echo [POWDER Post-Build] SDL.dll staged successfully.
) else (
    echo [ERROR] Failed to copy SDL.dll.
)

exit /b 0