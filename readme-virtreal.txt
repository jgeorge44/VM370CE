Quick and Dirty V=R Nucleus Building for VM/370 Community Edition

In under to unlock VIRT=REAL support in VM/370 CE, to take advantage of the
performance boost that VIRT=REAL gives to other operating systems running as
guests under VM/370 (like MVS under VM, for example), you need to rebuild
the CP nucleus on the system to support a VIRT=REAL memory area. The default
nucleus under VMCE does not enable VIRT=REAL, because if you're not using
any applications that can take advantage of it, it's just memory wasted
that can be used for other users and other applications.

If you need VIRT=REAL support, enabling it is pretty easy - you do need to
recompile and load a new CP nucleus, but VMCE is already pre-configured to
make this simple even for the less experienced MAINT user. The procedure
below will enable V=R support with no other changes to the CP nucleus:

LOGON MAINT CPCMS
CP SPOOL PUN *
CP SPOOL PRT *
VMSETUP CP

This will set up the MAINT user's VM for recompiling the CP nucleus and
spooling the output back to the MAINT user's virtual reader.

This procesure creates an 8M virtual equals real area.
You can specify any size for the area at the prompt
for the storage size.

Execute the command below and respond to the prompts:

VRSIZE
VIRTUAL=REAL OPTION REQUIRED (YES,NO): yes
STORAGE SIZE OF VIRT=REAL <MINIMUM IS 32K>: 8192K
08192K STORAGE SIZE FOR VIRTUAL=REAL
IS THE ABOVE ENTRY CORRECT (YES,NO): yes

Rebuild the CP nucleus with the command:

VMFLOAD VRLOAD DMKHRC

VRLOAD builds the VIRT=REAL nucleus. You will get a card deck routed to
your virtual reader as a result:
SYSTEM LOAD DECK COMPLETE
PUN FILE 0342 TO MAINT COPY 01 NOHOLD

Take the spool ID from the output above and put it at the top of your
virtual reader, and IPL from it:

ORDER RDR 342
0001 FILE ORDERED

IPL C CLEAR
Nucleus loaded on VM50-1 --- Starting CYL=0530, last CYL used=0548
CP ENTERED; DISABLED WAIT PSW '00020000 00000012'
CP

At this point, re-IPL CMS and save the nucleus map to disk in case it's
needed. When you IPL CMS, you will get a print file spooled to your virtual
reader:

IPL CMS
PRT FILE 0344 TO MAINT COPY 01 NOHOLD

Re-order the reader to put this file at the top of the deck, and then read
it to your A disk:

ORDER RDR 344
READCARD VRNUC MAP
READCARD VRNUC MAP

The first READCARD command will fail with a "READER EMPTY OR NOT READY."
error. The second one will save the file VRNUC MAP to your A-disk.

Once this file is saved, re-IPL VM/370 and check the console messages for
V=R support:

SHUTDOWN REIPL
(system will re-IPL and MAINT will be logged off)

The operator console (in the Hercules window) will show:

DMKCPI957I Storage size = 16384 K, Nucleus = 328 K,
Dynamic Paging = 07108 K, Trace Table = 248 K,
Free Storage = 0508 K, Virtual=Real = 08192 K

If you see "Virtual=Real = 08192 K" then you have successfully enabled this
support in your CP nucleus, and client OSes that take advantage of it will
see upwards of a 2x performance increase.

To disable this support, follow the same directions above except run
VMFASM CPLOAD DMKHRC (CPLOAD does not include V=R support), install that
nucleus via the same steps above, then save off the map as CPNUC MAP
instead of VRNUC MAP.






















