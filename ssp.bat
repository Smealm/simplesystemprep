:: Credits:
:: Myself
:: [ChatGPT](https://chatgpt.com/) for teaching me how to do things I had trouble figuring out


:: --------------------------------------------------------------------------------------------
cls

:: UPDATE PROGRAMS WITH STATIC URL's HERE

:: AME WIZARD INFORMATION
:: AME Wizard Version
set AMEVersion="0.7.5"
:: AME Wizard Build
set AMEBuild="Beta"

:: ReviOS INFORMATION
:: ReviOS Version
set ReviOSVersion="24.06"

:: AtlasOS INFORMATION
:: AtlasOS Version
set AtlasOSVersion="0.4.0"

:: AME PLAYBOOK INFORMATION
:: AME Playbook Version
set AMEPlaybookVer="0.7"


:: --------------------------------------------------------------------------------------------
cls

:: CHECK CERTAIN THINGS BEFORE RUNNING MAIN SCRIPT


:: Cleans up background command text
@echo off

:PreWindowsVersionCheck
:: Get the output of ver command and store it in a variable
for /f "tokens=4-5 delims= " %%i in ('ver') do set VERSION=%%i %%j

:: Check if the version contains "10." (for Windows 10) or "11." (for Windows 11)
echo %VERSION% | findstr /C:"10." > nul
if %errorlevel% equ 0 (
goto AdminCheckStart
) else (
echo %VERSION% | findstr /C:"11." > nul
if %errorlevel% equ 0 (
goto AdminCheckStart
) else (
goto WindowsVersionCheckFailed
)
)

:: If Windows version isn't 10 or 11, inform user, await input then close script
:WindowsVersionCheckFailed
@echo Unsupported Windows Version
Pause
exit

:: Check for Admin Privileges
:AdminCheckSTART
openfiles >nul 2>&1
if '%errorlevel%' NEQ '0' (

:: Inform the user about missing Administrator privileges
cls
echo This script is not running as administrator.
echo Some features may not be available.
pause
) else (
goto AdminCheckEND
)
:AdminCheckEND

:: Cleanup terminal text
cls

:: Check if winget is available
:WINGETCHECKSTART
@echo off
where winget >nul 2>&1

if %errorlevel% == 0 (
goto WINGETCHECKEND
) else (
echo Winget is not installed.
pause
start https://aka.ms/getwinget
echo Please install winget from the Microsoft Store or visit https://aka.ms/getwinget
pause
goto WINGETCHECKSTART
)
:WINGETCHECKEND

:: Checking if windows is activated
@echo checking if Windows is activated
setlocal

:: Check Windows Activation Status
for /f "tokens=*" %%i in ('slmgr.vbs /xpr') do set "activationStatus=%%i"

:: Output the activation status for debugging purposes
echo %activationStatus%

:: Check if the activation status contains the phrase indicating Windows is activated
echo %activationStatus% | findstr /i "The machine is permanently activated" >nul
if %errorlevel% equ 0 (
goto ActivateEND
) else (
cls

:: Open activation script by pressing either 1 or 2
choice /C 12 /M "Do you want to open the Windows Activation Script? 1 = YES, 2 = NO : "

:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto ActivateEND

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto YESACTIVATE

:: Activate Windows
:YESACTIVATE
powershell -c "irm https://get.activated.win | iex"
)
:ActivateEND
endlocal

:: --------------------------------------------------------------------------------------------
cls

:: RUN MAIN SCRIPT
:ScriptSTART

:: --------------------------------------------------------------------------------------------
cls

:: INSTALL DEPENDENCIES


:: Goes along with downloading, installing and deleting dependencies depending on user input
choice /C 12 /M "Do you want to install common system dependencies? 1 = YES, 2 = NO : "

:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto DependenciesEnd

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto YesDependencies
:YesDependencies

:: Create "ssp" directory
mkdir ssp

:: Go into "ssp" directory
cd ssp

:: Download OpenAL
curl.exe -fSLo oalinst.zip https://www.openal.org/downloads/oalinst.zip

:: Extract oalinst, move the exe to 'ssp', delete the 'oalinst' folder and archive
powershell Expand-Archive -Force oalinst.zip
move oalinst\oalinst.exe
del oalinst.zip
rmdir /s /q oalinst

:: Download PhysX
curl.exe -fSLo PhysX-9.19.0218-SystemSoftware.exe https://us.download.nvidia.com/Windows/9.19.0218/PhysX-9.19.0218-SystemSoftware.exe

:: Download Java
curl.exe -fSLo JavaInstall.exe https://ninite.com/adoptjavax11-adoptjavax17-adoptjavax21-adoptjavax8/ninite.exe

:: Download .Net Desktop Runtime
curl.exe -fSLo DotNetRuntime.exe https://ninite.com/.net4.8-.netx5-.netx6-.netx7-.netx8/ninite.exe

:: Download Apple Mobile Drivers using https://github.com/NelloKudo/Apple-Mobile-Drivers-Installer
powershell iex (Invoke-RestMethod -Uri 'https://raw.githubusercontent.com/NelloKudo/Apple-Mobile-Drivers-Installer/main/AppleDrivInstaller.ps1')

:: Download DirectX Runtime
winget install -e --id Microsoft.DirectX

:: Download Visual C++ Redistributable All-in-One
curl.exe -fSLo VisualCppRedist_AIO_x86_x64.exe https://kutt.it/vcpp

:: Download XNA Framework 4.0
curl.exe -fSLo xnafx40_redist.msi https://download.microsoft.com/download/A/C/2/AC2C903B-E6E8-42C2-9FD7-BEBAC362A930/xnafx40_redist.msi

:: Enables delayed expansion of variables (!variable! syntax)
SETLOCAL EnableDelayedExpansion

:: Get GPU name, store it and echo it
for /f "skip=1 tokens=*" %%a in ('wmic path Win32_VideoController get Description /format:list') do (
set "gpu_name=%%a"
echo !gpu_name!
    
:: If echoed GPU name includes "Nvidia" download Geforce Experience	
echo !gpu_name! | findstr /i "NVIDIA" > nul
if !errorlevel! equ 0 (
echo Downloading Geforce Experience
winget install -e --id Nvidia.GeForceExperience
cls
goto GPUDOWNLOADEND
)

:: If echoed GPU name includes "AMD" download Adrenalin
echo !gpu_name! | findstr /i "AMD" > nul
if !errorlevel! equ 0 (
cls
@echo You have a AMD GPU! 
@echo Your browser will soon open, once it's open click the button that says "Download Windows Drivers"
@echo Please download the EXE to the scripts's "ssp" folder.
@echo DO NOT change the name of the downloaded EXE file!
Pause
start https://www.amd.com/en/support/download/drivers.html
@echo Once you have completed the steps above
Pause
goto GPUDOWNLOADEND
cls
)
)
:GPUDOWNLOADEND

:: Disables delayed expansion of variables (!variable! syntax)
ENDLOCAL
@echo running installers

:: Run VisualCppRedist_AIO_x86_x64.exe and install
VisualCppRedist_AIO_x86_x64.exe /y

:: Run JavaInstall.exe
JavaInstall.exe

:: Run oalinst.exe
oalinst.exe

:: Run xnafx40_redist.msi
xnafx40_redist.msi

:: Run PhysX-9.19.0218-SystemSoftware.exe
PhysX-9.19.0218-SystemSoftware.exe

:: Run DotNetRuntime.exe 
DotNetRuntime.exe

setlocal

:: Find AMD Adrenalin.
for /f "delims=" %%F in ('dir /b /a-d "%~dp0\ssp\amd-software-adrenalin-edition-*.exe" 2^>nul') do (

:: If found, run the file, otherwise do nothing and move on.
start "" "%~dp0\ssp\%%F"
goto :AMDPass
)
:AMDPass
endlocal

:: Clean up
cd ..
rmdir /s /q ssp

:DependenciesEnd

:GamesStart

:: Create "ssp" directory
mkdir ssp

:: Go into "ssp" directory
cd ssp

:: Goes along with downloading, installing game launchers depending on user input
choice /C 12 /M "Do you want to install game related software? 1 = YES, 2 = NO : "

:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto GamesEND

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto YesGames
:YesGames

:: Download Steam
winget install -e --id Valve.Steam

:: Goes along with downloading, installing Heroic or epic games + gog depending on user input
choice /C 12 /M "Do you want to install Heroic Launcher or Epic Games + GOG Galaxy? 1 = Heroic, 2 = Epic+GOG : "

:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto EpicGamesGOG

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto HeroicLauncher
:HeroicLauncher

:: Download Heroic
winget install -e --id HeroicGamesLauncher.HeroicGamesLauncher
goto EpicGamesGOGSkip

:EpicGamesGOG

winget install -e --id EpicGames.EpicGamesLauncher
winget install -e --id GOG.Galaxy
:EpicGamesGOGSkip

:: Download Playnite
winget install -e --id Playnite.Playnite

:: Clean up
cd ..
rmdir /s /q ssp

:GamesEND

:EmuStart

:: Create "ssp" directory
mkdir ssp

:: Go into "ssp" directory
cd ssp

:: Goes along with downloading, installing emulators depending on user input
choice /C 12 /M "Do you want to install game related emulation software? 1 = YES, 2 = NO : "

:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto EmuEND

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto YesEmu
:YesEmu

:: Download Retroarch
winget install -e --id Libretro.RetroArch

:: Download Google Play Games
winget install -e --id Google.PlayGames.Beta

:: Download Flashpoint
curl.exe -fSLo FlashpointInstaller.exe https://github.com/FlashpointProject/FlashpointComponentTools/releases/latest/download/FlashpointInstaller.exe

:: Install Flashpoint
FlashpointInstaller.exe

:: Clean up
cd ..
rmdir /s /q ssp

:EmuEND

:: --------------------------------------------------------------------------------------------
cls

:: AME WIZARD AND PLAYBOOKS


:: Goes along with downloading AME Wizard and going through with the playbook installation proccess depending on user input
choice /C 123 /M "Do you want to download AME Wizard and go through the process of installing a playbook on your system? 1 = YES, 2 = NO, 3 = Learn More : "

:: Listen for keypress "3", if pressed, open AME Wizard's Website and return
if errorlevel 3 goto AMEWhat

:: Listen for keypress "2", if pressed then move on
if errorlevel 2 goto AMEWizardEND

:: Listen for keypress "1", if pressed then move on
if errorlevel 1 goto AMEWizardYes

:AMEWhat
start https://ameliorated.io/
goto :DependenciesEnd

:AMEWizardYes
cls
mkdir ssp
cd ssp

:: Download AME Wizard
curl.exe -fSLo AME-Wizard-v%AMEVersion%-%AMEBuild%.exe https://github.com/Ameliorated-LLC/trusted-uninstaller-cli/releases/download/%AMEVersion%/AME-Wizard-%AMEBuild%.exe

:PlaybookSTART
:: Download ReviOS or AtlasOS by pressing either 1 or 2
cls

choice /C 1234 /M "Which playbook would you like to download? 1 = Revision, 2 = Atlas, 3 = Ameliorated, 4 = Learn More : "

if errorlevel 4 goto PlaybookWhat

:: Listen for keypress "3", if pressed, Download AME Playbook then move on
if errorlevel 3 goto AMEPlaybook

:: Listen for keypress "2", if pressed, download ReviOS Playbook then move on
if errorlevel 2 goto AtlasOS

:: Listen for keypress "1", if pressed, download AtlasOS Playbook then move on
if errorlevel 1 goto ReviOS

:ReviOS
echo You chose to download Revision!
curl.exe -fSLo Revi-PB-%ReviOSVersion%.apbx https://github.com/meetrevision/playbook/releases/download/%ReviOSVersion%/Revi-PB-%ReviOSVersion%.apbx
goto PlaybookEND
:AtlasOS
echo You chose to download Atlas!
curl.exe -fSLo AtlasPlaybook_v%AtlasOSVersion%.apbx https://github.com/Atlas-OS/Atlas/releases/download/%AtlasOSVersion%/AtlasPlaybook_v%AtlasOSVersion%.apbx
goto PlaybookEND
:AMEPlaybook
echo You chose to download Ameliorated!

:: Checks to see if you have windows 10 or 11 in order to download the correct playbook
@echo off
for /f "tokens=4-5 delims= " %%i in ('ver') do set VERSION=%%i %%j
echo %VERSION% | findstr /C:"10." > nul
if %errorlevel% equ 0 (
curl.exe -fSLo AME.10.v%AMEPlaybookVer%.apbx https://github.com/Ameliorated-LLC/AME-10/releases/download/%AMEPlaybookVer%/AME-10-v%AMEPlaybookVer%.apbx
goto PlaybookEND
) else (
echo %VERSION% | findstr /C:"11." > nul
if %errorlevel% equ 0 (
curl.exe -fSLo AME.11.v%AMEPlaybookVer%.apbx https://github.com/Ameliorated-LLC/AME-11/releases/download/%AMEPlaybookVer%/AME.11.v%AMEPlaybookVer%.apbx
)
)

:PlaybookWhat
start https://docs.ameliorated.io/playbooks.html
goto PlaybookSTART

:PlaybookEND

:: Run AME Wizard
cls
@echo continue the setup through AME Wizard 
@echo choose the playbook you downloaded earlier and 
@echo go through the process of installing it through AME
AME-Wizard-v%AMEVersion%-%AMEBuild%.exe

:AMEWizardEND

setlocal

:: Define the name of the executable to wait for
set "processName=AME-Wizard-v%AMEVersion%-%AMEBuild%.exe"

:: Wait until the process is no longer running
:AMEWizardLoopCheck
@echo Waiting for %processName% to close...
tasklist /FI "IMAGENAME eq %processName%" 2>NUL | findstr /I /C:"%processName%" >NUL
if %ERRORLEVEL% == 0 (
    echo %processName% is still running. Waiting...
    timeout /t 1 /nobreak > NUL
    goto AMEWizardLoopCheck
)

:: Execute the desired command
cd ..
rmdir /s /q ssp
endlocal


:: --------------------------------------------------------------------------------------------

cls
:: END OF SCRIPT COMMANDS


:: Check if the script is running as Administrator
net session >nul 2>&1
if %errorLevel% == 0 (
cls

:: Restart Windows by pressing either 1 or 2
choice /C 12 /M "Would you like to restart Windows? 1 = YES, 2 = NO : "

:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto RestartWindowsEND

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto RestartWindowsConfirm

:RestartWindowsConfirm

cls

choice /C 12 /M "Are you sure you want to restart Windows? 1 = I am Sure, 2 = On second thought no : "
:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto RestartWindowsEND

:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto RestartWindows

:RestartWindows
rmdir /s /q ssp
shutdown /r
) else (
    goto RestartWindowsEND
)

:RestartWindowsEND

:ScriptEND

@echo script finished
cd ..
rmdir /s /q ssp
exit
