DOS/VS Virtual Machine Initial setup

1. Download the DASDs of George Shedlock's 5-pack:
   http://dosvs.31bits.net/DOSVS_5Pack_V1.0-full.zip
   Unzip the file and put the emulated DASDs into the "dosvs" folder of VM/370 CE.

2. Uncomment these statements in the vm370ce.conf file	:

   #0360 3350 dosvs/DOSR34.3350.CCKD
   #0361 3350 dosvs/PWRR34.3350.CCKD
   #0362 3350 dosvs/WORK01.3350.CCKD
   #0363 3350 dosvs/VSAM01.3350.CCKD
   #0364 3350 dosvs/OPTLB1.3350.cckd

   (use the indicated addresses and the lower case for OPTLIB1).

3. IPL VM/370 CE normally;

4. Logon to DOSVS and create two files:
   a) NOTHING JCL A, containing
      // JOB NOTHING
      /&

(This nothing job will be run at IPL and will ready the card reader of DOS/VS)

    b) DOSIPL EXEC A, containing
       CP SPOOL PUNCH *
       PUNCH NOTHING JCL A ( NOH
       CP SPOOL PUNCH OFF
       IPL 360

(The exec will put the nothing in the virtual card reader before the IPL)

*****************************************************************************

IPL OF DOS/VS R34

1. Logon to DOSVS and, at the Ready prompt, run the DOSIPL EXEC. Type
   dosipl
   followed by ENTER once. Don't do anything on this (logon) console anymore.
   Be sure that it is in RUNNING state.

2. Open a new 3270 connection, press the CLEAR key and dial DOSVS at the address 01F:
   dial dosvs 01f (followed by ENTER)
   You should get the message:
      DIAL DOSVS 01F
      DIALED TO DOSVS 01F
   Press ENTER an other time. You should get the message:

   0I04I IPLDEV=X'360',VOLSER=DOSR34,CPUID=...
   0I03A SPECIFY SUPERVISOR NAME

(This 3270 is now the operating console of DOS/VS.)

   To answer message 0I03A, type:

   $$a$sup1 (and press ENTER twice). When you get the message:

   0I10A GIVE IPL CONTROL COMMANDS
   then type the sequence of commands below (in lower case), each one followed by ENTER :
   set

   0I71I READ DEVICE TYPE FOR SYSLOG INSERTED IN SYSLOG PUB
   dpd

   BG 1T00A WARM START COPY OF SVA FOUND
   keep

   BG 1I00A READY FOR COMMUNICATIONS
   stop
   batch f1

   0D07D ENTER RESPONSE
   F1
   assgn sysin,sysres
   F1 1T20I SYSIN HAS BEEN ASSIGNED TO X'360
   press the ENTER key
   (many messages displayed)

   0D07D ENTER RESPONSE
   BG
   assgn sysin,reader

   0D07D ENTER RESPONSE
   F2
   assgn sysin,reader
   0D07D ENTER RESPONSE
   F4
   assgn sysin,reader
   0D07D ENTER RESPONSE
   F3
   assgn sysin,reader

   0D07D ENTER RESPONSE
   F2

   assgn sysin,reader

   BG 1T20I SYSIN HAS BEEN ASSIGNED TO X'00C'
   0D07D ENTER RESPONSE
   BG

   Press ENTER and do the same for F2, F4 and F3

   Once you have the messages:

   F1 1Q34I BG WAITING FOR WORK
   F1 1Q34I F2 WAITING FOR WORK
   F1 1Q34I F4 WAITING FOR WORK
   F1 1Q34I F3 WAITING FOR WORK

   and the messages regarding the NOTHING job, enter the command:

   r rdr,*xx
   l lst,all

   The IPL of DOS/VS is complete and the system is ready for work.

***************************************************************************

SHUTDOW OF DOS/VS R34

1. To shutdown the system, type the commands, at the DOS/VS console:
   pend

   0D07D ENTER RESPONSE
   F1

   /&

   0D07D ENTER RESPONSE
   F2

   unbatch

   0D07D ENTER RESPONSE
   F4

   unbatch

   0D07D ENTER RESPONSE
   F3

   unbatch

   0D07D ENTER RESPONSE
   BG

   rod

   0D07D ENTER RESPONSE
   F1

   unbatch

   0D07D ENTER RESPONSE
   BG

   stop

   Then, at the DOSV/VS login console, type:

   #CP logoff

   This will drop the dialed console and logoff the DOS/VS virtual machine.

