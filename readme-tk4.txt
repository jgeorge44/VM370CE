A new set of disk definitions in the vm370ce.conf file, and changes in the
MVS directory entry in the USER DIRECT file make it easier to install and run
this verion of MVS under VM.

1. Download the tk4-_v1.00_current.zip file from http://wotho.ethz.ch/tk4-/
   and unzip it into the 'mvs' directory within the VM370CE.Vx.Ry.z distribution
   directory for your release of VM370CE.

2. Edit the vm370ce.conf Hercules configuration file and uncomment the
   mvs device statements at the bottom of that file.

3. Bring up VM and logon to the MVS user ID.

4. If you want to set up a V=R area to run MVS with better performance by
   dedicating real memory to the MVS guest, read the readme-virtreal.txt file
   in this directory.