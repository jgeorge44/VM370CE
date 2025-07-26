SixPack 1.3 Read Me
===================



This update to the "VM370/R6 Sixpack" includes several new enhancements which
have been introduced since 1.2 was released.  In particular the system now
includes Full Screen Support via DIAG58 for applications, autodetection of 
screen size, and the MECAFF package of full screen aplications, FSHELP, FSLIST
and the EE Editor.

Please report any issues on the "h390-vm@groups.io" mailing list.


===================== Summary of changes from 1.2 =============================

1. Fixed lower case file names for UNIX scripts.

2. Installed V3.1 LDF and Diag58 support. Changed terminal definitions in
   DMKRIO so they auto negotiate screen size.

3. Changed 3270 config so "Escape" is "escape" as needed for ind$file.

4. Changed sixpack.cmd so that 3270 sessions are started in separate window.

5. Installed MECAFF tools.

6. Cleaned up GCC 491 disk.

7. Fixed help for ee.

8. Updated WC3270 to version 3.6ga5.

9. Updated "EDIT" to work with wide screen terminals.

10. Updated "Help Welcome", cp query, cms query and DMKBOX to display V1.3.

11. Applied fix to DMSTYP so it does not crash CMS when it reads a zero length
    line.  NOTE:- Other programs may still crash or behave in unpredicable ways.
    QSAM returns RC=8 Length Error from GET when when reading a zero length
    record. It's recoverable so programs which ignore it work OK.

12. Installed the updated GCC compiler.

13. Generated the WATFIV compiler and copied to "Y" Disk. Copied the user guide
    "WATFIVUG LISTING" to the 19D/U Help disk.

14. Enhancements and Fixes from Bob Polmanter & Peter Coghlan

    -  Installed new GCCLIB which includes work by Adrian Sutherland and Bob
       Bolch to enhance it's capability and stability which in turn results in
       imrprovements in the usability and stability of bREXX.  This also
       eliminates the undesirable abuse of the DOSTRANS field in NUCON.  GCCLIB
       has been further tweaked to not require any anchor in NUCON by obtaining
       the information required from RESLIB instead.  It has also been further
       modified to avoid writing to itself and it is now loaded into shared
       segments with a fallback to using RESLIB when the shared segment version
       is unavailable due to virtual machine size etc.  Bug fixed to avoid a
       program check when allocating non-page-aligned memory in cmsmmap().
       Problems generating ordinarly PLISTs by new C code worked around by
       reverting to original assembly code.  Some other minor tweaks and bug
       fixes.  Version change to 1.3.1 to reflect it's original heritage. 

    -  Fixed minor bugs in bREXX queue / push / pull / parse pull.

    -  Bug fixed in OS/360 COBOL compiler which caused it to be sensitive to
       whatever was present in memory before it was run.  This resulted in 
       abends and other spurious behaviour depending on what was in the user
       area before the compiler was run.

    -  Bug fixed in CPWATCH whereby "ACTIVE" and "INACTIVE" counts on SYSTEM
       STATUS screen were swapped over.  Tweak also made so that the CP
       release string shown on the bottom of same screen is not completely
       mangled by HRC370DK.

    -  Installed XCOMPARE to make file comparisons easier.

    -  Minidisks owned by RSCS and RSCS1 transferred to MAINT as is the case
       with VM/SP.  This will make performing future RSCS upgrades much more
       straigthforward.  See RSCS MEMO on MAINT 09F for more details.

    -  Help system updated to provide information on new commands, subcommands
       and options.  Missing information corrected and typograpical errors fixed
       in some existing help files.  GCCLIB documentation updated.

    -  ECPS:VM enabled in Hercules configuration as bugs which caused problems
       with this in the past have now been fixed in all Hercules variants.

    CP New Features
    ===============

    -  HRC058DK - DIAGNOSE 58 full screen support for 3270 terminals.

    -  HRC065DK - DIAGNOSE 7C Logical Device Support Facility (LDF).

    -  HRC068DK - Shadow Table Bypass support for MVS 3.8 or VM/370 guest
                  virtual machines.  This is a performance enhancement for 
	          VIRT=REAL guests.  The IBM equivalent of this enhancement
	          was introduced via SEPP/BSEPP.

    -  HRC072DK - New DIAGNOSE code X'8C' Return 3270 Device Characteristics
                  (part of DIAG58V3)

    -  HRC073DK - 3278 Model 5 terminal support (part of DIAG58V3)

    -  HRC075DK - Alternate CP nucleus support.  Allows the specification of a
	          specific volume name for the SYSERR, SYSCKP, and SYSWRM areas
                  in DMKSYS, allowing the placement of a CP nucleus on another 
	          volume and the ability to IPL from that alternate volume and
	          retain your spool files.

    -  HRC076DK - Support for the CP SHUTDOWN REIPL command.

    -  HRC106DK/HRC077DK - Full CP support for 3380 DASD - allows CP to reside
	          on 3380-A/E/K models, including 3380 T-disks, spool and page
                  space, directory, saved systems, warmstart, and ckpt. Prior
	          to this enhancement, 3380 support presently in Sixpack was
	          limited to attached/dedicated devices to a guest, or for
                  general CMS minidisk use, and even then there was a bug in 
	          CMS for formatting 3380 minidisks; see below.

    -  HRC107DK/HRC109DK - CP QUERY USERID command shows the userid and system
                  id that you are logged on to.

    -  HRC108DK - SYSID support - provides for a unique system or organization
	          name adjacent to the RUNNING status area of 3270 displays and
                  on print separator pages via SYSID macro in DMKSYS.

    CP Bug Fixes:
    =============

    -  HRC037DK - Fix incomplete support for 3880 storage controllers.

    -  HRC038DK - Fix bug in QUERY ALLOC command resulting in extraneous output.

    -  HRC039DK - Fix numerous issues with DASD attached to SYSTEM
                  (attaching/detaching and vary on/offline).

    -  HRC040DK - Fix FRE013 failure in ATTACH/DETACH CHANNEL commands.

    -  HRC041DK - Fix for VARY ONLINE/OFFLINE of attached/dedicated devices.

    -  HRC042DK - Fix mislaid message introduced by IBM R12646DK.

    -  HRC043DK - Fix for QUERY PFnn for PF13-PF24.

    -  HRC066DK - Bug fixes for AP support (5 modules).

    -  HRC071DK - Fix distorted VM/370 logos on DIAL drop and CP ENABLE ALL
                  (part of DIAG58V3)

    -  HRC074DK - Fix for CP dispatcher; not detecting that CP PER is in use
                  when ECPS:VM is active.

    CMS Enhancements and Bug Fixes:
    ===============================

    -  HRC013DS - CMS support of 3380:  Fix bug in FORMAT command.

    -  HRC014DS - CMS support of 3380: allow CMS nucleus to reside on a 3380
                  minidisk and IPL 190 / IPL CMS from a 3380. 

    -  HRC015DS - Prevent UPDATE command from failing when filesystem API is
                  updated (ie when HRC105DS is installed).

    -  HRC073DS - CMS EDIT support for 3278 Model 5 terminals.

    -  HRC074DS - Problem with status line in CMS EDIT when using 3278 Model 5
                  terminals fixed.

    -  HRC105DS - Extend FSTD/STATEFST for greater compatibility with VM/SP.
                  This allows some applications from VM workshop tools tapes
                  etc which target VM/SP to be built and used successfully.

    -  HRC106DS - Accept FORM=E on FSxxxx  (e.g., FSREAD, FSOPEN,etc) macros
	          for greater compatibility with VM/SP similar to HRC105DS.

    -  HRC107DS - Fix bug introduced by HRC105DS resulting in the assembler and
                  some compilers (notably PL/I) placing TEXT/LISTING files on
                  unexpected minidisks.

    -  HRC325DS - Fix truncated first line of QUERY FILEDEF output for "short"
                  filedefs (such as TERMINAL for example).

    -  HRC343DS - Fix decimal data exception which can arise when using $DUP
                  macro in the CMS editor after using commands such as CHANGE.

    -  HRC373DS - Allow SYSPROF EXEC (required for REXX support) to execute
                  when PROFILE EXEC A does not exist.

    -  HRC381DS - Not actually CMS.  This one fixes a serious bug in CHECK380
                  which is called by GCC EXEC Y i.e when compiling C programs.
                  The bug can result in CMS system failures some time later.

