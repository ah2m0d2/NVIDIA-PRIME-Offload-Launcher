<div align="center">

# NVIDIA PRIME Offload Launcher

We laptop users with hybrid graphics all know the headache that kicks in every time you try to launch an application on your dedicated NVIDIA GPU. You'll end up using the terminal with a long command every time with every app, which'll get old fast.

This widget does not fix the whole issue, but makes it easier.

![NVIDIA](https://img.shields.io/badge/NVIDIA-PRIME%20Offload-76B900)
![KDE Plasma 6](https://img.shields.io/badge/KDE-Plasma%206-1D99F3)
![License](https://img.shields.io/badge/license-MIT-green)

</div>

<div align="center">

## Install

</div>


Open terminal to **org.kde.plasma.primelauncher**
```bash
cd org.kde.plasma.org.kde.plasma.primelauncher
kpackagetool6 -i .
# or, on older Plasma:
kpackagetool5 -i .
```
Then open **Add Widgets** and add **NVIDIA PRIME Offload Launcher** to your desktop.
<div align="center">
  
## What it does

</div>
A simple KDE Plasma widget for launching applications with NVIDIA PRIME
Render Offload. Instead of manually typing the PRIME environment variables
every time, enter an application command and launch it directly through
the widget. It also lets you save frequently used application commands for
quick access later.
<br>
<br>
<div align="center">
<img width="384" height="240" alt="widget" src="https://github.com/user-attachments/assets/930e3987-1516-4417-aeb0-0165f720c7e8" />

</div>

## Usage

Enter an application command, for example:
 
```
/usr/bin/furmark
```

Click **Launch with NVIDIA**. The widget launches the application with:
 
```
__NV_PRIME_RENDER_OFFLOAD=1
__GLX_VENDOR_LIBRARY_NAME=nvidia
```
 
### Saved applications
 
Enter a command, click **Save**. Saved applications appear in the widget
and can be:
 
- Launched with NVIDIA
- Selected and copied
- Removed
- Saved across restarts

## Requirements
 
- KDE Plasma 6
- NVIDIA GPU
- NVIDIA proprietary drivers
- PRIME Render Offload configured and working

This widget does not configure NVIDIA drivers or PRIME Render Offload.

## Uninstall
 
```bash
kpackagetool6 -t Plasma/Applet -r org.kde.plasma.primelauncher
```
or through your widgets menu.

## License
 
MIT.
