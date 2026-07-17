@echo off
setlocal
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" x64 >nul 2>&1
msbuild -m -p:Configuration=Release -p:Platform=x64 -p:UseSDL3=false "-target:Cataclysm-test-vcpkg-static" "msvc-full-features\Cataclysm-vcpkg-static.sln"
endlocal
