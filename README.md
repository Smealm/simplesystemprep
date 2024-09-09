# simplesystemprep
a script that automates what i do after installing windows

This script does the following

1. Checks if windows is activated, if not then runs an [Activation Script](https://massgrave.dev/#mas-latest-release)
2. Installs common system dependencies used for games, this includes [OpenAL](https://docs.google.com/document/d/1j7hqIk0LzMnagk4GHHHk13Bb2L-zt9KRqRRVsnGpLCE/edit#heading=h.nu0xc1c2nmo4), [PhysX](https://www.nvidia.com/en-us/drivers/physx/physx-9-21-0713-driver/), [Java Runtime](https://www.java.com/en/download/help/whatis_java.html), [.Net Framework](https://dotnet.microsoft.com/en-us/learn/dotnet/what-is-dotnet-framework), [DirectX](https://www.windowscentral.com/what-directx-why-does-matter-gaming), [Visual C++](https://steamcommunity.com/discussions/forum/1/3361397532267699321/), [XNA Framework](https://en.wikipedia.org/wiki/Microsoft_XNA)
3. Installs GPU drivers, [Adrenalin](https://www.amd.com/en/products/software/adrenalin.html) for AMD and [Geforce](https://www.nvidia.com/en-us/geforce/geforce-experience/) for NVidia
4. Installs Game Launchers, [Steam](https://store.steampowered.com/), [Epic Games](https://store.epicgames.com), [GOG](https://www.gog.com/galaxy) and (Optionally)[Heroic](https://heroicgameslauncher.com/)
5. Installs Emulation software, [RetroArch](https://www.retroarch.com/), [Google Play Games](https://play.google.com/googleplaygames) and [Flashpoint](https://flashpointarchive.org/)
6. Installs [AME Wizard](https://ameliorated.io/) and your prefered [Playbook](https://docs.ameliorated.io/playbooks.html)
7. If script is ran as an administrator it will ask if you want to restart your PC after everything is finished (Recommended after installing certain system dependencies and most drivers)

Most things in the script are optional and can be skipped

Might be better to just use [WinUtil](https://github.com/ChrisTitusTech/winutil) or something for software downloading, which is most of what this script does.
