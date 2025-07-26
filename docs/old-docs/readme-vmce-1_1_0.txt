The VM Community Edition V1 R1.0 is based on the VM/370 Sixpack 1.3 and contains
all the function distributed in that system.

Contributor list includes: Dave Wade, Peter Coghlin, Bob Polmanter, Adrian Sutherland,
and Bob Bolch. Many others contributed to the ideas implemented in this release.

The primary objective of this release is to provide a robust, full-featured version
of REXX for VM/370.

=================
Changes in this release:

1. Updated template SYSTEM NETID file on the S disk.

2. New 3350 volumes VM50-7 and VM50-8 for new minidisks.

3. Renamed SIXPACK DIRECT A to USER DIRECT A on MAINT 191.
   Added user ID definitions with minidisks to map all VM system data areas:

$TDSK$ - temporary TDISK space
$TEMP$ - Spool and Paging space
$DCSS$ - Save segment area
$DIRECT$ - Object directory
$NUC$ - System Nucleus area
$ERROR$ - Error recording cylinders
$SYSWRM$ - Spool warm start data area
$SYSCKP$ - Spool checkpoint data area

4. Renamed the MAINT 191 disk to 291 and added a basically empty MAINT 191
   minidisk for use as a work area to maintain the system code. Removed some
   inappropriate files from MAINT 291 including DISKMAP EXEC which had an IBM
   copyright notice in it and a bug.

5. Added this PROFILE EXEC for MAINT. It has minimum requirements to setup MAINT,
   and allows the user to add their own PF Key definitions and other tailoring.
   ------------------------------------------------------------
   &CONTROL OFF
   * ACCESS MECAFF TOOLS AND HELP FILES
   ACCESS 19D U/S
   EXEC HELP WELCOME
   * ACCESS MAINT TOOLS DISK
   ACCESS 5E5 B/B

   * Add any customizations for maint after this line
   ------------------------------------------------------------

   The design here is to set a minimal set of required commands in
   the PROFILE EXEC. The end user can then append any installation specific
   commands to the end of their PROFILE EXEC. (PF key definitions, any desired
   CMS settings, etc. according to personal preference.)

   The MAINT procedures only depend on the having the 5E5
   minidisk accessed as B, the 19D minidisk accessed as filemode U/S,
   and the system tools and HELP files and utilities initialized by the
   EXEC HELP WELCOME command.

6. Added the MAINT 5E5 disk, accessed as filemode B with tools for
   managing the VM system. The various tools include:
   VMSETUP - establish a disk search order to update and generate CP, CMS, and RSCS.
   SNTPARS - displays the disk layout and stoarage map for system saved segments.
   DISKMAP - generates a file mapping all minidisks on the system.
   Documentation is supplied in the MAINT MEMO file and the RSCS MEMO file.

7. Added the EXPLOIT command to the MAINT 19E Y disk. See HELP EXPLOIT for
   the command description. This command issues a command on each of a selected
   group of files named in a CMS EXEC produced by LISTFILE. It is used by itself
   or within other system service and maintenance procedures.

8. As discussed on the mailing list, new minidisks were added on the MAINT
   ID for use in modifying the system. Two sets of update disks are used to
   separate updates provided by the release distribution from updates devloped
   by individuals. Some of these individual updates will certainly find there way into
   future releases of the Community Edition.

   Updates to VM/370 which are included in this edition are mapped by these files:
   for CP:  DMKHRC CNTRL and aux files with filetype AUXHRC on the 094 minidisk.
   for CMS: DMSHRC CNTRL and aux files with filetype AUXHRC on the 093 minidisk.
   for RSCS: DMTHRC CNTRL and aux files with filetype AUXHRC on the 09F minidisk.

   Any installation specific code which is not provided in the distribution,
   is created, updated, and tested by those wanting to create features not
   yet in a distribution. The installation specific code (LCL level) is built
   using local CNTRL and AUX files.

   for CP: DMKLCL CNTRL and aux files with filetype AUXLCL on the 594 minidisk.
   for CMS: DMKLCL CNTRL and aux files with filetype AUXLCL on the 593 minidisk.
   for RSCS: DMTLCL CNTRL and aux files with filetype AUXLCL on the 59F minidisk.

9. Added a CMS test system disk as the MAINT 290 disk. This test environment
   allows CMS modifications to be tested in a playpen environment without
   interfering with other users on the system. A saved segment named CMSTEST
   is also added for testing CMS modifications. Once modifications are tested,
   they can be copied to the CMS 190 production disk.


