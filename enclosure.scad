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
dy = 6;

// Wall thickness.
th = 2;
th_seal = 5;

// Spacing in z-direction.
sp_below = 2;
sp_above = 23;
sp_seal = 1;

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
        translate([-x / 2 - dx - th, -y / 2 - dy - th, 0])
        cube([x + 2 * dx + 2 * th, y + 2 * dy + 2 * th, th + sp_below + sp_above + sp_seal], center = false);
        
        translate([-x / 2 - dx, -y / 2 - dy, th])
        cube([x + 2 * dx, y + 2 * dy, th + sp_below + sp_above + sp_seal], center = false); 
        
        translate([-x / 2 - dx - tolerance, -y / 2 - dy - tolerance, th + sp_below + sp_above])
        cube([x + 2 * dx + 2 * tolerance, y + 2 * dy + 2 * tolerance, th + sp_seal], center = false); 
    }

    // Mount holes.
    mount_hole(35, 35, sp_below, 3);
    mount_hole(-35, 35, sp_below, 3);
    mount_hole(-35, -35, sp_below, 3);
    mount_hole(35, -35, sp_below, 3);

    mount_hole(39, 44, sp_below + sp_above, 3);
    mount_hole(-39, 44, sp_below + sp_above, 3);
    mount_hole(-39, -44, sp_below + sp_above, 3);
    mount_hole(39, -44, sp_below + sp_above, 3);
}

// Lid.
translate([0, -y / 2 - dy - th - 1, 0]) {
    difference() {
        union() {
            translate([-x / 2 - dx - th, -y / 2 - dy - th, 0])
            cube([x + 2 * dx + 2 * th, y + 2 * dy + 2 * th, th], center = false);
            translate([-x / 2 - dx + tolerance, -y / 2 - dy + tolerance, 0])
            cube([x + 2 * dx - 2 * tolerance, y + 2 * dy - 2 * tolerance, th + sp_seal], center = false);
        }
        
        translate([-x / 2 - dx + th_seal, -y / 2 - dy + th_seal, th + sp_seal / 2])
        cube([x + 2 * dx - 2 * th_seal, y + 2 * dy - 2 * th_seal, th + sp_seal], center = false);

        inverse_hole(39, 44, th + sp_seal + th, 3);
        inverse_hole(-39, 44, th + sp_seal + th, 3);
        inverse_hole(-39, -44, th + sp_seal + th, 3);
        inverse_hole(39, -44, th + sp_seal + th, 3);
    }
}
