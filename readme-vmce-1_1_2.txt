The VM Community Edition V1 R1.2 provides various fixes for issues opened
against the V1 R1.1 version of the Community Edition.

Contributor list includes: Dave Wade, Peter Coghlan, Bob Polmanter, Adrian
Sutherland, Rene Ferland, Joe George, Mike Grossman, Mark Stevens, Mark
Waterbury, and Bob Bolch.

Many others contributed to the ideas implemented in this release.

Refer to https://github.com/s390guy/vm370/issues to see issues opened
for the 1.1.1 release. Those marked "fixed in next release" are included in
this 1.1.2 release.

===============================================================================

Changes in Version 1 Release 1.2:

1. The vm370ce.conf file has been updated to go back to using the ARCHMODE
   statement to replace the Hyperion specific ARCHLVL statement.

2. These Hercules configuration file statements have been removed:
   HERCPRIO, CPUPRIO, DEVPRIO

3. The Hercules configuration file includes these statements:

   ECPSVM          YES
   # Certain assists need to be disabled on Hercule Hyperion
   # release earlier than 4.4.0.xxxxx, which fixes an issue where
   # floating point register values were not saved and restored during
   # VM dispatcher operation. See additional notes at the end of this
   # document

   # Add the statement below, if a pre-4.4.0.xxxxx version of Hyperion
   # is being used, without the fix for HERCULES ECPSVM issue #382 (closed).
   # ECPSVM        DISABLE DISP1 DISP2

   See the section "Important ECPSVM Considerations" at the end of this
   document for more details.

4. Add CP update HRC375DK to update branding to Release 1 Version 1.2

5. Add CP update HRC450DK to support the APL character set for 3278 emulation
   programs.

6. Add CP update HRC451DK to show lowercase alphabetics in DISPLAY storage
   commands.

7. Add CP update HRC452DK to support the ;BASE specification on DISPLAY storage
   commands.

8. Add CMS update HRC426DS to update Q CMSLEVEL command and the default startup
   message for Release 1 Version 1.2.

9. Correct an issue where attempting to CMS FORMAT a disk using a drive letter
   which is already in use resulted in an operation exception. The FORMAT
   MODULE had been improperly generated. Used CMSGEND to rebuild the MODULE.

10. Correct an issue in the FLIST command. When a file in the list was viewed
    with the CMS EDIT command, a residual line from the file was left when the
    EDIT command ended. The line after the FLIST PF key line contained a line
    from the file.

11. Corrected miscellaneous errors, and typos in the HELP files:
    SFBROWSE

12. Rene Ferland created Help files for CMS/DOS commands:
    AMSERV, ASSGN, DLBL, DOSLIB, DOSLKED, DSERV, ESERV, FETCH, LISTDS, LISTIO,
    OPTION, OPTION, PSERV, RSERV, SSERV SSERV.

13. Updated the FCOBOL command for DOS/COBOL compiler.

14. Added a VM/370 specific version of the BLOCKTAP utility command used to
    read certain VMSHARE and WATERLOO tapes. BLOCKTAP intercepts the TAPEIO
    calls from the TAPE and VMFPLC2 commands in order to create or read larger
    blocks of tape, which increased the capacity of those old tape reels.

15. Added CMS update HRC429DS to EXECIO to assign one blank character as the
    value, if an EXECIO STRING operand is omitted. This copies the behavior of
    VM/SP and later versions of EXECIO.

16. Added CMS update HRC428DS to EXECIO to correct an error when the
    record number is specified on a multirecord read or write. The same record
    was being read or written, over and over. After the fix, the initial read
    or write should process the specified record, and then process subsequent
    records sequentially after that.

17. Corrected the RSCS MEMO on the MAINT 5E5 disk to say that VMFLOAD should
    specify the build list file named DMTLOAD EXEC instead of CPLOAD EXEC.

18. Added a missing comment for a disk at real address 149. The disk is used in
    the procedure to run a TK4- version of MVS under VM.

19. Reword the message issued when using the GCCLIB C runtime code segment in
    a 16M virtual machine. In smaller virtual machines, the C runtime code is
    loaded in a saved segment. In a 16M virtial machine, the C runtime is
    loaded inside the virtual machine.

20. Added CMS update HRC430Ds to correct an ABEND when no CP command is
    specified as operands of the DISCARD command.

21. Fixed an issue with the FLIST command leaving residual data at the bottom
    of the screen.

22. Added CMS update HRC431DS to add function to the NUCXMAP command. It adds
    name field processing, and support for options: SEGMENT, NOSEGMENT,
    SEGINFO, STACK, LIFO, and FIFO.

23. Correct the define for the CMSmemoryFree function in the GCC compiler file
    CMSSYS.H

24. Correct the register usage in the @@CMSCMD entry point with calltype X'0B'.

25. ** removed **


