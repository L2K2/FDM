/*
 * A 3d model for measuring the manufacturing tolerance of a 3d printer.
 *
 * Here, the tolerance is determined as the tolerance of diameter.
 *
 */

use <TextGenerator.scad>

module rounded_cubic_cylinder(w,d,h,r)
{
	union()
	{
		for (x = [-(w/2-r),w/2-r]) {
			for (y = [-(d/2-r),d/2-r]) {
				translate([x,y,0]) cylinder(h = h, r = r);
			}
		}
		translate([-(w-2*r)/2,-d/2,0]) cube([w-2*r,d,h]);
		translate([-w/2,-(d-2*r)/2,0]) cube([w,d-2*r,h]);
	}
}

module male(clearance,text)
{
	union()
	{
		union()
		{
			rounded_cubic_cylinder(10-clearance,10-clearance,2,2.5);
			translate([0,2.5,0]) rounded_cubic_cylinder(6,2,6,0);
		}
		translate([-4.25,-2.5,1.5]) scale([0.5,0.5,1]) drawtext(text);
	}
}

// Female part with a 10-mm (nominal) rounded square hole.
difference()
{
	rounded_cubic_cylinder(20,30,2,5);
	translate([0,5,-1]) rounded_cubic_cylinder(10,10,4,2.5);
	translate([-8.5,-12,1.5]) drawtext("TOP");
}

// Four male parts, with varying clearances.
translate([17.5,7.5,0]) male(0,"0.0");
translate([17.5,-7.5,0]) male(0.1,"0.1");
translate([30,7.5,0]) male(0.2,"0.2");
translate([30,-7.5,0]) male(0.3,"0.3");
