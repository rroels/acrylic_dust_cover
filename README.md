# Parametric Acrylic Dust Cover for 3D Printer

> [!WARNING]
> This is not meant to enclose an active 3D printer!
> This is merely a dust cover for when the printer is inactive.

> [!WARNING]
> This is a work in progress, and is not ready for use!

## Introduction

I wanted to keep my Prusa Mini 3D printer safe from dust, while still keeping it visible.

For this reason I designed a box that can be laser-cut from acrylic panels. 

The OpenSCAD design is parameteric, meaning that you can simply change some parameters (e.g. the size), and the code will generate a box that meets your requirements.

## BOM

* 5 x Acrylic panels (generated from included OpenSCAD code)
* 20 x M4 Screws, 8mm
* 20 x Metal L-shaped corner bracket
* 4 x Corner braces
  * Either 3D printed from the provided model
  * Or can be bought as "silicon fish tank corner protector"


## How to use

Open `main.scad` in OpenSCAD. The most important parameters to edit are:

```
// inner box size
box_depth = 360;
box_height = 400;
box_width = 450;
```

Note that these are the inside dimensions of the desired box, so the final result will be slightly larger, depending on `panel_thickness`.

## Result

TODO

