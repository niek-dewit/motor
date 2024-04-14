include <./frame.scad>

transparancy = 1;



renderFrame();



//renderLayer1Shell();

module sidePacks() {
    difference() {
        union() {
            intersection() {
                import("../frame-area4.stl", convexity=3);
                color("red") translate([-500, 120, -1500]) cube([2000, 80, 2000]);
            }
            intersection() {
                import("../frame-area4.stl", convexity=3);
                color("red") translate([-500, 13.3333, -1500]) cube([2000, 80, 2000]);
            }
        }
        translate([630, 0, -1500]) cube([1000, 1000, 2000]);
        translate([-200, 0, 0]) rotate([0, 20, 0]) cube([2000, 1000, 1000]);
        translate([0, 100, -1630]) cube([1000, 1000, 1000]);
        translate([-490, 100, -1300]) rotate([0, -23.8, 0]) cube([1000, 1000, 1000]);

    }
}


color("red", transparancy) sidePacks();
mirror([0,1]) {
    color("red", transparancy) sidePacks();
}

