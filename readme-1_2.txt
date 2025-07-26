---------------------------------------------------
Welcome to VM/370 and VM/380 "SixPack" version 1.2!
---------------------------------------------------

***************************************************
**         Now with full screen editing!!!       **
**                Now with DOS!!!                **
***************************************************

The base operating system is IBM's VM/370 Release 6 operating system, the last unlicensed version of VM/370.  It is designed to run on the Hercules Emulator.

Warning!  I am a hobbiest - I do this for fun.  No warrenties expressed or implied as to the quality or usefulnees of this product are made.  Don't use the SixPack for anything important like controlling a nuclear reactor or flying an airplane.

Changes in version 1.2 of the "SixPack" include:

   1.  The BREXX interpreter is integrated into CMS and runs 
       from resident memory.  This means you can now write 
       EXECs in the REXX language, and they will 
       automatically be executed by the resident REXX 
       interpreter.  Also, these EXECs can invoke any CMS 
       program, including the language processors such as 
       ASSEMBLE, FORTRAN, PLI, etc.  The source code for 
       BREXX is on the BREXX 191 disk.  Type HELP REXX for 
       more information.

   2.  The GCIC file list and fullscreen editor is available
       as RUNGCIC EXEC on the Y disk.  See GCIC MEMO on MAINT
       19D (the U disk) for more information.  

   3.  CMS/DOS and VSAM are alive and well.  The CMSAMS, 
       CMSDOS, CMSVSAM and INSTVSAM saved systems and 
       segements are all present.

   4.  The native CMS version of the GCC runtime library is 
       now resident in memory.  Thus it is possible to write 
       very small programs in C.  Type HELP GCCLIB for more 
       information.

   4.  The CP command now allows you to stack or discard the 
       messages it would otherwise display at the terminal.  
       Very useful when writing EXECs.
   
   5.  During initialization, CMS executes "SYSPROF EXEC" 
       before executing "PROFILE EXEC".  This allows you to 
       ensure certain commands are always executed for users.

   6.  If the virtual machine size is 4MB or larger, LDRTBLS 
       are set to 64 pages instead of 3 pages.

   6.  The CP TRANSFER command has been fixed.  You can now 
       transfer spool files to other users.  The bug in the
       CP QUERY DASD command has been fixed.  The endless 
       loop in the QUERY SYNONYM ALL command has been fixed.

   8.  The PL/360 language is now correctly installed on the 
       19E (Y) disk.

   9.  I have cleaned up the 19E (Y) disk.  Source code for 
       the various programs that were there has been removed 
       and put on MAINT's 093 disk.  Documentation for those 
       programs has been moved to MAINT 19D.



Features of the "SixPack"
-------------------------

   o   Support for the S/380 architecture, which allows you
       to run programs that access memory greater than 16 
       megabytes.  For example, to compile the Gnu C 
       compiler, you need more that 16 megabytes of memory 
       for the compiler.  S/380 allows you to compile it on 
       CMS.  Speaking of which...

   o   The Gnu C Compiler, with both a "traditional" runtime 
       library (PDPCLIB) and a "native CMS" runtime library 
       (GCCLIB).  GCC specifically supports access to memory 
       above 16MB.  The source code for the GCC compiler and
       both runtimes is on the GCCCMS userid's disks.  Type 
       HELP GCC for more information.

   o   An up-to-date, accurate, and fairly complete help 
       system.

   o   Extended parameter list support, meaning it is 
       possible to pass mixed-case parameters to EXECs and C 
       programs.

   o   Current line highlighting and multifile editing in 
       EDIT.

   o   Other programs such as COMPARE, DIFF, FLIST, RESLIB, 
       SCAN, VMARC are all available on the CMS Y disk. Type 
       HELP CMSCMDS to list all available CMS commands.

   o   A set of batch files lets you run the SixPack in a
       remote, automated manner.  Thus you can run batch
       programs such as compiliations from a command prompt
       in Windows, Linux, or other host operating system.



Notes on the BREXX interpreter
------------------------------

Just like VM/SP and its successors, EXECs writting in the REXX language have the filetype of EXEC, and must begin with a REXX comment line.  Note that BREXX is somewhat flakey.  Please report any problems you encounter to the H390-VM group on Yahoo.  Try out REXXTRY EXEC!

Note that loading BREXX and the GCCLIB runtime (required for REXX) into memory consumes 250K of memory.  Thus you may want to run in a larger virtual machine than you previously used.  

