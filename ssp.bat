title easy prep

cls

:: creating temp folder

echo creating folder
@echo off
mkdir simplesystemprep
cls

:: downloading files

echo downloading privacy script
@echo off
powershell Invoke-WebRequest -Uri https://raw.githubusercontent.com/Smealm/simplesystemprep/main/resources/privacy-script.bat -OutFile privacy-script.bat
@echo off
move privacy-script.bat simplesystemprep/
cls

echo downloading DirectX Web Installer
@echo off
powershell Invoke-WebRequest -Uri https://github.com/Smealm/simplesystemprep/raw/main/resources/dxwebsetup.exe -OutFile dxwebsetup.exe
@echo off
move dxwebsetup.exe simplesystemprep/
cls

echo downloading Steam and MalwareBytes
@echo off
powershell Invoke-WebRequest -Uri https://github.com/Smealm/simplesystemprep/raw/main/resources/Ninite.exe -OutFile ninite.exe
@echo off
move ninite.exe simplesystemprep/
cls

echo downloading Virtual Studio Redistributable
@echo off
powershell Invoke-WebRequest -Uri https://rebrand.ly/vcpp -OutFile VisualCppRedist_AIO_x86_x64.exe
@echo off
move VisualCppRedist_AIO_x86_x64.exe simplesystemprep/
cls

echo downloading Heroic Launcher (Epic Games and GOG)
@echo off
powershell Invoke-WebRequest -Uri https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher/releases/download/v2.9.2/Heroic-2.9.2-Setup-x64.exe -OutFile heroic.exe
@echo off
move heroic.exe simplesystemprep/
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

echo installing Steam and MalwareBytes
@echo off
start /w simplesystemprep/ninite.exe
@echo off
del /f /q simplesystemprep\ninite.exe
cls

echo installing Heroic Launcher (Epic Games and GOG)
@echo off
start /w simplesystemprep/heroic.exe
@echo off
del /f /q simplesystemprep\heroic.exe
cls

echo running windows activation script
@echo off
echo Initialising
powershell -c "irm https://massgrave.dev/get | iex"
cls

echo running privacy script
@echo off
start /w simplesystemprep\privacy-script.bat
@echo off
del /f /q simplesystemprep\privacy-script.bat
cls

@echo cleaning up
del /f /q simplesystemprep\
cls

@echo all actions completed
pause
exit /b 0