26. Many system HELP files have been added or updated. Mark Stevens and Dave
    Wade led that effort.

27. The ASSIST interpretor and documentation have been added.

28. The MECAFF 3270 tools (EE, IND$FILE, XXLIST, and so on ) have been updated
    to use the newest GCC runtime environment code. Two versions of the
    executables are provided. If the GCC runtime environment saved segment is
    loaded, a dynamically linked version of the utilities is loaded. The
    command MODULE files are much smaller, and access the GCC runtime code
    which is shared by all users. If the segment is not loaded, a version of
    the MODULEs that does not use the shared runtime library is used
    automatically. The MECAFF source is maintained on the MECAFF user ID.

29. The PL360 HELPCMD has been updated, and a PL360MAN LISTING file was added to
    provide usage details. A BOTTLES PL360 sample program is available on the
    19D U disk.

30. Tom Chandler provided the KICKS install manual, and a KICKS server was
    provide based on the version uploaded by Rene Ferland.

31. When moving to this new release of the VM Community Edition from the V1
    R1.1 release, the VM50U0 volume (VM50U0.cckd) and it's shadow disk file can
    be copied to your new VM release directories to retain any files on the
    CMSUSER ID.

32. If you added any minidisks to the disk volume (VM50U1) in V1 R1.1, then you
    may copy the VM50U1 disk (and its shadow file) to the new VM release
    directories. Then add any new users to the new USER DIRECT file. This
    provides the ability to port user IDs you add to a new version of the VM
    system.

33. Corrected a BREXX bug in the comparison of a loop control variable used
    to control a stemmed variable search, with the ".0" member of the stem,
    after the loop ends. Thank you to Adrian Sutherland.

34. Added the XNET server to provide a VM Passthru type function between
    multiple VM systems in multiple Hercules instances. The
    facility is documented in the "XNET Configuration and Usage Guide"
    located in the same directory as this readme file. An XNET server
    is defined in the USER DIRECT file. You must define CTCA adapters
    for each Hercules system in an XNET configuration and connect them.
    Use of bisynch lines for XNET is not recommended.

35. Added the SENDFILE, RECEIVE, and MAIL commands from Kevin Jordan.

36. The ASSIST assembler facility was added by Mark Stevens.

37. The KICKS facility is installed.

38. A missing update caused errors with the PER command and ECPSVM. It was
    restored.

39. Dave Wade updated the C fopen statement to support an IBM C/370
    compatible syntax for providing file characteristics (RECFM and LRECL).

40. The Hercules log file is now successfully written in Windows.

41. Pascal is updated to the current 2021.03 release by Bernd Oppolzer.

42. New HELP files for the SAS RXUSERFN Rexx function package have been added.
    This package supports building fullscreen applications, like the new
    fullscreen HELP support, in REXX.

43. This release provides a new fullscreen HELP command for 3270 users.
    HELP will still run in linemode on a TELNET connection. The new HELP
    provides MENU layers to more easily navigate to the information you need.
    (The older FSHELP command is incompatible with the new HELP file namimg
    conventions and is removed from the system.) 






================================================================================

Important ECPSVM Considerations:

       A REXX utility program in this release exposed a bug in Hercules ECPSVM
       processing. The bug has been detected only in the SDL Hercules Hyperion
       version, not the older Hercules 3.xx versions.

       To see if your version has the bug, issues these commands from MAINT:

       VMSETUP CP
       SNTPARS DMKSNT ASSEMBLE F

       (The failure is intermittent, so you might need to run this a few
       times.)

       SNTPARS is a REXX utility that displays the saved segment area
       definitions from the DMKSNT ASSEMBLE file. It uses a GCCLIB math routine
       in some specific way that is seen as an 0CC program check with junk in
       various floating point registers.

       Until you have Hyperion release 4.4.0 or later installed, containing the
       fix, you should replace ECPSVM YES in the vm370ce.conf file with these
       lines:

       ECPSVM YES
       ECPSVM DISABLE DISP1 DISP2

================================================================================

Known issues in VM Community Edition V1 R1.2:

   -  Exiting from EDIT or going to CMS subset on a 3270 terminal results in
      MORE... status requiring the output area to be cleared before the Ready;
      prompt is displayed. This is probably due to the way 3270 highlighting,
      and so on is implemented in the editor.

   -  Attempting to log on to VM/370 using an emulated 2741 terminal via a
      Hercules emulated 2703 device results in a FRE001 crash due to a bug in
      IBM update R12126DK.  The crash can be avoided by commenting out R12126DK

      In DMKCNS AUXR60 (which requires R12733DK, R13198DK and R13158DK be
      commented out also as R12126DK is a prerequisite for them) however, the
      consequences of doing this are unknown.  A better solution would be to
      develop a fix for the bug in R12126DK.  Successful login using a 2741
      also requires patches to commadpt.c to tweak the translate tables and to
      extend the scope of the crlf parameter.
