# kicad-models
A variety of part models for Kicad

## Directory format

* *lib* - Library files of useful openscad modules.
* *parts* - Model definitions for different parts. Each folder should contain the following:
  * *datasheet.pdf* - A datasheet for the part in question that is being used as the source for dimensions.
  * *$part.scad* - An open scad file describing a model for the part.

## Model scales and orientations

All models are scaled in mm, this means that when they are finally exported to .wrl files a scaling factor of 0.3937 to convert to centi-inches(... good job Kicad).
All models should be orientated with +Z as 'up'.

## Model build process
1. Render the openscad file to an ascii stl file *$part.stl*
1. Convert that asciistl file to a binary stl file with meshconv *$part.binary.stl*
1. Read that binary stl into wings3d, add materials and render to VRML *$part.wrl*
