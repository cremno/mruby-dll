@echo off
rem ruby create_def.rb
set MRUBY_DLL_DIR=%cd%
set MRUBY_CONFIG=%MRUBY_DLL_DIR%\build_config.rb
cd mruby
ruby minirake
if errorlevel 1 goto END
set INSTALL_SHARED_DIR=%cd%\bin\shared
set BUILD_SHARED_DIR=%cd%\host\bin\shared
set HOST_PATH=%cd%\build\host
set _LIB=%LIB%
set LIB=%LIB%;%HOST_PATH%\lib;%HOST_PATH%\tools;%HOST_PATH%\src
md %INSTALL_SHARED_DIR% %BUILD_SHARED_DIR% 2> nul
rc /nologo /fo %BUILD_SHARED_DIR%\mruby.res %MRUBY_DLL_DIR%\mruby.rc
cd %BUILD_SHARED_DIR%
link /nologo /ltcg /dll /def:%MRUBY_DLL_DIR%\mruby.def libmruby.lib mruby.res
link /nologo /ltcg mrbc\mrbc.obj print.obj mruby.lib
link /nologo /ltcg mruby\mruby.obj print.obj mruby.lib
link /nologo /ltcg mirb\mirb.obj mruby.lib
robocopy . %INSTALL_SHARED_DIR% mruby.dll mruby.lib *.exe > nul
set LIB=%_LIB%
set _LIB=
set HOST_PATH=
set BUILD_SHARED_DIR=
set INSTALL_SHARED_DIR=
:END
set MRUBY_CONFIG=
cd %MRUBY_DLL_DIR%
set MRUBY_DLL_DIR=
