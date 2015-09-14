/*
 * A chain guard generator.
 *
 * Licenced under CC-BY-SA 4.0.
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 */

function angular_distance(angle) = abs((angle) % (360 / N) - 180 / N);

BCD = 130;
N = 5;

t = 48;

chain_pitch = .500 * 25.4;
protection_diameter = 12.7;

r_exterior = chain_pitch * t / PI / 2 + protection_diameter / 2;
r_interior = BCD / 2 - 8;

scale_parameter = (r_exterior - protection_diameter - r_interior) / pow(360 / N / 2 - 5 / 16 * 25.4 / r_interior * 180 / PI, 4);
echo(scale_parameter);

thickness = 3;

difference() {
    // A polygon for generating a cylinder, could as well use cylinder with $fn = 360.
    linear_extrude(thickness) polygon([ for (angle = [0 : 1 : 360 - 1]) r_exterior * [cos(angle), sin(angle)] ]);
    // A polygon for generating a cylinder, see above.
    translate([0, 0, -1]) linear_extrude(thickness + 2) polygon([ for (angle = [0 : 1 : 360 - 1]) r_interior * [cos(angle), sin(angle)] ]);
    // The bolt holes.
    for (angle = [0 : 360 / N : 360 - 360 / N]) {
        rotate([0, 0, angle]) translate([130 / 2, 0, -1]) cylinder(h = thickness + 2, r = 5, center = false);
        rotate([0, 0, angle]) translate([130 / 2, 0, thickness - 1]) cylinder(h = 2, r = .250 * 25.4, center = false);
    }
    // Saving some material.
    translate([0, 0, -1]) linear_extrude(thickness + 2) polygon([ for (angle = [0 : 1 : 360 - 1]) max((r_exterior - protection_diameter - scale_parameter * pow(angular_distance(angle), 4)),50) * [cos(angle), sin(angle)] ]);
}
