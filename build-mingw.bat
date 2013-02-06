@echo off
setlocal
set MRUBY_DLL_DIR=%cd%
cd mruby
ruby minirake
if errorlevel 1 goto :end
set INSTALL_SHARED_DIR=%cd%\bin\shared
set HOST_PATH=%cd%\build\host
set BUILD_SHARED_DIR=%HOST_PATH%\bin\shared
md %INSTALL_SHARED_DIR% %BUILD_SHARED_DIR% 2> nul
windres %MRUBY_DLL_DIR%\mruby.rc %BUILD_SHARED_DIR%\mrubyres.o
cd %BUILD_SHARED_DIR%
gcc -s -shared -Wl,--out-implib,libmruby.a -o mruby.dll %MRUBY_DLL_DIR%\mruby.def %HOST_PATH%\lib\libmruby.a mrubyres.o
gcc -s -o mrbc.exe %HOST_PATH%\tools\mrbc\mrbc.o %HOST_PATH%\src\print.o libmruby.a
gcc -s -o mruby.exe %HOST_PATH%\tools\mruby\mruby.o %HOST_PATH%\src\print.o libmruby.a
gcc -s -o mirb.exe %HOST_PATH%\tools\mirb\mirb.o libmruby.a
for %%f in (mruby.dll libmruby.a *.exe) do copy %%f %INSTALL_SHARED_DIR% > nul
:end
endlocal
