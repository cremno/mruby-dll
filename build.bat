@ECHO OFF
REM ruby create_def.rb
CD mruby
RD /S bin\dll
RD /S build\dll
SET MRUBY_CONFIG=..\build_config.rb
RUBY minirake
MD bin\dll
CD build
MD dll
CD dll
RC /NOLOGO /FO mruby.res ..\..\..\mruby.rc 
LINK /NOLOGO /LTCG /DLL /MACHINE:X86 /OUT:..\..\bin\dll\mruby.dll /DEF:..\..\..\mruby.def ..\host\lib\libmruby.lib mruby.res
LINK /NOLOGO /LTCG /SUBSYSTEM:CONSOLE /MACHINE:X86 /OUT:..\..\bin\dll\mruby.exe ..\host\tools\mruby\mruby.obj ..\host\src\print.obj ..\..\bin\dll\mruby.lib
LINK /NOLOGO /LTCG /SUBSYSTEM:CONSOLE /MACHINE:X86 /OUT:..\..\bin\dll\mirb.exe ..\host\tools\mirb\mirb.obj ..\host\src\print.obj ..\..\bin\dll\mruby.lib
LINK /NOLOGO /LTCG /SUBSYSTEM:CONSOLE /MACHINE:X86 /OUT:..\..\bin\dll\mrbc.exe ..\host\tools\mrbc\mrbc.obj ..\host\src\print.obj ..\..\bin\dll\mruby.lib
EXPLORER ..\..\bin\dll
CD ..\..\..
