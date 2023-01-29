@echo off

pushd %~dp0

@IF NOT EXIST build mkdir build

cd build
@IF %ERRORLEVEL% NEQ 0 GOTO HADERROR

cmake ..
REM cmake --build . --config Debug
cmake --build . --config Release

@IF %ERRORLEVEL% NEQ 0 GOTO HADERROR

:SUCCESS
@popd
@echo SUCCESS!
@exit /b 0

:HADERROR
@popd
@echo  =================FAILED=================
@exit /b %ERRORLEVEL%
