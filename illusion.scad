/*
 * An optical illusion of five adjecent rectangles morphing into the Olympic rings when looking from the other side.
 * The illusion works best when viewed at a 45 degree elevation.
 *
 * Licence CC-BY-SA 4.0, https://creativecommons.org/licenses/by-sa/4.0/ , feel free to remix.
 *
 * L2K2, 20160708
 */

// Generate the shape that looks like a rectangle from one side and a circle from the other.
pts = [for(theta = [0 : 5 : 360]) let(
    elevation = 45,
    x = sign(270 - theta) * sign(90 - theta) * (2 * abs(tan(theta)) + 1) / (2 * tan(theta) * tan(theta) + 2 * abs(tan(theta)) + 1),
    y = sign(180 - theta) * (1 - abs(x) + sqrt(1 - x * x)) / 2,
    z = sign(180 - theta) * (1 - abs(x) - sqrt(1 - x * x)) * cos(elevation) / 2)
    [x, y, z]
    ];

// A solid 1-mm diameter rod, generated as a convex hull of two spheres.
module rod(height) {
    hull() {
        sphere(d = 1);
        translate([0, 0, height]) sphere(d = 1);
    }
}

// The illuding object, generated as an union of convex hulls of neighbouring rods.
module object(radius, height) {
    for(i = [1 : len(pts) - 1]) {
        hull() {
            hull() {
                translate(radius * pts[i - 1]) rod(height);
            }
            hull() {
                translate(radius * pts[i]) rod(height);
            }
        }
    }
}

// Insert the rings.
translate([-2 * 32.5 / 3, 0, 0]) object(10, 10);
object(10, 10);
translate([2 * 32.5 / 3, 0, 0]) object(10, 10);

translate([-32.5 / 3, 10, 0]) object(10, 10);
translate([32.5 / 3, 10, 0]) object(10, 10);
