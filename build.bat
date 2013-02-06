@echo off
if "%1" equ "mingw" (
  call build-mingw.bat
  exit /b
)
setlocal
set MRUBY_DLL_DIR=%cd%
set MRUBY_CONFIG=%MRUBY_DLL_DIR%\build_config.rb
cd mruby
ruby minirake
if errorlevel 1 goto :end
set INSTALL_SHARED_DIR=%cd%\bin\shared
set HOST_PATH=%cd%\build\host
set BUILD_SHARED_DIR=%HOST_PATH%\bin\shared
set LIB=%LIB%;%HOST_PATH%\lib;%HOST_PATH%\tools;%HOST_PATH%\src
md %INSTALL_SHARED_DIR% %BUILD_SHARED_DIR% 2> nul
rc /nologo /fo %BUILD_SHARED_DIR%\mruby.res %MRUBY_DLL_DIR%\mruby.rc
cd %BUILD_SHARED_DIR%
link /nologo /ltcg /dll /def:%MRUBY_DLL_DIR%\mruby.def libmruby.lib mruby.res
link /nologo /ltcg mrbc\mrbc.obj print.obj mruby.lib
link /nologo /ltcg mruby\mruby.obj print.obj mruby.lib
link /nologo /ltcg mirb\mirb.obj mruby.lib
for %%f in (mruby.dll mruby.lib *.exe) do copy %%f %INSTALL_SHARED_DIR% > nul
:END
endlocal
