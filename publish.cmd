@echo off
for %%I in (.) do set CurrDirName=%%~nxI
SET /P version=Version: 
robocopy .\src .\%CurrDirName%_%version% *.* /MIR
::powershell -Executionpolicy ByPass -Command "Add-Type -AssemblyName System.IO.Compression;Add-Type -AssemblyName System.IO.Compression.FileSystem;$zip = [System.IO.Compression.ZipFile]::Open('.\%CurrDirName%_%version%.zip',[System.IO.Compression.ZipArchiveMode]::Create);gci '.\%CurrDirName%_%version%' | %%{[void][System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip,$_.FullName,$_.Name)};$zip.Dispose()"
"%ProgramFiles%\WinRAR\winrar.exe" a -r -af:zip %CurrDirName%_%version%.zip %CurrDirName%_%version%
pause