@echo off
rem This batch file erases a minidisk

if %1. == . GOTO USAGE
pushd %VM380%
set rcfile=erasemini
echo /access %1 b (erase >erasemini2.rc
echo pause 2 >>erasemini2.rc
echo /copy tape module * = = b >>erasemini2.rc
echo pause 2 >>erasemini2.rc
echo /erase tape module b >>erasemini2.rc
call startcms %rcfile%
rem del erasemini2.rc
popd

GOTO EXIT
:USAGE
echo Usage example: erasemini 291
:EXIT
