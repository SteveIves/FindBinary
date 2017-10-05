@echo off

pushd %~dp0

findbinary -file badfile.txt -reclen 218
if ERRORLEVEL 1 echo Bad data detected in badfile.txt

findbinary -file goodfile.txt -reclen 218
if ERRORLEVEL 1 echo Bad data detected in goodfile.txt

popd