10. Added these CMS modifcations for interfaces and utilities used by REXX:

   HRC400DS add Halt Interpretor CMS immediate command
   HRC401DS Support SET INPUT and SET OUTPUT tables in EDIT full screen mode
   HRC402DS Support execution of REXX programs as filetype EXEC
   HRC403DS Expand NUCON to 4K for future extensions
   HRC404DS NUCEXT and SUBCOM support
   HRC406DS Support for MAKEBUF, DROPBUF, and SENTRIES
   HRC407DS Add SET EXECTRAC command for REXX
   HRC408DS Support call type X'05' for REXX functions
   HRC409DS Pass QUERY & SET cmd to CP if no CMS operand found
   HRC410DS Reset REXX immediate cmds and depth counter in ABEND
   HRC411DS Add EXECIO command to VM/370
   HRC412DS PE HRC309DS. Bad EPLIST built when no cmd operands
   HRC413DS Give RC=28 when NUCXDROP extension name is not found
   HRC414DS Remove DMSOLD from CMSSEG to prepare for HRC415DS
   HRC415DS Reorganize CMS Nucleus to reside in High Memory
   HRC416DS Support for IDENTIFY command
   HRC417DS Support RDTERM TYPE=DIRECT for REXX tracing
   HRC418DS First command after IPL CMS fails if it is a CP command
   HRC419DS Allow long CP command tokens if EPLIST provided
   HRC420DS Update CMSLEVEL msg for Community Edition V1R1.0
   HRC421DS Allow mixed case CMS version ID and installation heading

   These updates improve the capabilities of REXX in VM/370 by adding the
   system interfaces to support capabilities including:
   a. linkage changes for calling and receiving results from REXX external functions
   b. support for REXX Function packages written in other languages
   c. CMS subcommand and Nucleus Extension support
   d. Interpretor immediate commands TS, TE, HI
   e. CMS stack modernization with MAKEBUF, DROPBUF, and SENTRIES
   f. Full EXECCOMM support so external programs can store and fetch REXX variable values
   g. Full function EXECIO CMS command.

   HRC415DS modifies the CMS system to load in high memory. The Nucleus code area
   between addresses X'10000' and X'20000' was nearly full, after previous updates
   were added. To allow more new features and fixes to be added to CMS by future
   developers, updates HRC414DS and HRC415DS reorganize the CMS system code
   to reside above the 15Meg line. The old low memory code area is then used for
   user key free storage. The code in the old CMSSEG is now part of the Nucleus.

11. Moved disk locations and load addresses for various segments so that
    they can coexist with the version of CMS that loads in high memory.
    See DMKSNT ASSEMBLE for the details.
    Some segments are now packed together on the same cylinder to save space.
    Also added new segment for CMSTEST system on the MAINT 290. The INSTVSAM
    segment was moved to a lower address. (It is now exactly like CMSDOS.)

11. Added helpfiles for new EXECIO, MAKEBUF, DROPBUF, SENTRIES, NUCXDROP
    NUCXMAP, IDENTIFY, DISKMAP, EXPLOIT, HI, TS and TE CMS commands and
    the QUERY USERID CP command. Also added entries for them to MENU FSHELP,
    CMSCMDS HELPCMD and CPQUERY HELPCMD files.

12. Replaced the EPLIST MACRO. The Sixpack 1.3 version has
    a sequence number error which cannot be corrected except by
    replacing it. I tried all kinds of stuff with ./ S records in an
    UPDATE file and gave up trying to repair this with "normal" methods.

13. Modify DMSHRC CNTRL to work for assembler source and macro
    source to eliminate DMSHRCM CNTRL. Added HRC level CP MACLIBs.

    TEXT MACS CMSHRC CMSLIB OSMACRO DOSMACRO DMKHRC DMKMAC
    TEXT AUXHRC
    TEXT AUXM60
    TEXT AUXR60

14. Added HRC700DK CP update to have Diagnose code X'00' return a timezone
    offset, specified in DMKSYS, for the REXX time functions.

15. Installed GCCLIB 0.8.2 and bREXX 0.9.10 updates with changes on the
    MAINTC user ID to service them. This requires a minor change in the GCCCMS ID.
    Renamed the existing GCCCMS 202 minidisk, and create a new
    GCCCMS 202 disk to contain new GCCLIB header files and GCCLIB MACLIB so that users
    can still use GCC EXEC Y to compile and run C programs with the "(CMS" or "(LIB GCCLIB"
    options after the new GCCLIB TXTLIB has been installed in support of bREXX.

    These releases include a new method to more easily install bREXX and GCC library
    fixes between releases of the VM system, and allow speedy repair of any bugs.

    A new facility to share the GCCLIB memory resident routines between users in a saved
    segment was added to the VM/370 Sixpack 1.3.
    However, the GCCLIB release included in the Community Edition had fixes beyond the
    level of the Sixpack version. The Community Edition uses the GCCLIB release with the
    additional fixes, and removes the saved segment changes temporarily.

    We expect to merge the segment support changes very soon into the next GCCLIB release.

16. Update DMKSYS to add new volumes VM50-7, VM50-8, and GCCBRX to SYSUSR list.

17. Updated the FLIST command to support larger than 24 line screens, by updating
    the FLISTREP MODULE on the Y disk.

18. Build RXLOCFN MODULE from DMSLFN source. (REXX function package for WAKEUP)

19. Build WAKEUP server ID and add entry to autolog it in AUTOLOG1's PROFILE EXEC.
    This server issues commands at specified times during the day, week, month, or year.

20. Add MATCH file comparison utility to the Y disk. See HELP MATCH for details.
    The source is on a new MAINT 5E6 disk for tools source files.

21. Regen CLRSCRN as transient area module.

22. Change address SYSTEM to address COMMAND in REXXTEST EXEC Y, FSLIST/XXLIST EXEC Y,
    and REXX HELPCMD U. Address SYSTEM was not in any CMS version of REXX.

23. Added these CP modifcations:
    HRC373DK New CPLEVEL for VM Community Edition V1 R1.0
    HRC700DK Support for DIAG00 to return timezone offset

    Removed HRC302DK entry from DMKCSO, DMKRSP, ad DMKSEP AUXHRC files because the update
    file is missing. The entry was: HRC302DK V01 CREATE INDIVIDUAL PRINT/PUNCH FILES IF HERCULES.

24. Updated HRCMODS MEMO on MAINT 094 to reflect full list of CP updates.

25. Updated HRCMODS MEMO on MAINT 093 to reflect full list of CMS updates.

26. Add LNKNOPAS option to MAINT directory entry for use by NEWBREXX EXEC.


Known issues in Vm Community Edition V1 R1.0:
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

       Until the ECPSVM issue is resolved, users should select ECPSVM NO
       in the vm370ce.conf file. We will open an issue with the Hyperion group
       once they have access to the VM Community Edition.
===================================================================================
