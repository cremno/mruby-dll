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
set LIB=%LIB%;%HOST_PATH%\lib;%HOST_PATH%\tools;%HOST_PATH%\src;%HOST_PATH%\mrbgems
rc /nologo /Iinclude /fo %BUILD_SHARED_DIR%\mruby.res %MRUBY_DLL_DIR%\mruby.rc
md %INSTALL_SHARED_DIR% %BUILD_SHARED_DIR% 2> nul
cd %BUILD_SHARED_DIR%
link /nologo /ltcg /machine:x86 /dll /def:%MRUBY_DLL_DIR%\mruby.def libmruby.lib mruby.res
link /nologo /ltcg /machine:x86 mrbc\mrbc.obj print.obj mruby.lib mruby.res
link /nologo /ltcg /machine:x86 mruby-bin-mirb\tools\mirb\mirb.obj print.obj codegen.obj string.obj mruby.lib mruby.res
link /nologo /ltcg /machine:x86 mruby-bin-mruby\tools\mruby\mruby.obj print.obj mruby.lib mruby.res
for %%f in (mruby.dll mruby.lib *.exe) do copy %%f %INSTALL_SHARED_DIR% > nul
:END
endlocal
