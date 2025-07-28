A new set of disk definitions in the vm370ce.conf file, and changes in the
TK5 directory entry in the USER DIRECT file make it easier to install and run
this verion of MVS under VM.

1. Download the current mvs-tk5.zip file from
   https://www.prince-webdesign.nl/images/downloads/mvs-tk5.zip

2. Unzip the mvs-tk5.zip file into the main VM370CE directory (the one
   containing vm370ce.conf).

2. Edit the vm370ce.conf Hercules configuration file and uncomment the
   "INCLUDE guest-tk5.conf" line near the bottom of that file.

3. Bring up VM and logon to the TK5 user ID, password TK5.

4. If you want to set up a V=R area to run MVS with better performance by
   dedicating real memory to the MVS guest, read the readme-virtreal.txt file
   in this directory.