If you do not plan to use BREXX, you can prevent their loading into memory by overriding the SYSPROF EXEC on the Y disk.  Simply create SYSPROF EXEC on your A disk with these lines in it:

   &CONTROL OFF NOMSG
   ACCESS 19D U/S
   &EXIT

Doing this of course means that you cannot run REXX EXECs.



Installation
------------

This zip file is set up to run on Windows, mainly because that is what I run.  Hercules runs on other platforms (Linux, Mac OS), so it should be a straightforward matter to adjust the configuration files to get it up and running elsewhere.

1.  Unzip "SixPack.zip" into a suitable directory.  Make sure you choose the option to preserve relative file names.  In the "SixPack" directory (or whatever you call it) there should be three subdirectories:  3270, Disks, and IO.

2.  Install the current version of Hercules from http://hercules-390.org.  If you want to make use of the limited 31-bit addressing capabilities of this release, install Hercules/380 from http://mvs380.sourceforge.net.

3.  Ensure the directory containing "hercules.exe" is in your path.

4.  If you have been using CMSUSER for your work userid, feel free to replace the 6th disk (vm3350-6.6f0.cckd) with your disk from a previous version of the sixpack. 

5.  If you plan to use the batch automation capability, read "batch.txt" in the Batch directory for more information.  If you don't plan to use this feature, you can delete the Batch directory.



Running the SixPack
-------------------

Run "sixpack.cmd" and Hercules should launch, followed in a few seconds by a 3270 terminal emulator.

By default the OPERATOR userid logs in using the Hercules window.  From the command line you can issue Hercules commands.  To issue commands to the OPERATOR userid you must prefix the command with a single "/".  To shut everything down, first log off any users you have been using.  Then from the Hercules window type "/shutdown" to bring down VM/370.  Finally, issue the Hercules "quit" command.


There are several userids defined:

CMSUSER (password of CMSUSER):  This userid is best for general work on the system.  It has several minidisks defined, all residing on a dedicated disk pack.  You can backup any work you store on these disks by simply making a copy of the disk pack's shadow file.

I recommend you login as CMSUSER (password of CMSUSER) for most general work.  This user's minidisks reside on their own volume (the 6th pack), making backup of your own work much easier.

MAINT (password of CPCMS):  This is the system programmer's userid.  Logon here if you want to perform system programming tasks.  For example, you could edit the SIXPACK DIRECT A1 file to change the name of CMSUSER to your name, save the file, then issue the DIRECT SIXPACK command to update the sytem directory.  SYSPROG MEMO on MAINT's 191 disk has useful information on how to rebuild the CMS and CP nucleii.

GCCCMS (password of GCCCMS):  Here you will find the source for the GCC compiler, plus useful EXECs set up to help you do bulk compilations of C programs.

BREXX (password of BREXX):  Here you will find the source code for the BREXX REXX interpreter.

Type HELP CMSCMDS for an overview of the available commands.

The included wc3270 emulator is launched from the "sixpack.cmd" file.  You can modify this command file to launch your preferred 3270 emulator.  You can get wc3270 from http://x3270.bgp.nu.  See the wc3270 documentation for more information.



What is VM/370 and VM/380?
--------------------------

System/370 is a 24-bit architecture:  16MB (2**24) is the maximum addressible memory.  System/380 is the enhanced version of the S/370 architecture created by Paul Edwards, and supported by the 380 version of the Hercules emulator, available at http://mvs380.sourceforge.net.  In the SixPack you can use the S/370-XA instructions BASR and BASM to enter 31-bit mode and address storage above the 16MB line.  Note that this storage is unmanaged, so only one program per Hercules "computer" can use it at a time.  You can access this memory from assembler language programs or from C programs.



Support
-------

There is a lively group at http://games.groups.yahoo.com/group/H390-VM and at http://tech.groups.yahoo.com/group/hercules-os380.  Please join and contribute!



Acknowledgements
----------------

The SixPack is brought to you by Robert O'Hara, Paul Edwards, and Dave Wade.  It is based on earlier versions of VM/370 for Hercules developed by Andy Norrie and Paul Gorlinsky.  Thanks to Roc, Martin Taylor, Mike Stramba, and Kevin Leonard for fixes included in version 1.2.



Robert O'Hara, Redmond Washington, October 2010.

