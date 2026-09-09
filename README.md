<div align="center">

# NVIDIA PRIME Offload Launcher

We laptop users with hybrid graphics all know the headache that kicks in every time you try to launch an application on your dedicated NVIDIA GPU. You'll end up using the terminal with a long command every time with every app, which'll get old fast.

This widget does not fix the whole issue, but makes it easier.

![NVIDIA](https://img.shields.io/badge/NVIDIA-PRIME%20Offload-76B900)
![KDE Plasma 6](https://img.shields.io/badge/KDE-Plasma%206-1D99F3)
![License](https://img.shields.io/badge/license-MIT-green)

</div>

## Install

Clone the repository:

```bash
cd org.kde.plasma.org.kde.plasma.primelauncher
kpackagetool6 -i .
# or, on older Plasma:
kpackagetool5 -i .
```
Then open **Add Widgets** and add **NVIDIA PRIME Offload Launcher**.

## What it does

A simple KDE Plasma widget for launching applications with NVIDIA PRIME
Render Offload. Instead of manually typing the PRIME environment variables
every time, enter an application command and launch it directly through
the widget. It also lets you save frequently used application commands for
quick access later.
