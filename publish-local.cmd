@echo off
::Timestamp: 2020-08-29-11:20
for %%I in (.) do set CurrDirName=%%~nxI
echo Target: %CurrDirName%
del /q %APPDATA%\Factorio\mods\%CurrDirName%_*.zip
robocopy .\src %APPDATA%\Factorio\mods\%CurrDirName% *.* /MIR
:exit
pause
