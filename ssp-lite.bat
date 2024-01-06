:: This script does
:: 
:: Download & installs DirectX (Game Compatiblity)
:: Download & installs VCRedist 2005-2023 x86 & x64 (Game Compatiblity)
:: Download & installs Steam (Game Library & Storefront)
:: Download & installs Heroic (Epic Games Launcher & Good Old Games's Library and Storefronts, all rolled into one Launcher)
:: Download & installs UltimMC Launcher (Lightweight, MultiInstance Minecraft Launcher)
:: Download & installs Discord (Chatting platform aimed towards g*mers)
:: Download & installs Spotify (Music)
:: Runs MassGraves's Activation Scripts for Windows (Activate Windows) 
::
:: Self Cleaning

:: This script doesn't
::
:: check if files are already downloaded
:: check if programs are already installed
:: know if the files its deleting where successfully installed or not


title easy prep

cls

:: creating temp folder(s)
set ExecuteableDir="simplesystemprep\executeable\"
set ArchiveDir="simplesystemprep\archives\"

echo creating folder(s)
@echo off
mkdir simplesystemprep\archives
mkdir simplesystemprep\executeable
cls

:: downloading files

echo downloading DirectX Web Installer
@echo off
curl.exe -fSLo dxwebsetup.exe https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe
@echo off
timeout /t 3
@echo off
move dxwebsetup.exe %ExecuteableDir%
cls

echo downloading Spotify
@echo off
curl.exe -fSLo spotify.exe https://ninite.com/spotify/ninite.exe
@echo off
timeout /t 3
@echo off
move spotify.exe %ExecuteableDir%
cls

echo downloading Discord + Vencord
@echo off
curl.exe -fSLo discord.exe https://ninite.com/discord/ninite.exe
@echo off
curl.exe -fSLo vencord.exe https://github.com/Vencord/Installer/releases/latest/download/VencordInstaller.exe
@echo off
timeout /t 3
@echo off
move discord.exe %ExecuteableDir%
@echo off
move vencord.exe %ExecuteableDir%
cls

echo downloading Steam
@echo off
curl.exe -fSLo steam.exe https://ninite.com/steam/ninite.exe
@echo off
timeout /t 3
@echo off
move Steam.exe %ExecuteableDir%
cls


echo downloading Virtual Studio Redistributable
@echo off
curl.exe -fSLo VisualCppRedistAIO.exe https://rebrand.ly/vcpp
@echo off
timeout /t 3
@echo off
move  VisualCppRedistAIO.exe %ExecuteableDir%
cls


::downloading files (continued)
::NOTETOSELF: this section (below) is for static files. change them manually to point to the latest version of the program.
set HeroicDownload="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.11.0/Heroic-2.11.0-Setup-x64.exe"

echo downloading Heroic Launcher (Epic Games and GOG)
echo this might take a while...
@echo off
curl.exe -fSLo heroic.exe %HeroicDownload%
@echo off
timeout /t 3
@echo off
move heroic.exe %ExecuteableDir%
cls

:: running installers

@echo off
echo installing Virtual Studio Redistributable
@echo off
start /w simplesystemprep/executeable/VisualCppRedistAIO.exe
@echo off
del /f /q simplesystemprep\executeable\VisualCppRedistAIO.exe
cls

echo installing DirectX
@echo off
start /w simplesystemprep/executeable/dxwebsetup.exe
@echo off
del /f /q simplesystemprep\executeable\dxwebsetup.exe
cls

echo installing Steam
@echo off
start /w simplesystemprep/executeable/steam.exe
@echo off
del /f /q simplesystemprep\executeable\steam.exe

cls

echo installing Discord + Vencord
@echo off
start /w simplesystemprep/executeable/discord.exe
@echo off
del /f /q simplesystemprep\executeable\discord.exe
@echo off
start /w simplesystemprep/executeable/vencord.exe
@echo off
del /f /q simplesystemprep\executeable\vencord.exe
cls

echo installing Spotify
@echo off
start /w simplesystemprep/executeable/spotify.exe
@echo off
del /f /q simplesystemprep\executeable\spotify.exe
cls

echo installing Heroic Launcher (Epic Games and GOG)
@echo off
start /w simplesystemprep/executeable/heroic.exe
@echo off
del /f /q simplesystemprep\executeable\heroic.exe
cls

echo running windows activation script
@echo off
echo Initialising
powershell -c "irm https://massgrave.dev/get | iex"
cls

@echo cleaning up
rmdir simplesystemprep
cls

@echo all actions completed
pause
exit /b 0
