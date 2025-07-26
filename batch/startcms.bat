@echo off

rem Normal way to start VM/380. By default it automatically
rem logs on to the GCCCMS userid. It takes a parameter for
rem a different sort of startup. Use the word "null" to not
rem do anything at all


if %1. == . goto normal
set HERCULES_RC=%1.rc
goto finnorm
:normal
set HERCULES_RC=autologgcc.rc
:finnorm
pushd %VM380%
hercules -f vm380.conf >hercules.log
popd
set HERCULES_RC=
