@echo off
rem This batch file dumps a minidisk into AWS format

if %1. == . GOTO USAGE
if %2. == . GOTO USAGE
pushd %VM380%
set rcfile=dumpmini
echo /access %1 b >dumpmini2.rc
hetinit -n dumpmini.aws
call startcms %rcfile%
popd
hetget -n %VM380%\dumpmini.aws %2 1 f 80 80
del %VM380%\dumpmini.aws

GOTO EXIT
:USAGE
echo Usage example: dumpmini 291 tape.vmarc
:EXIT
