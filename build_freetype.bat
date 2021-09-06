@ECHO off

PUSHD %~dp0

:BUILD_LIBPNG
cd submodules/freetype

@IF EXIST .build GOTO HAS_CONFIG
@copy ..\\CMakeLists.txt .\\CMakeLists.txt /V /Y
mkdir .build
cd .build
cmake ../. -G"Visual Studio 16 2019" -Ax64 -Thost=x64 -DMSVC_STATIC_LIB="ON"
@GOTO DOBUILD

:HAS_CONFIG
cd .build
@GOTO DOBUILD

:DOBUILD
cmake --build . --config Debug
cmake --build . --config Release

@IF %ERRORLEVEL% EQU 0 (
   GOTO SUCCESS
) else (
   GOTO HADERROR
)

:SUCCESS
@POPD
@mkdir dist\\win\\x64
@copy .\\submodules\\freetype\\.build\\Debug\\freetyped.lib /V /Y dist\\win\\x64
@copy .\\submodules\\freetype\\.build\\Debug\\freetyped.pdb /V /Y dist\\win\\x64
@copy .\\submodules\\freetype\\.build\\Release\\freetype.lib /V /Y dist\\win\\x64

@ECHO SUCCESS!
@EXIT /b 0

:HADERROR
@ECHO.
@ECHO  [31m=================FAILED=================[0m
@POPD
rd /s /q ./.build
@EXIT /b %ERRORLEVEL%
