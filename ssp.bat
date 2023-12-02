
:: This script does
:: 
:: Download & installs DirectX (Game Compatiblity)
:: Download & installs VCRedist 2005-2023 x86 & x64 (Game Compatiblity)
:: Download & installs Steam (Game Library & Storefront)
:: Download & installs Heroic (Epic Games Launcher & Good Old Games's Library and Storefronts, all rolled into one Launcher)
:: Download & installs Prism Launcher (Lightweight, MultiInstance Minecraft Launcher)
:: Runs MassGraves's Activation Scripts for Windows (Activate Windows)
::
:: Self Cleaning

:: This script doesn't
::
:: check if files are already downloaded
:: check if programs are already installed
:: know if the files its deleting where successfully installed or not
:: generate DXWebsetup from microsoft's website (i have to self host it cause i cant figure out how to download a fresh file through windows CLI)
:: generate Ninite for Steam (cant figure out how to generate fresh file from ninites site using windows CLI)


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
powershell Invoke-WebRequest -Uri https://github.com/Smealm/simplesystemprep/raw/main/resources/dxwebsetup.exe -OutFile dxwebsetup.exe
@echo off
move dxwebsetup.exe simplesystemprep/
cls

echo downloading Spotify + Block the Spot
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

::downloading files (continued)
::NOTETOSELF: this section (below) is for static files. change them manually to point to the latest version of the program.

echo downloading Heroic Launcher (Epic Games and GOG)
@echo off
powershell Invoke-WebRequest -Uri https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.11.0/Heroic-2.11.0-Setup-x64.exe -OutFile heroic.exe
@echo off
move heroic.exe simplesystemprep/
cls

echo downloading Prism (Minecraft)
@echo off
powershell Invoke-WebRequest -Uri https://github.com/PrismLauncher/PrismLauncher/releases/download/8.0/PrismLauncher-Windows-MSVC-Setup-8.0.exe -OutFile prism.exe
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

echo installing Spotify + Block the Spot
@echo off
start /w simplesystemprep/spotify.exe
@echo off
del /f /q simplesystemprep\spotify.exe
@echo off
echo Initialising
powershell -c [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/mrpond/BlockTheSpot/master/install.ps1') } -UninstallSpotifyStoreEdition -UpdateSpotify"
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
