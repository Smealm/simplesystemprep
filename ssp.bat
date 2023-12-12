:: This script does
:: 
:: Download & installs DirectX (Game Compatiblity)
:: Download & installs VCRedist 2005-2023 x86 & x64 (Game Compatiblity)
:: Download & installs Steam (Game Library & Storefront)
:: Download & installs Heroic (Epic Games Launcher & Good Old Games's Library and Storefronts, all rolled into one Launcher)
:: Download & installs Prism Launcher (Lightweight, MultiInstance Minecraft Launcher)
:: Download & installs MuMu Player (Android Game Support)
:: Download & installs RetroArch (Emulation Frontend providing emulation support for a wide range of systems and game consoles)
:: Download & installs Flashpoint (Launcher used to play flash games)
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
cls

echo downloading Spotify
@echo off
curl.exe -fSLo spotify.exe https://ninite.com/spotify/ninite.exe
cls

echo downloading Discord + Vencord
@echo off
curl.exe -fSLo discord.exe https://ninite.com/discord/ninite.exe
@echo off
curl.exe -fSLo vencord.exe https://github.com/Vencord/Installer/releases/latest/download/VencordInstaller.exe
@echo off
move discord.exe %ExecuteableDir%
@echo off
move dxwebsetup.exe %ExecuteableDir%
@echo off
move spotify.exe %ExecuteableDir%
cls

echo downloading Steam
@echo off
curl.exe -fSLo steam.exe https://ninite.com/steam/ninite.exe
cls

echo downloading Virtual Studio Redistributable
@echo off
curl.exe -fSLo VisualCppRedistAIO.exe https://rebrand.ly/vcpp
@echo off
move Steam.exe %ExecuteableDir%
@echo off
move vencord.exe %ExecuteableDir%
cls

echo downloading Flashpoint (Flash Games)
@echo off
curl.exe -fSLo flashpoint.exe https://github.com/FlashpointProject/FlashpointComponentTools/releases/latest/download/FlashpointInstaller.exe
@echo off
move flashpoint.exe %ExecuteableDir%
@echo off
move  VisualCppRedistAIO.exe %ExecuteableDir%
cls



::downloading files (continued)
::NOTETOSELF: this section (below) is for static files. change them manually to point to the latest version of the program.
set AndroidDownload="https://a11.gdl.netease.com/MuMuInstaller_3.1.6.0_gw-overseas12_all_1699416735.exe"
set RetroArchDownload="https://buildbot.libretro.com/stable/1.16.0/windows/x86_64/RetroArch-Win64-setup.exe"
set HeroicDownload="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.11.0/Heroic-2.11.0-Setup-x64.exe"
set MinecraftDownload="https://github.com/PrismLauncher/PrismLauncher/releases/download/8.0/PrismLauncher-Windows-MSVC-Setup-8.0.exe"


echo downloading MuMu Player (Android Emulator)
@echo off
curl.exe -fSLo mumu.exe %AndroidDownload%
cls

echo downloading RetroArch (Emulation Frontend)
@echo off
curl.exe -fSLo retroarch.exe %RetroArchDownload%
@echo off
move mumu.exe %ExecuteableDir%
@echo off
move retroarch.exe %ExecuteableDir%
cls

echo downloading Heroic Launcher (Epic Games and GOG)
echo this might take a while...
@echo off
curl.exe -fSLo heroic.exe %HeroicDownload%
@echo off
move heroic.exe %ExecuteableDir%
cls

echo downloading Prism (Minecraft)
@echo off
curl.exe -fSLo prism.exe %MinecraftDownload% 
@echo off
move prism.exe %ExecuteableDir%
cls

:: Moving












pause

:: running installers

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

echo installing Heroic Launcher (Epic Games and GOG) + Claimer
@echo off
start /w simplesystemprep/executeable/heroic.exe
@echo off
del /f /q simplesystemprep\executeable\heroic.exe
cls

echo installing Prism (Minecraft)
@echo off
start /w simplesystemprep/executeable/prism.exe
@echo off
del /f /q simplesystemprep\executeable\prism.exe
cls

echo installing RetroArch (Emulation Frontend)
@echo off
start /w simplesystemprep/executeable/retroarch.exe
@echo off
del /f /q simplesystemprep\executeable\retroarch.exe
cls

echo installing MuMu Player (Android Emulator)
@echo off
start /w simplesystemprep/executeable/mumu.exe
@echo off
del /f /q simplesystemprep\executeable\mumu.exe
cls

echo installing Flashpoint (Flash games)
@echo off
start /w simplesystemprep/executeable/Flashpoint.exe
@echo off
del /f /q simplesystemprep\executeable\Flashpoint.exe
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
