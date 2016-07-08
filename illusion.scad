
pts = [for(theta = [0 : 5 : 360]) let(
    elevation = 45,
    x = sign(270 - theta) * sign(90 - theta) * (2 * abs(tan(theta)) + 1) / (2 * tan(theta) * tan(theta) + 2 * abs(tan(theta)) + 1),
    y = sign(180 - theta) * (1 - abs(x) + sqrt(1 - x * x)) / 2,
    z = sign(180 - theta) * (1 - abs(x) - sqrt(1 - x * x)) * cos(elevation) / 2)
    [x, y, z]
    ];

module rod(height) {
    hull() {
        sphere(d = 1);
        translate([0, 0, height]) sphere(d = 1);
    }
}

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

translate([-2 * 32.5 / 3, 0, 0]) object(10, 10);
object(10, 10);
translate([2 * 32.5 / 3, 0, 0]) object(10, 10);

translate([-32.5 / 3, 10, 0]) object(10, 10);
translate([32.5 / 3, 10, 0]) object(10, 10);