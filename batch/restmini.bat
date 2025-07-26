@echo off

rem This batch file restores a minidisk from a vmarc backup


if %1. == . GOTO USAGE
if %2. == . GOTO USAGE
copy /b %1 %VM380%\IO\hercauto.dat
pushd %VM380%
set rcfile=restmini
echo /access %2 a >restmini2.rc
call startcms %rcfile%
popd
del %VM380%\IO\hercauto.dat

GOTO EXIT
:USAGE
echo Usage example: restmini disk.vmarc 291
:EXIT
