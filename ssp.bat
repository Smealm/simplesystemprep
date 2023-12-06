
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

:: creating temp folder

echo creating folder
@echo off
mkdir simplesystemprep
cls

:: downloading files

echo downloading Virtual Studio Redistributable
@echo off
powershell Invoke-WebRequest -Uri https://rebrand.ly/vcpp -OutFile VisualCppRedist_AIO_x86_x64.exe
@echo off
move VisualCppRedist_AIO_x86_x64.exe simplesystemprep/
cls

echo downloading DirectX Web Installer
@echo off
powershell Invoke-WebRequest -Uri https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe -OutFile dxwebsetup.exe
@echo off
move dxwebsetup.exe simplesystemprep/
cls

echo downloading Spotify
@echo off
powershell Invoke-WebRequest -Uri https://ninite.com/spotify/ninite.exe -OutFile spotify.exe
@echo off
move spotify.exe simplesystemprep/
cls

echo downloading Discord + Vencord
@echo off
powershell Invoke-WebRequest -Uri https://ninite.com/discord/ninite.exe -OutFile discord.exe
@echo off
powershell Invoke-WebRequest -Uri https://github.com/Vencord/Installer/releases/latest/download/VencordInstaller.exe -OutFile vencord.exe
@echo off
move discord.exe simplesystemprep/
@echo off
move vencord.exe simplesystemprep/
cls

echo downloading Steam
@echo off
powershell Invoke-WebRequest -Uri https://ninite.com/steam/ninite.exe -OutFile steam.exe
@echo off
move Steam.exe simplesystemprep/
cls

echo downloading Flashpoint (Flash Games)
@echo off
powershell Invoke-WebRequest -Uri https://github.com/FlashpointProject/FlashpointComponentTools/releases/latest/download/FlashpointInstaller.exe -OutFile flashpoint.exe
@echo off
move flashpoint.exe simplesystemprep/
cls

::downloading files (continued)
::NOTETOSELF: this section (below) is for static files. change them manually to point to the latest version of the program.
set AndroidDownload="https://a11.gdl.netease.com/MuMuInstaller_3.1.6.0_gw-overseas12_all_1699416735.exe"
set RetroArchDownload="https://buildbot.libretro.com/stable/1.16.0/windows/x86_64/RetroArch-Win64-setup.exe"
set HeroicDownload="https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.11.0/Heroic-2.11.0-Setup-x64.exe"
set MinecraftDownload="https://github.com/PrismLauncher/PrismLauncher/releases/download/8.0/PrismLauncher-Windows-MSVC-Setup-8.0.exe"


echo downloading MuMu Player (Android Emulator)
@echo off
powershell Invoke-WebRequest -Uri %AndroidDownload% -OutFile mumu.exe
@echo off
move mumu.exe simplesystemprep/
cls

echo downloading RetroArch (Emulation Frontend)
@echo off
powershell Invoke-WebRequest -Uri %RetroArchDownload% -OutFile retroarch.exe
@echo off
move retroarch.exe simplesystemprep/
cls

echo downloading Heroic Launcher (Epic Games and GOG)
echo this might take a while...
@echo off
powershell Invoke-WebRequest -Uri %HeroicDownload% -OutFile heroic.exe
@echo off
move heroic.exe simplesystemprep/
cls

echo downloading Prism (Minecraft)
@echo off
powershell Invoke-WebRequest -Uri %MinecraftDownload% -OutFile prism.exe
@echo off
move prism.exe simplesystemprep/
cls


:: running installers

echo installing Virtual Studio Redistributable
@echo off
start /w simplesystemprep/VisualCppRedist_AIO_x86_x64.exe
@echo off
del /f /q simplesystemprep\VisualCppRedist_AIO_x86_x64.exe
cls

echo installing DirectX
@echo off
start /w simplesystemprep/dxwebsetup.exe
@echo off
del /f /q simplesystemprep\dxwebsetup.exe
cls

echo installing Steam
@echo off
start /w simplesystemprep/steam.exe
@echo off
del /f /q simplesystemprep\steam.exe
cls

echo installing Discord + Vencord
@echo off
start /w simplesystemprep/discord.exe
@echo off
del /f /q simplesystemprep\discord.exe
@echo off
start /w simplesystemprep/vencord.exe
@echo off
del /f /q simplesystemprep\vencord.exe
cls

echo installing Spotify
@echo off
start /w simplesystemprep/spotify.exe
@echo off
del /f /q simplesystemprep\spotify.exe
cls

echo installing Heroic Launcher (Epic Games and GOG)
@echo off
start /w simplesystemprep/heroic.exe
@echo off
del /f /q simplesystemprep\heroic.exe
cls

echo installing Prism (Minecraft)
@echo off
start /w simplesystemprep/prism.exe
@echo off
del /f /q simplesystemprep\prism.exe
cls

echo installing RetroArch (Emulation Frontend)
@echo off
start /w simplesystemprep/retroarch.exe
@echo off
del /f /q simplesystemprep\retroarch.exe
cls

echo installing MuMu Player (Android Emulator)
@echo off
start /w simplesystemprep/mumu.exe
@echo off
del /f /q simplesystemprep\mumu.exe
cls

echo installing Flashpoint (Flash games)
@echo off
start /w simplesystemprep/Flashpoint.exe
@echo off
del /f /q simplesystemprep\Flashpoint.exe
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
