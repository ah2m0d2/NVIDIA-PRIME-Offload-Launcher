# NVIDIA PRIME Offload Launcher — Plasma Widget

Shows what's currently running on your NVIDIA GPU via PRIME on-demand offload,
right in your panel or desktop.

## Install (local testing)

```bash
cd org.kde.plasma.primestatus
kpackagetool6 -i .        # Plasma 6 (KDE Frameworks 6)
# or, on older Plasma:
# kpackagetool5 -i .
```

To update after editing:

```bash
kpackagetool6 -u .
```

Then right-click your panel (or desktop) → **Add Widgets** → search for
"PRIME Offload Status".

## How it works

Polls `nvidia-smi --query-compute-apps` every 5 seconds and shows how many
processes are currently running on the NVIDIA GPU. Click "Refresh now" for
an immediate check. The compact panel view just shows a count badge.

## Ideas to extend it

- Add process *names* to the expanded view, not just a count
- Add a "launch app with NVIDIA offload" button that runs
  `__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia <app>`
- Color the icon (green/red) based on idle vs active
- Add a config page (`contents/config/`) to let the user set the poll interval
- Detect `prime-select` mode too, if you ever install `nvidia-prime` and use
  full switching instead of on-demand offload
- Package it for the KDE Store (store.kde.org) once you're happy with it

## Publishing to GitHub

```bash
cd primestatus
git init
git add .
git commit -m "Initial PRIME offload status widget"
git remote add origin https://github.com/yourusername/plasma-prime-status.git
git push -u origin main
```

Add a LICENSE file (GPL-2.0-or-later or GPL-3.0 are the norm for Plasma
widgets) before pushing publicly.
