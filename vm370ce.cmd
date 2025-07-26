: This command file launches the VM/370 Community Edition.
: Ensure that the Hercules executable (hercules.exe) is in your path.

: start hercules -f vm370ce.conf --logfile=Log.txt <-- This can be used on Hercules 4.4.x and later
start "vm370CE V1R1.2" cmd /c hercules -f vm370ce.conf ^> log.txt

: Now start the 3270 emulator.
: Feel free to replace this with your preferred terminal emulation program.
cd WC3270
start wc3270.exe -keymap 3270 -title "VM Login" Model5.wc3270
cd ..
