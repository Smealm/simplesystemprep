:: NVIDIA GEFORCE EXPERIENCE INFORMATION
:: Geforce Experience Version
set NvidiaVersion="3.28.0.417"

:: AME WIZARD INFORMATION
:: AME Wizard Version
set AMEVersion="0.7.5"

:: ReviOS INFORMATION
:: ReviOS Version
set ReviOSVersion="24.06"

:: AtlasOS INFORMATION
:: AtlasOS Version
set AtlasOSVersion="0.4.0"

cls
:: Open activation script by pressing either 1 or 2
choice /C 12 /M "Do you want to open the Windows Activation Script? 1 = YES, 2 = NO : "
:: Listen for keypress "2", if pressed, run script then move on
if errorlevel 2 goto NOACTIVATE
:: Listen for keypress "1", if pressed, don't run script and continue
if errorlevel 1 goto YESACTIVATE
:YESACTIVATE
:: Activate Windows
powershell -c "irm https://massgrave.dev/get | iex"
goto ActivateEND
:NOACTIVATE
goto ActivateEND
:ActivateEND

:: Make "ssp" directory
mkdir ssp

:: Go into "ssp" directory
cd ssp

:: Download AME Wizard
curl.exe -fSLo AME-Wizard-Beta.exe https://github.com/Ameliorated-LLC/trusted-uninstaller-cli/releases/download/%AMEVersion%/AME-Wizard-Beta.exe

:: Download Java
curl.exe -fSLo JavaInstall.exe https://ninite.com/adoptjavax11-adoptjavax17-adoptjavax21-adoptjavax8/ninite.exe

:: Download .Net Desktop Runtime
curl.exe -fSLo DotNetRuntime.exe https://ninite.com/.net4.8-.netx5-.netx6-.netx7-.netx8/ninite.exe

:: Download DirectX Runtime
curl.exe -fSLo dxwebsetup.exe https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe

:: Download Visual C++ Redistributable All-in-One
curl.exe -fSLo VisualCppRedist_AIO_x86_x64.exe https://kutt.it/vcpp

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
echo Downloading Adrenalin
curl.exe -fSLo amd-software-adrenalin-edition-24.6.1-minimalsetup-240626_web.exe https://drivers.amd.com/drivers/installer/24.10/whql/amd-software-adrenalin-edition-24.6.1-minimalsetup-240626_web.exe
)

)
:: Disables delayed expansion of variables (!variable! syntax)
ENDLOCAL

cls
:: Download ReviOS or AtlasOS by pressing either 1 or 2
choice /C 12 /M "Press 1 to download ReviOS. Press 2 to download AtlasOS: "
:: Listen for keypress "2", if pressed, download ReviOS Playbook then move on
if errorlevel 2 goto AtlasOS
:: Listen for keypress "1", if pressed, download AtlasOS Playbook then move on
if errorlevel 1 goto ReviOS
:ReviOS
echo You chose download ReviOS!
curl.exe -fSLo Revi-PB-%ReviOSVersion%.apbx https://github.com/meetrevision/playbook/releases/download/%ReviOSVersion%/Revi-PB-%ReviOSVersion%.apbx
goto PlaybookEND
:AtlasOS
echo You chose to download AtlasOS!
curl.exe -fSLo AtlasPlaybook_v%AtlasOSVersion%.apbx https://github.com/Atlas-OS/Atlas/releases/download/%AtlasOSVersion%/AtlasPlaybook_v%AtlasOSVersion%.apbx
goto PlaybookEND
:PlaybookEND



:: Run VisualCppRedist_AIO_x86_x64.exe and install
VisualCppRedist_AIO_x86_x64.exe /y

:: Run dxwebsetup.exe quietly
dxwebsetup.exe /q

:: Run JavaInstall.exe
JavaInstall.exe

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
if exist amd-software-adrenalin-edition-24.6.1-minimalsetup-240626_web.exe ( 
 amd-software-adrenalin-edition-24.6.1-minimalsetup-240626_web.exe
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
del GeForce_Experience_v%NvidiaVersion%.exe
del amd-software-adrenalin-edition-24.6.1-minimalsetup-240626_web.exe

cls
@ECHO running AME Wizard
@ECHO when asked for a playbook choose the one you chose to download earlier
@ECHO (AtlasOS or ReviOS) 
@ECHO Install it, choose your prefered browser and settings.
@ECHO If you dont know which browser or settings to choose then just use the defaults.
@ECHO The playbook simply debloats Windows and tweaks it to make it run smoother
@ECHO If you do not want to do this, simply close this window and delete the "ssp" directory, otherwise please
@ECHO Off
Pause
@ECHO Off
:: Run AME Wizard
AME-Wizard-Beta.exe


