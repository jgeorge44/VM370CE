@echo off

rem used to transfer files from PC to mainframe


set script=putcms
if %1. == . goto usage
if %2. == binary. goto binmode
goto fin
:binmode
set script=putcmsb
:fin


del %VM380%\putcms.zip
zip -0Xj %VM380%\putcms %1
pushd %VM380%
call runcms %script%.exec putcms.txt putcms.zip none
del putcms.txt
del putcms.zip
popd


goto exit
:usage
echo usage: putcms ^<files^> [binary]
:exit
