
# FindBinary

A Synergy .NET console application that can be used to find
invalid characters in a text file that will prevent the data
in the file being loaded into an ISAM file.

The utility searches for and reports two types of issues:

* Non printable characters (decimal 31 and lower)
* 8-bit characters (decimal 128 and higher)

```
Usage:  FindBinary -file <name> [-reclen <length>] [-replace] [-quiet] [-pause]

    -file  <name>       Specify the name of the file to process.

    -reclen <length>    Specify the record length of the file.
                        Only valid when processing a single file.

    -replace            Replace bad characters with space characters.

    -quiet              Don't display anything, just set ERRORLEVEL.

    -pause              Wait for a key press before closing.
```

To get the best information from the utility specify the length
of the records in the file, for example.

```
FindBinary -file cusmas.txt -reclen 2500
```

Specifying the record length is optional, but allows the utility
to validate that CR and LF characters only appear in expected
positions within the file. In other words it validates that
the length of all records is as expected.

If youi use the -replace option then all bad characters will be
replaced with a single space character and a new file will be
created. The name of the new file will be the name of the original
file with ".new" addded.

Here is an example of the type of output you can expect to see
when bad data is encountered:

```
FindBinary -file cusmas.txt -reclen 2500

Bad data found in cusmas.txt
 - Character 216 O     at offset 30379 (record 139 position 20)
 - Character 188 ¼     at offset 36996 (record 169 position 37)
 - Character 008 <BS>  at offset 57466 (record 262 position 47)
 - Character 000 <NUL> at offset 64285 (record 293 position 46)
 - Character 000 <NUL> at offset 64286 (record 293 position 47)
 - Character 000 <NUL> at offset 64287 (record 293 position 48)
 - Character 000 <NUL> at offset 64288 (record 293 position 49)
 - Character 000 <NUL> at offset 64289 (record 293 position 50)
 - Character 000 <NUL> at offset 64290 (record 293 position 51)
```

If no bad data is encountered then no output is displayed.

The Windows ERRORLEVEL variable is always set on exit, a value of 0
indicating a successful completion with no bad data detected and
a value of 1 indicating that bad data was detected in the file.
You can use this to detect success or failure when running from a
batch file, like this:

```
FindBinary -file cusmas.txt -reclen 2500
if ERRORLEVEL 1 echo Bad data detected in cusmas.txt
```
