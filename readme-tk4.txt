A new set of disk definitions in the vm370ce.conf file, and changes in the
TK4 directory entry in the USER DIRECT file make it easier to install and run
this verion of MVS under VM.

1. Download the tk4-_v1.00_current.zip file from
   https://wotho.pebble-beach.ch/tk4-/tk4-_v1.00_current.zip

2. Create a directory named "mvs-tk4" in the main VM370CE directory (the directory
   containing vm370ce.conf). cd into the mvs-tk4 directory and unzip the
   tk4 zip file here.

2. Edit the vm370ce.conf Hercules configuration file and uncomment the
   "INCLUDE guest-tk4.conf" line near the bottom of that file.

3. Bring up VM and logon to the TK4 user ID, password TK4.

4. If you want to set up a V=R area to run MVS with better performance by
   dedicating real memory to the MVS guest, read the readme-virtreal.txt file
   in this directory.
