/* A clamp for Nokia 808, requires the plate, and a 5 mm bolt and a winged nut.
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

phone_width = 60;
phone_thickness = 14;

adapter_width = 35;

width = 39;
depth = 40;
height = 8;
thickness_side = 4;
thickness_base = 3;
eps = 0.001;

difference() {
    union() {
        translate([0, 12, -4])
        rotate([180, 0, 90])
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
        }
    
        translate([-adapter_width/2, -5, -5]) cube([adapter_width, phone_thickness + 5 + 15, phone_width + 5 + 5]);
    }    

    translate([-(adapter_width-10)/2, -10, 20]) cube([adapter_width - 20, phone_thickness + 10, 100]);
    
    // A cut out for Nokia 808 phone.
    translate([-20, 0, 0])
    rotate([90, 0, 90])
    linear_extrude(height = 40, center = false, convexity = 10, twist = 0, slices = 10)
    polygon([[-10, 2], [-2, 2], [0, 0], [phone_thickness - 5, 0], [phone_thickness, 5], [phone_thickness, phone_width - 5], [phone_thickness - 5, phone_width], [0, phone_width], [-2, phone_width - 2], [-10, phone_width - 2]]);
    
    // Holes.
    for (position = [-9, 9]) {
        translate([position, 14 + 7.5, -10]) cylinder(d = 6.5, h = phone_width + 20);
    }
    
    for (position = [-9, 9]) {
        translate([-10.5/2 + position, -50, 35]) cube([10.5, 100, 7]);
        translate([-13.5/2 + position, -50, 40]) cube([13.5, 100, 2]);
    }
    
    translate([-50, -50, 45]) cube([100, 100, 25]);
}
