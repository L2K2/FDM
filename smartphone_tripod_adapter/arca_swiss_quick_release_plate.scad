/* An Arca-Swiss compatible quick-release plate.
 *
 * Author: Lari Koponen
 * Version: 0.0
 */

module rounded_cubic_cylinder(w,d,h,r)
{
	union()
	{
		for (x = [-(w/2-r),w/2-r]) {
			for (y = [-(d/2-r),d/2-r]) {
				translate([x,y,0]) cylinder(h = h, r = r, $fn = 16);
			}
		}
		translate([-(w-2*r)/2,-d/2,0]) cube([w-2*r,d,h]);
		translate([-w/2,-(d-2*r)/2,0]) cube([w,d-2*r,h]);
	}
}

width = 39;
depth = 30;
height = 8;
thickness_side = 4;
thickness_base = 3;

width_hole = 5;
depth_hole = 14;

eps = 0.001;

debug = false;

difference() {
    // The plate.
    x1 = width;
    y1 = depth;
    z1 = height;
    rounded_cubic_cylinder(x1, y1, z1, thickness_side);
    
    // Center cut out.
    x2 = width - 2 * thickness_side;
    y2 = depth - 2 * thickness_side;
    z2 = height - thickness_base + eps;
    translate([0, 0, thickness_base]) rounded_cubic_cylinder(x2, y2, z2, thickness_side);
    
    // Holes.
    for (position = [-9, 0, 9]) {
        translate([position, 0, -eps]) rounded_cubic_cylinder(width_hole, depth_hole, thickness_base + 2 * eps, width_hole/2);
    }
    
    // Left and right dovetail.
    for (sign = [-1, 1]) {
        translate([34/2 * sign, -20 * sign, thickness_base])
        rotate([90, 0, 90 + 90 * sign])
        linear_extrude(height = 40, center = false, convexity = 10, twist = 0, slices = 10)
        polygon([[0, 0], [0, 1], [-4, 5], [-4, 0]]);
    }
    
    // Front and back ramps.
    for (sign = [-1, 1]) {
        //translate([34/2 * sign, -20 * sign, thickness_base])
        translate([4 * sign, depth/2 * sign, height])
        rotate([90, 0, 180 + 90 * sign])
        linear_extrude(height = 8, center = false, convexity = 10, twist = 0, slices = 8)
        polygon([[-1, 1], [-1, -4], [4, 1]]);
    }
    
    if(debug) {
        translate([-50, -100, -50]) cube([100, 100, 100]);
    }
}

