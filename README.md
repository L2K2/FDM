# FMD
A repository for containing some 3d models for fused deposition modeling.

## Tolerance
*Tolerance.scad* is an OpenSCAD model containing a 10-mm-square mortise and
matching 10-mm-square tenons. The tenon tolerance is defined as the tolerance
of the diameter. That is, the 0.3-mm tolerance tenon is 9.7 mm times 9.7 mm.
The tolerance model is licenced under CC-BY-SA 3.0.

*Tolerance.stl* is an STL file containing the tesselation of the previous model.
That is, it is in principle an OpenSCAD-compiler output of *Tolerance.scad*.
However, I have still decided to include it here, as it is far more common
format than SCAD files.

The whole model takes approximately 15 minutes of printing time using an
upgraded miniFactory 2 printer. (Tested using one of the 3d-printers of
Helsinki Metropolitan Area Libraries; which, by the way are free to use for
any person. And that is free as in beer.)

## TextGenerator
*TextGenerator.scad* is a (very) minor modification of the OpenSCAD text
generator by username pgreenland at Thingiverse. It is licenced under CC-BY-SA
3.0.

