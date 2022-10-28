# wifi-plug

## Introduction

This is a 3D-printable [OpenSCAD](https://openscad.org/) plug to fill up those
empty WIFI antenna holes left behind when you remove the WIFI capability from
your computer.

![Image of WIFI Plug](../media/media/mount-view.jpg?raw=true "Glorious WIFI Plug")

## Model and Parts

The model consists of a bolt and fastener, with the fastener available in two
forms (cap or nut).

<div class="model" data-name="WIFI Plug Bolt" data-icon-size="128" data-left-icon="wifi-plug-bolt.icon.png" data-left="wifi-plug-bolt.stl"><!-- expanded by annotate-model --><table align="center" width="100%"><tbody><tr width="100%"><td align="center" width="160" height="160"><a href="../media/media/wifi-plug-bolt.stl" target="_blank" title="View WIFI Plug Bolt Model"><img src="../media/media/wifi-plug-bolt.icon.png" alt="WIFI Plug Bolt Model" width="128" height="128" /></a></td><td>

### Bolt

The bolt is a 1/4"-20 UNC thread, that has been "squared-off" on
one side. Standard threading for antennas is a finer 1/4"-36 UNS, but
the coarse thread prints easier.

</td></tr></tbody></table></div>

<div class="model" data-name="WIFI Plug Cap" data-icon-size="128" data-left-icon="wifi-plug-cap.icon.png" data-left="wifi-plug-cap.stl"><!-- expanded by annotate-model --><table align="center" width="100%"><tbody><tr width="100%"><td align="center" width="160" height="160"><a href="../media/media/wifi-plug-cap.stl" target="_blank" title="View WIFI Plug Cap Model"><img src="../media/media/wifi-plug-cap.icon.png" alt="WIFI Plug Cap Model" width="128" height="128" /></a></td><td>

### Cap

A knurled cap that matches the bolt. It is slightly longer than
the bolt so it should completely cover the bolt.

</td></tr></tbody></table></div>

<div class="model" data-name="WIFI Plug Nut" data-icon-size="128" data-left-icon="wifi-plug-nut.icon.png" data-left="wifi-plug-nut.stl"><!-- expanded by annotate-model --><table align="center" width="100%"><tbody><tr width="100%"><td align="center" width="160" height="160"><a href="../media/media/wifi-plug-nut.stl" target="_blank" title="View WIFI Plug Nut Model"><img src="../media/media/wifi-plug-nut.icon.png" alt="WIFI Plug Nut Model" width="128" height="128" /></a></td><td>

### Nut

A nut that matches the bolt is provided, mostly for convenience.

</td></tr></tbody></table></div>

## Printing

I use a Creality Ender 3 Pro to build from PLA with a **layer height of 0.12 mm**.

**N.B.** The bolt part is sized to the exact specification of the metal parts
(6.35mm outer diameter with 5.85mm across the flat part), but, depending on the
accuracy of your printer, you may wish to scale the part to accommodate. You can
do this either in source (the scale percentage) or in your slicing software. I
use a 2% oversize.

## Installation

Just figure out the bolt's flat side, align it with the hole's flat side, slid
the bolt thru the hole, and screw on the cap or nut.

## Source

The models are built using OpenSCAD. *wifi-plug.scad* is the common main file
for all parts. *wifi-plug-bolt.scad*, *wifi-plug-cap.scad*, and *wifi-plug-nut.scad*
build the individual parts.

### Libraries

You'll need the following openscad libraries (four for threading - as described
by [threadlib](https://github.com/adrianschlatter/threadlib), another
for the knurled finish on the cap, as well as the semi-standard MCAD
library):

- [MCAD](https://github.com/openscad/MCAD)
- [scad-utils](https://github.com/openscad/scad-utils)
- [list-comprehension](https://github.com/openscad/list-comprehension-demos)
- [threadprofile.scad](https://github.com/MisterHW/IoP-satellite/blob/master/OpenSCAD%20bottle%20threads/thread_profile.scad)
- [threadlib](https://github.com/adrianschlatter/threadlib)
- [knurledFinishLib\_v2\_1.scad](https://www.thingiverse.com/thing:4146258)

Save all of these into your OpenSCAD [library folder](https://wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries)
and then the folder should now include the following files and directories:

```
    libraries
    ├── knurledFinishLib_v2_1.scad
    ├── list-comprehension-demos/
    ├── MCAD/
    ├── scad-utils/
    ├── threadlib/
    └── thread_profile.scad
```

Alternately, if you're building on Linux, `make local-libraries` should fetch all the files
and place them in the local directory "./libraries". Then, you can set the environment variable
[OPENSCADPATH](https://wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries#Setting_OPENSCADPATH)
to include that directory in OpenSCAD's library search path.

## Also Available on Thingiverse

STLs are available on [Thingiverse](https://www.thingiverse.com/thing:).
