:: NVIDIA GEFORCE EXPERIENCE INFORMATION
:: Geforce Experience Version
set NvidiaVersion="3.28.0.417"

:: AMD ADRENALIN INFORMATION
:: Adrenalin Version
set AMDVersion="24.6.1"
:: Installer Version
set AMDInstall="240626"


:: AME WIZARD INFORMATION
:: AME Wizard Version
set AMEVersion="0.7.5"

:: ReviOS INFORMATION
:: ReviOS Version
set ReviOSVersion="24.06"

:: AtlasOS INFORMATION
:: AtlasOS Version
set AtlasOSVersion="0.4.0"

:: AME PLAYBOOK INFORMATION
:: AME Playbook Version
set AMEPlaybookVer="0.7"


:: Go to code that checks if script is running on a Windows 10 or a Windows 11 system
:: and if it isn't then notify user, await input and close script
goto PreWindowsVersionCheck
:failed
@echo Unsupported Windows Version
Pause
exit
:PreWindowsVersionCheck
:: Get the output of ver command and store it in a variable
for /f "tokens=4-5 delims= " %%i in ('ver') do set VERSION=%%i %%j

:: Check if the version contains "10." (for Windows 10) or "11." (for Windows 11)
echo %VERSION% | findstr /C:"10." > nul
if %errorlevel% equ 0 (
goto success
) else (
echo %VERSION% | findstr /C:"11." > nul
if %errorlevel% equ 0 (
goto success
) else (
goto failed
)
)
:success
:: Create "ssp" directory
mkdir ssp

cls
:: Open activation script by pressing either 1 or 2
choice /C 12 /M "Do you want to open the Windows Activation Script? 1 = YES, 2 = NO : "
:: Listen for keypress "1", if pressed, run script then move on
if errorlevel 1 goto YESACTIVATE	
:: Listen for keypress "2", if pressed, don't run script and continue
if errorlevel 2 goto ActivateEND

:YESACTIVATE
:: Activate Windows
powershell -c "irm https://massgrave.dev/get | iex"
:ActivateEND

cls
:: Goes along with downloading, installing and deleting dependencies depending on user input
choice /C 12 /M "Do you want to install common system dependencies? 1 = YES, 2 = NO : "
:: Listen for keypress "2", if pressed, run script then move on
if errorlevel 2 goto DependenciesEnd
:: Listen for keypress "1", if pressed, don't run script and continue
if errorlevel 1 goto YesDependencies
:YesDependencies

:: Download OpenAL
curl.exe -fSLo ssp.zip https://www.openal.org/downloads/oalinst.zip
:: Extract ssp.zip (OpenAL)
powershell Expand-Archive -Force ssp.zip
:: Delete Archive
del ssp.zip

:: Go into "ssp" directory
cd ssp

:: Download Java
curl.exe -fSLo JavaInstall.exe https://ninite.com/adoptjavax11-adoptjavax17-adoptjavax21-adoptjavax8/ninite.exe

:: Download .Net Desktop Runtime
curl.exe -fSLo DotNetRuntime.exe https://ninite.com/.net4.8-.netx5-.netx6-.netx7-.netx8/ninite.exe

:: Download DirectX Runtime
curl.exe -fSLo dxwebsetup.exe https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe

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
curl.exe -fSLo GeForce_Experience_v%NvidiaVersion%.exe https://us.download.nvidia.com/GFE/GFEClient/%NvidiaVersion%/GeForce_Experience_v%NvidiaVersion%.exe
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
cls
)

)
:: Disables delayed expansion of variables (!variable! syntax)
ENDLOCAL

:: Run VisualCppRedist_AIO_x86_x64.exe and install
VisualCppRedist_AIO_x86_x64.exe /y

:: Run dxwebsetup.exe quietly
dxwebsetup.exe /q

:: Run JavaInstall.exe
JavaInstall.exe

:: Run oalinst.exe
oalinst.exe

:: Run xnafx40_redist.msi
xnafx40_redist.msi

:: Run DotNetRuntime.exe 
DotNetRuntime.exe

:: Run Geforce Experience (if you have an Nvidia GPU)
if exist GeForce_Experience_v%NvidiaVersion%.exe ( 
 GeForce_Experience_v%NvidiaVersion%.exe
 goto NvidiaPass
) else (
 goto NvidiaPass
)
:NvidiaPass

:: Run AMD Adrenalin (if you have an AMD GPU)
if exist amd-software-adrenalin-edition-%AMDVersion%-minimalsetup-%AMDInstall%_web.exe ( 
 amd-software-adrenalin-edition-%AMDVersion%-minimalsetup-%AMDInstall%_web.exe
 goto AMDPass
) else (
 goto AMDPass
)
:AMDPass

:: Clean up
del DotNetRuntime.exe
del JavaInstall.exe
del VisualCppRedist_AIO_x86_x64.exe
del dxwebsetup.exe
del oalinst.exe
del xnafx40_redist.msi
del GeForce_Experience_v%NvidiaVersion%.exe
del amd-software-adrenalin-edition-%AMDVersion%-minimalsetup-%AMDInstall%_web.exe
:DependenciesEnd
cd ssp

cls


:: Download and run AME Wizard
choice /C 123 /M "Do you want to go through the process of installing a playbook on your system? 1 = YES, 2 = NO, 3 = Learn More : "
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
:: Download AME Wizard
curl.exe -fSLo AME-Wizard-Beta.exe https://github.com/Ameliorated-LLC/trusted-uninstaller-cli/releases/download/%AMEVersion%/AME-Wizard-Beta.exe
:PlaybookSTART
:: Download ReviOS or AtlasOS by pressing either 1 or 2
choice /C 1234 /M "Which playbook would you like to download? 1 = Revision, 2 = Atlas, 3 = Ameliorated, 4 = Learn More : "
if errorlevel 4 goto PlaybookWhat
:: Listen for keypress "3", if pressed, Download AME Playbook then move on
if errorlevel 3 goto AMEPlaybook
:: Listen for keypress "2", if pressed, download ReviOS Playbook then move on
if errorlevel 2 goto AtlasOS
:: Listen for keypress "1", if pressed, download AtlasOS Playbook then move on
if errorlevel 1 goto ReviOS
:ReviOS
echo You chose download Revision!
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
AME-Wizard-Beta.exe
:AMEWizardEND

@echo script finished
cd ..
rmdir ssp
exit
