: This command file launches the VM/370 SixPack.
: Ensure that the Hercules executable (hercules.exe) is in your path.

start hercules -f vm380.conf > Log.txt

: Now start the 3270 emulator.
: Feel free to replace this with your preferred program.
cd 3270
wc3270.exe model2.wc3270 -keymap 3270 -title "VM Login"
