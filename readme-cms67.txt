Running the CMS version from the CP/67 system.

The VM Community Edition now includes a runnable copy of the
version of CMS that came with the CP/67 Type III Class A Program.

It is SIGNIFICANTLY different than the CMS in VM/370, but there are
documents for reference online at:

http://www.bitsavers.org/pdf/ibm/360/cp67/

The Control Program from CP/67 is NOT available, only the CMS component.
The main book to look at is GH20-0859-0, the User's Guide.
All the CMS67 commands are documented there.

******* Important: There is a bug in the ECPSVM support for the Hyperion
*******    version of Hercules. I believe that the latest ECPSVM fix
*******    from Bob Polmanter corrects the problem, but that fix is
*******    not included in Hercules Hyperion 4.3 and earlier releases.
*******    IPL of the CMS67 system using the 190 device results in a program
*******    check loop if you use Hercules Hyperion 4.3 or earlier versions.
*******    IPL of the CMS67 system using the saved segment (IPL CMS67) works
*******    fine.


The provided CMS67 user ID is class G and has a single 191 P disk.
There is also a CMS67M priveledged ID for CMS67 administration.
It has the following minidisks:

191 'P' disk - workearea
192 'T' disk - CMS67 source code
195 'A' disk - Various TEXT files for the provided compilers.

There is no IMPCP (implied CP) support. You must prefix all CP commands with 'CP'.
Any CP command responses will be from the VM/370 Control Program, since the
CP/67 Control Program is not available.

