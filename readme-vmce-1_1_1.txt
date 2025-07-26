The VM Community Edition V1 R1.1 provides various fixes for issues opened against the
V1 R1.0 version of the Community Edition

Contributor list includes: Dave Wade, Peter Coghlin, Bob Polmanter, Adrian Sutherland,
and Bob Bolch. Many others contributed to the ideas implemented in this release.
Joe George identified many issues so thanks to his excellent testing strategies.


=================
Changes in Version 1 Release 1.1:

1. All disk shadow files have been merged into the base cckd files in the
   disks subdirectory. The configuration file specifies that shadow files will
   be created when you start using the release. Erasing the files in the
   disks\shadow subdirectory will undo any changes you have made to the system.

2. All disks have been initialized with the -z compression option. Three disks had
   used -bz2 compression in V1 R1.0. Those disks were updated.

3. The vm370ce.conf file has been updated to specify the ARCHLVL statement to replace
   the deprecated ARCHMODE statement.

4. Blanks have been removes from the Hercules directory name to prevent problems
   on some systems.

5. The missing NUCXDROP MODULE is added to the CMS 190 disk.

6. The MAINT 494 and MAINT 092 minidisks were unused and have been deleted.

7. A backlevel version of REXXTEST EXEC is removed from the CMSUSER disk.
   The correct version is on the MAINT 19E disk.

8. The Hercules configuration file was changed to include these statements:

ECPSVM          YES
# We need the assists below to be disabled until Hyperion is fixed.
# Remove next statement if Hyperion is not being used, or if
# you have a Hyperion Hercules with the ECPS fix applied
# for ECPSVM issued #382 (closed).
ECPSVM          DISABLE DISP1 DISP2

9. Add CP update HRC374DK to update branding to Release 1 Version 1.1

10. Updated minidisk volsers for FORTRAN and OSBASIC 191 disks.

11. Add CMS update HRC423DS to update Q CMSLEVEL command and the default
    startup message for Release 1 Version 1.1 and simplify the changes needed
    to update branding in the future.

12. Add CMS update HRC424DS to establish a Nucleus Extension for code in a
    saved segment. A subset of the SEGMENT command function from later VM releases
    is provided. The LOAD function brings a save segment into memory and establishes
    a Nucleus Extension to access the loaded code. The PURGE operand removes the
    segment from memory and removes the saved segment from the user virtual machine.

    This update also provides a new NUCXTEXT command to load TEXT files as Nucleus
    extensions. NUCXLOAD is missing from the Community Edition because the VM/370
    CMS loader does not create relocatable MODULE files. NUCXTEXT does load and
    relocate one or more TEXT files into an executable program in memory, and then
    establishes a Nucleus Extension to invoke the program as a command.

13. Add update HRC525DS to provide the SET CMSTYPE HT|RT and QUERY CMSTYPE commands from
    later VM releases for use within a REXX program.

14. Changed these disk holder userID passwords to NOLOG:
    ALGOL,BREXX,FORTRAN,COBOL,OSBASIC,PLI,PL360,RPG,SCRIPT,TAPEMAP,WATFIV,XCOMPARE

15. Corrected an incorrect SYSCYL operand on the CMSTEST NAMESYS macro in DMKSNT ASSEMBLE.
    Initialized the CMSTEST system on the MAINT 290 disk as a copy of the MAINT 190 CMS disk.

16. Added DMSHRC CNTRL, DMSLCL CNTRL, CMSHRC MACLIB, and DMSLCL MACLIB to the CMS S disk.
    VMFASM with these CNTRL files can be used on other IDs, in addition to being used by MAINT.

17. Correct label on CMSBATCH 195 and 192 disks. Add a BATPROF EXEC to eliminate an error message.

18. Added SFBROWSE reader file browser utility and HELP file.

19. Rearranged disk space so program products like language processors have their minidisks
    all on separate volumes than the main VM service disks.

20. Created new 3350 volume, VM50U0, for the CMSUSER ID. When moving to a new release of the
    VM Community Edition, the VM50U0 volume (VM50U0.cckd) and it's shadow disk file could
    be copied to your new VM release directories to retain any files on the CMSUSER ID
    when the VM Community Edition is updated.

21. A new, empty disk volume (VM50U1) is added, exclusively for you use. The Community Edition
    will supply this as an empty disk, in future releases. You may add user IDs and minidisks
    on the volume. When the Community Edition is updated, simply copy the VM50U1 disk (and its
    shadown file, to the new VM release directories, and add any new users to the new USER DIRECT
    file. This provide the ability to port user IDs you add to a new version of the VM system.

22. Fixed errors in miscellaneous HELP files.

23. Corrected a defect in the vm370ce.sh file. It had deleted 3270 emulator sessions which it did
    not start.

24. Changes in the DMKRIO configuration and the MVS directory entry have been made to simplify
    running Juergen Winklemann's MVS 3.8j Tur(n)key 4- System in a virtual machine See the
    readme-TK4-.txt file in the Community Edition distribution directory for the details.

25. Changes in the DMKRIO configuration and the DOSVS directory entry have been made to simplify
    running George Sedlock's DOSVS 5-Pack system under VM. See the readme-dosvs.txt file in the
    Community Edition distribution directory for the details.

26. The new 2021.01 release of the PASCAL compiler has been loaded the PASCAL 191 disk. Bernd
    Oppolzer will be extracting the subset of those files needed on the Y disk for a future
    release. (Currently all source and executables are on one large disk.) The old PASCAL release
    is still on the Y disk.

27. BREXX and the GCC runtime library has been upgraded to release 1.0.1 to allow the GCC runtime
    code to reside in a VM Saved Segment, and be shared between all users.

28. For those who want to dive deeper into the past, this release adds the ability to run the
    version of CMS from the VM/370 forerunner, CP/67. That older version of CMS is significantly
    different from VM/370 CMS. Please refer to the readme-cms67.txt file in the downloaded directory
    for additional considerations before trying to use this.




=================================================================================
Important considerations:

       A REXX utility program in this release exposed a bug in Hercules ECPSVM
       processing. The bug has been detected only in the SDL Hercules Hyperion
       version, not the older Hercules 3.xx versiosn.

       To see if your version has the bug, issues these commands from MAINT:

       VMSETUP CP
       SNTPARS DMKSNT ASSEMBLE F

       (The failure is intermittent, so you might need to run this a few times.)

       SNTPARS is a REXX utility that displays the saved segment area definitions
       from the DMKSNT ASSEMBLE file. It uses a GCCLIB math routine in some specific
       way that is seen as an 0CC program check with junk in various floating point
       registers.

       Until you have a Hyperion release installed containing the fix, you should
       replace ECPSVM YES in the vm370ce.conf file with these lines:

       ECPSVM YES
       ECPSVM DISABLE DISP1 DISP2
===================================================================================

Known issues in Vm Community Edition V1 R1.1:
============================

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


    -  Attempting to log on to VM/370 using an emulated 2741 terminal via a
       Hercules emulated 2703 device results in a FRE001 crash due to a bug in
       IBM update R12126DK.  The crash can be avoided by commenting out R12126DK
       in DMKCNS AUXR60 (which requires R12733DK, R13198DK and R13158DK be
       commented out also as R12126DK is a prerequisite for them) however, the
       consequences of doing this are unknown.  A better solution would be to
       develop a fix for the bug in R12126DK.  Successful login using a 2741
       also requires patches to commadpt.c to tweak the translate tables and to
       extend the scope of the crlf parameter.
