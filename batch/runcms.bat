@echo off
rem You can copy this to your path if you want
rem and run CMS from batch jobs
rem You can also simply add the %VM380% directory
rem to your path
rem This proc gives you a clean A disk (291 is erased)
rem and there is a D disk which is your normal A (191)
rem there's also a clean B, plus a C which you can use freely
rem tap1 is available for input, tap2 for output

rem a typical use of this script would be to provide a
rem zip file containing some source code, an exec that
rem will invoke mvsunzip to extract the files from that
rem zip file, then compile the source, the copy the
rem resulting module to the clean B disk, then use vmarc
rem to dump the modules to the provided output tape.
rem the tapes will be created automatically. the invoker
rem just needs to provide the single input file which
rem will be put on that tape, and be prepared to receive
rem a single output file which will be extracted from
rem the tape. the creation and extraction process will
rem be done "sensibly" so long as you let it know whether
rem it is a binary (default) or ascii (ie text) file.
rem e.g. if you write a VB output file and say that it is
rem ascii, it will be converted from EBCDIC to ASCII and
rem the BDW/RDW will be stripped and newline characters
rem will be added to each line. Pretty cool, eh?

set rcfile=autorun.rc

if %1. == . goto usage
if not exist %1 goto usage

if %2. == . goto usage

set in=none
if %3. == . goto noin
if %3. == none. goto noin
set in=%3
:noin

set out=none
if %4. == . goto noout
if %4. == none. goto noout
set out=%4
:noout

set tranin=binary
set tranintape=pctomf_bin
if %5. == . goto fintranin
if %5. == binary. goto fintranin
if not %5. == ascii. goto usage
set tranin=ascii
set tranintape=pctomf_text
:fintranin

set tranout=binary
set tranouto=
if %6. == . goto fintranout
if %6. == binary. goto fintranout
if not %6. == ascii. goto usage
set tranout=%6
set tranouto=-a -s -z
:fintranout


:text
:normal
rem copy input data file (typically .zip)
del %VM380%\IO\hercauto.dat
rem create dummy file
echo dummy >%VM380%\IO\hercauto.dat
copy %VM380%\IO\%tranintape%.tdf %VM380%\IO\pctomf.tdf
if %in% == none goto noin2
copy %in% %VM380%\IO\hercauto.dat

rem now we capture the source in vmarc format if requested
if %BUILDVM%. == . goto nobvm

pushd %VM380%
echo USERID GCCCMS>hercauto.exec
type dumpsrc.exec >>hercauto.exec
hetinit -n IO\mftopc.het
set HERCULES_RC=%rcfile%
rem hercules -f vm380.conf 2>&1 | tee hercsrc.log
hercules -f vm380.conf >hercsrc.log
popd
hetget -n %VM380%\IO\mftopc.het cmssrc.vmarc 1 f 80 80

:nobvm

:noin2


echo USERID GCCCMS>%VM380%\hercauto.exec
type %1 >>%VM380%\hercauto.exec
pushd %VM380%

rem initialize tape, typically to receive vmarc
hetinit -n IO\mftopc.het
set HERCULES_RC=%rcfile%


rem If you want to run Hercules as a batch tool and
rem not see any execution, you just need to redirect
rem both stdout and stderr

rem hercules -f vm380.conf 2>&1 | tee hercules.log
hercules -f vm380.conf >hercules.log
popd


copy %VM380%\hercules.log %2

rem extract output data file (typically .vmarc if binary)
if %out% == none goto noout2
hetget -n %tranouto% %VM380%\IO\mftopc.het %out% 1 f 80 80
:noout2

GOTO EXIT
:USAGE
echo Usage example: runcms my.exec output.txt [my.zip] [my.vmarc] [binary] [binary]
:EXIT
set HERCULES_RC=
