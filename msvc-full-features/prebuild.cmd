@echo off
SETLOCAL

cd ..\msvc-full-features
set PATH=%PATH%;%VSAPPIDDIR%\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\Git\cmd
for /F "tokens=*" %%i in ('git describe --tags --always --dirty --match "cdda-experimental-*"') do set VERSION=%%i
if "%VERSION%"=="" (
set VERSION=Please install `git` to generate VERSION
)
findstr /c:%VERSION% ..\src\version.h > NUL 2> NUL
if %ERRORLEVEL% NEQ 0 (
echo Generating "version.h"...
echo VERSION defined as "%VERSION%"
>..\src\version.h echo #define VERSION "%VERSION%"
)

if not exist "..\objwin" mkdir "..\objwin"
where python > NUL 2> NUL
if not errorlevel 1 (
python ..\tools\generate_builtin_mods.py --source ..\data\mods --output ..\objwin\builtin_mods_generated.h
) else (
where py > NUL 2> NUL
if errorlevel 1 (
echo Python 3 is required to generate the built-in mod manifest.
exit /B 1
)
py -3 ..\tools\generate_builtin_mods.py --source ..\data\mods --output ..\objwin\builtin_mods_generated.h
)
if errorlevel 1 exit /B %ERRORLEVEL%
