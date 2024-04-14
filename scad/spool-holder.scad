    $fn= 64;
difference() {
    cylinder(3, 40, 40);
    translate([30,0,-5]) cylinder(15, 2.5, 2.5);
    translate([-30,0,-5]) cylinder(15, 2.5, 2.5);
    translate([0,30,-5]) cylinder(15, 2.5, 2.5);

}
//difference() {
//    cylinder(20, 15, 15);
//    cylinder(25, 10, 10);
//    translate([-10,0,0]) cube([20, 20, 25]);
//
//    translate([-15,3,0]) cube([30, 30, 25]);
//
//}
//translate([-15,0,0]) cube([5, 10, 20]);
//translate([10,0,0]) cube([5, 10, 20]);

//translate([-12.5,10,0]) cylinder(20, 2.5, 2.5);
//translate([12.5,10,0]) cylinder(20, 2.5, 2.5);
//
//difference() {
//    translate([-2.5,-35,0]) cube([5, 25, 20]);
//    translate([-10,-34.5,25.5]) rotate([90,0,90]) cylinder(20, 20.5, 20.5);
//
//}

