/*
 * A PCB-box to-be-printed, license CC-BY-SA 4.0.
 *
 * http://creativecommons.org/licenses/by-sa/4.0/
 *
 * Author L2K2
 * Version 0.1
 */

// Board dimensions.
x = 80;
y = 80;

// Internal extra spacing, one sided. 
dx = 1;
dy = 1;

// Wall thickness.
th = 2;

// Spacing in z-direction.
sp_below = 2;
sp_above = 23;
sp_seal = 4;

// For tight fits, i.e., the seal in the lid, some slack.
tolerance = 0.125;
eps = 0.001;

module mount_hole(x = 0, y = 0, z = 0, d = 5) {
    translate([x, y, 0])
    difference() {
        translate([-d / 2 - th, -d / 2 - th, 0])
        cube([d + 2 * th, d + 2 * th, th + z], center = false);
        translate([0, 0, th])
        cylinder(h = z + th, d = d, center = false, $fn = 12);
    }
}
module inverse_hole(x = 0, y = 0, z = 0, d = 5) {
    translate([x, y, -th])
    cylinder(h = z + 2 * th, d = d, center = false, $fn = 12);
}

// Main box.
translate([0, y / 2 + dy + th + 1, 0]) {
    difference() {
        union() {
            difference() {
                translate([-x / 2 - dx - th, -y / 2 - dy - th, 0])
                cube([x + 2 * dx + 2 * th, y + 2 * dy + 2 * th, th + sp_below + sp_above], center = false);
                translate([-x / 2 - dx, -y / 2 - dy, th])
                cube([x + 2 * dx, y + 2 * dy, th + sp_below + sp_above], center = false);
            }
            mount_hole(35, 35, sp_below, 3);
            mount_hole(-35, 35, sp_below, 3);
            mount_hole(-35, -35, sp_below, 3);
            mount_hole(35, -35, sp_below, 3);
        }
        
        inverse_hole(35, 35, sp_below, 3);
        inverse_hole(-35, 35, sp_below, 3);
        inverse_hole(-35, -35, sp_below, 3);
        inverse_hole(35, -35, sp_below, 3);
        
    
        translate([-5, y / 2,  th + sp_below + sp_above - 5])
        cube([10, 2 * th, th + 5], center = false);
        translate([0, y / 2, th + sp_below + sp_above - 5])
        rotate([-90, 0, 0])
        inverse_hole(0, 0, 10, 10);
        translate([-x / 2 - dx - tolerance, -y / 2 - dy - tolerance, th + sp_below + sp_above - sp_seal - tolerance])
        cube([x + 2 * dx + 2 * tolerance, y + 2 * dy + 2 * tolerance, tolerance + sp_seal + tolerance], center = false);
    }
}

// Lid.
translate([0, -y / 2 - dy - th - 1, 0]) {
    difference() {
        union() {
            translate([-x / 2 - dx - th, -y / 2 - dy - th, 0])
            cube([x + 2 * dx + 2 * th, y + 2 * dy + 2 * th, th], center = false);
            
            translate([-5 - tolerance, -y / 2 - dy - th, 0])
            cube([10 - 2 * tolerance, 2 * th, th + 5], center = false);
            
            difference() {
                union() {
                    translate([-x / 2 - dx + tolerance, -y / 2 - dy + tolerance, 0])
                    cube([x + 2 * dx - 2 * tolerance, y + 2 * dy - 2 * tolerance, th + sp_seal], center = false);
                }        
                translate([-x / 2 - dx + th, -y / 2 - dy + th, 0 ])
                cube([x + 2 * dx - 2 * th, y + 2 * dy - 2 * th, th + sp_seal + th], center = false);
            }
            mount_hole(35, 35, sp_above - 1.6, 3);
            mount_hole(-35, 35, sp_above - 1.6, 3);
            mount_hole(-35, -35, sp_above - 1.6, 3);
            mount_hole(35, -35, sp_above - 1.6, 3);
        }    
    translate([0, -y / 2 - 5, th + 5])
    rotate([-90, 0, 0])
    inverse_hole(0, 0, 10, 10);
    translate([-5 - 2 * tolerance, -y / 2 - dy - th - tolerance, th + sp_seal])
    cube([10 - 4 * tolerance, 2 * th + 2 * tolerance, th + 5], center = false);
}
}