15. Terminal 0C1 is no longer reserved for an MVS master console as this tended
    to cause confusion when it was found to not allow logins to VM.  In cases 
    where an MVS master console is required, the previous behaviour can be
    restored by adding the line "CP DISABLE 0C1" to AUTOLOG1's PROFILE EXEC.


Known issues in Sixpack 1.3:
============================

    -  The bREXX interpreter is still somewhat unstable.  For example, 
       attempting to run a REXX program from within another REXX program
       results in a program check.

    -  The GCCLIB C runtime library may emit messages such as:
               WARNING: MEMORY FREED (80 BYTES LEAKED)
       when C programs linked with it exit (including the bREXX interpreter).

    -  Exiting from EDIT or going to CMS subset on a 3270 terminal results
       in MORE... status requiring the output area to be cleared before the
       Ready; prompt is displayed.  This is probably due to the way 3270
       highlighting etc is implemented in the editor.

    -  The SCAN utility issues bogus error messages when no files exist
       matching the file specification provided, when no disk is accessed as
       A and in other unusual but otherwise benign circumstances.

    -  Attempting to CMS FORMAT a disk using an already in use drive letter
       results in an operation exception.

    -  Using the DISCARD CP command prefix on it's own results in a PROG CHECK.
       Ready; T=0.01/0.02 00:21:05
       DISCARD 
       DMSITP143T SPECIFICATION EXCEPTION OCCURRED AT 0178D6 IN SYSTEM ROUTINE
                , RE-IPL CMS.
       CP ENTERED; DISABLED WAIT PSW '00020000 4001B636'

    -  HRC370DK mangles the CP release identification string.  This has been
       worked around in many cases where it is an issue, however, it can still
       show up in guest operating systems and utilities which try to read it,
       DUMPSCAN for example.

    -  Attempting to log on to VM/370 using an emulated 2741 terminal via a
       Hercules emulated 2703 device results in a FRE001 crash due to a bug in
       IBM update R12126DK.  The crash can be avoided by commenting out R12126DK
       in DMKCNS AUXR60 (which requires R12733DK, R13198DK and R13158DK be
       commented out also as R12126DK is a prerequisite for them) however, the
       consequences of doing this are unknown.  A better solution would be to
       develop a fix for the bug in R12126DK.  Successful login using a 2741
       also requires patches to commadpt.c to tweak the translate tables and to
       tend the scope of the crlf parameter.
