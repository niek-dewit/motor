

bottom_thickness = 0.5; //thickness of the bottom holder part
inside_diam = 18.8; //inside diameter of the cell holder
hole_diam = 9; //diameter of the center hole
height = 8; //total height of the holder
wall = 0.5; // wall size, number should be slightly bigger than nozzle size
resolution = 64; //best to be divisible by 4

screwInsertHoleDepth = 6;
screwInsertHoleDiameter = 4.5;
    
//End settings

diameter = inside_diam + wall;
rad=diameter/2;
$fn= resolution;

cellHeight = 65;

shellThickness = 3;
shellThicknessTopBottom = 2.25;
shellConnectingTollerance = 1;


shellCopperDistance = 0.25;
shellHoleDiameter = 3.3;
shellOverlapStepWidth = hole_diam/2;
shellReachLength = diameter * 1.5 - hole_diam / 2;

connectorLargeWidth = 4;
connectorSmallWidth = 2.5;
connectorLength = 2;
connectorTolerance = 0.2;

module testPackCell(){  
    translate([0,0, -0.005]) cylinder(h=height +0.01,d=hole_diam);
    translate([0,0, -0.005]) cylinder(h=height-bottom_thickness +0.01,d=inside_diam);
}

module testPackConnector(tolerance, heightAdditive = 0) {

    CubePoints = [
    [  (connectorLargeWidth - connectorSmallWidth) / 2 + (tolerance / 2),  0,  0 ],  //0
    [ connectorSmallWidth + (connectorLargeWidth - connectorSmallWidth) / 2 - (tolerance / 2),  0,  0 ],  //1
    [ connectorLargeWidth - (tolerance / 2),  connectorLength,  0 ],  //2
    [   (tolerance / 2),  connectorLength,  0 ],  //3
    [  (connectorLargeWidth - connectorSmallWidth) / 2 + (tolerance / 2),  0,  height + heightAdditive ],  //4
    [ connectorSmallWidth + (connectorLargeWidth - connectorSmallWidth) / 2 - (tolerance / 2),  0,  height + heightAdditive ],  //5
    [ connectorLargeWidth - (tolerance / 2),  connectorLength,  height + heightAdditive ],  //6
    [  (tolerance / 2),  connectorLength,  height + heightAdditive ]]; //7
    
    CubeFaces = [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3]]; // left
    
    translate([-connectorLargeWidth / 2, 0, 0]) polyhedron( CubePoints, CubeFaces );
}
 
module testPackHexSubtractive(
    row,
    col,
    connectorFront,
    connectorLeft
){
    for (a=[0:row-1]){
        posx=diameter*a; 
        for (b=[0:col-1]){
            posy=diameter*b; 
            translate([posx,posy,0]) testPackCell();
            if(a != row -1 && b != col -1) {
               translate([posx + rad,posy + rad,-1]) cylinder(h = screwInsertHoleDepth + 1, r = screwInsertHoleDiameter/2);
                translate([posx + rad,posy + rad,-0.5]) cylinder(h = height + 1, r = shellHoleDiameter/2);
            }
            if (b > 0 && b < col && connectorFront) {
                translate([-rad - 0.01, posy - rad,-0.5]) rotate([0,0,-90]) testPackConnector(0, 1);
            }
        }
        if (a > 0 && a < row && connectorLeft) {

            translate([posx + rad - diameter, -rad - 0.01,-0.5]) testPackConnector(0, 1);
        }
    }
}

module helperSubtractive(row, col){
    for (a=[0:row-1]){
        posx=diameter*a; 
        for (b=[0:col-1]){
            posy=diameter*b; 
            translate([posx,posy,0]) translate([0,0, -0.005]) cylinder(h=height +0.01,d=hole_diam);
            if(a != row -1 && b != col -1) {
                translate([posx + rad,posy + rad,-0.01]) cylinder(2.02, 7.7/2, 10/2);
            }

            translate([posx - 4,posy -0.5 - 7,-0.01]) cube([8,1,2.02]);
            translate([posx - 4,posy -0.5 + 7,-0.01]) cube([8,1,2.02]);
            translate([posx - 0.5 - 7,posy - 4,-0.01]) cube([1,8,2.02]);
            translate([posx - 0.5 + 7,posy - 4,-0.01]) cube([1,8,2.02]);

        }
    }
}


module testPackHexAdditive(row, col, connectorBack,connectorRight) {
    if(connectorRight) {
        for (a=[1:row-1]){
            posx=diameter*a; 
            translate([posx + rad - diameter, -rad + diameter * col,0]) testPackConnector(connectorTolerance);
        }
    }
    if(connectorBack) {
        for (b=[1:col -1]){
            posy=diameter*b; 
            translate([row * diameter - rad, posy - rad,0]) rotate([0,0,-90]) testPackConnector(connectorTolerance);
        }
    }
}

module helperAdditive(
    row,
    col
) {
    
    for (a=[1:row-1]){
        posx=diameter*a; 
        translate([posx + rad - diameter, -rad + diameter * col,0]) testPackConnector(connectorTolerance);
    }
    for (b=[1:col -1]){
        posy=diameter*b; 
        translate([row * diameter - rad, posy - rad,0]) rotate([0,0,-90]) testPackConnector(connectorTolerance);
    }
}

module testPackPack(
    row,
    col,
    connectorFront,
    connectorBack,
    connectorLeft,
    connectorRight
) {
    difference() {
        translate([-0.5* diameter, -0.5* diameter, 0]) cube([diameter * row, diameter*col, height]);
        testPackHexSubtractive(row, col, connectorFront, connectorLeft);
    }
    testPackHexAdditive(row, col, connectorBack, connectorRight);
}
      
module packHelper(row, col) {
    difference() {
        translate([-0.5* diameter, -0.5* diameter, 0]) cube([diameter * row, diameter*col, 2]);
        helperSubtractive(row, col);
    }
   // helperAdditive(row, col);
}
  
module packHelperPlug() {
    difference() {
        union() {
            translate([0 + rad,0 + rad,-0.01]) cylinder(2.02, 7.5/2, 9.8/2);
            translate([0 + rad,0 + rad,2]) cylinder(8, 9.8/2, 9.8/2);
        }
        translate([0 + rad,0 + rad,-4]) cylinder(20, 3.3/2, 3.3/2);

    }


}
module packCleaner() {
    translate([0,0,-35.01]) difference() {
        scale(0.62681) rotate([0,180,0]) import("./ImageToStl.com_endmill.stl");
        translate([-50,-50,-55]) cube([100,100,100]);
        translate([-50,-50,56.5 - 5 + 8]) cube([100,100,100]);

    }
 
    difference() {
        translate([0,0,0.01]) cylinder(h = 10, r = (inside_diam)/2);

        intersection() {
            union() {
                translate([-6.5/2, -6.5/2, 0]) cube([6.5, 6.5, 100]);
                intersection() {
                    union() {
                        rotate([0,90,0]) translate([-4,-6.5/2 + 0.7,-6.5/2 -2]) cylinder(10, r = 2.4/2);
                        mirror([0,1]) {
                            rotate([0,90,0]) translate([-4,-6.5/2 + 0.7,-6.5/2 -2]) cylinder(10, r = 2.4/2);
                        }
                        rotate([0,90,90]) translate([-4,-6.5/2 + 0.7,-6.5/2 -2]) cylinder(10, r = 2.4/2);
                        mirror([1,0]) {
                            rotate([0,90,90]) translate([-4,-6.5/2 + 0.7,-6.5/2 -2]) cylinder(10, r = 2.4/2);
                        }
                    }
                    cylinder(h = 20, r = 3.7);
                }
            }
            cylinder(h = 100, r = 4.4);

        }
    }



}


//pack
//rotate([180, 0, 0]) testPackPack(8, 3);
//
//rotate([0, 0, 0]) translate([0, diameter * -2, cellHeight - (height - bottom_thickness) * 2]) testPackPack(4, 3);
//translate([0, 0, -(height - bottom_thickness)]) cylinder(h = 65, r = 9);
//rotate([0, 0, 0]) translate([0,-100,0]) translate([-hole_diam/2, diameter/2 + shellThickness,shellThickness + cellHeight - height + bottom_thickness + shellCopperDistance]) testPackPack(8, 2);
//
//rotate([0, 0, 90]) translate([-hole_diam/2, diameter/2 - shellReachLength,shellThickness + cellHeight - height + bottom_thickness + shellCopperDistance]) testPackPack(8, 2);

module shellCubeStep1(width) {
    difference() {
        translate([0,0,0]) color("blue", 0.5) cube([diameter * width + (diameter - hole_diam), shellReachLength + shellThickness, cellHeight + shellCopperDistance * 2 + bottom_thickness * 2 + shellThicknessTopBottom * 2]);
        translate([0,shellThickness,shellThicknessTopBottom]) color("red", 0.5) cube([diameter * width + (diameter - hole_diam), diameter * 3, cellHeight + shellCopperDistance * 2 + bottom_thickness * 2]);
        translate([diameter * width, shellThickness / 2, shellThicknessTopBottom / 2]) color("yellow", 0.5) cube([diameter * width + (diameter - hole_diam), shellReachLength + shellThickness, cellHeight + shellCopperDistance * 2 + bottom_thickness * 2 + shellThicknessTopBottom]);
    }
}

module shellSection(width) {

    difference() {
        shellCubeStep1(width);
        translate([-diameter * width ,0,0]) shellCubeStep1(width);
        for (a =[0:width]) {
            if(a % 2 == 0) {
                translate([-hole_diam/2 + diameter/2 + diameter * a, diameter + shellThickness, -15]) cylinder(h = 100, r = shellHoleDiameter/2);
            }
        }
     }
}

module shellCornerSection(width) {

    difference() {
        translate([0,0,0]) color("blue", 0.5) cube([shellReachLength + shellThickness, diameter * width + (diameter - hole_diam), cellHeight + shellCopperDistance * 2 + bottom_thickness * 2 + shellThicknessTopBottom * 2]);
        translate([0, shellThickness, shellThicknessTopBottom]) color("red", 0.5) cube([shellReachLength, diameter * width + (diameter - hole_diam), cellHeight + shellCopperDistance * 2 + bottom_thickness * 2]);
        translate([- diameter * width, 0, 0]) shellCubeStep1(width);
        translate([-shellThickness/2,diameter* width,shellThicknessTopBottom/2]) color("yellow", 0.5) cube([shellReachLength + shellThickness,diameter * 2, cellHeight + shellCopperDistance * 2 + bottom_thickness * 2 + shellThicknessTopBottom]);

        for (a =[0:width]) {
            if(a % 2 == 0) {
                translate([-hole_diam/2 + diameter/2,-hole_diam/2 + diameter * 1.5 + diameter * a, -15]) cylinder(h = 100, r = shellHoleDiameter/2);
            }
        }
    }
}
module shellTopStep1(width, depth) {
    difference() {
        translate([0,-depth,0]) cube([diameter * width, shellReachLength + shellThickness + depth, 70 + shellThicknessTopBottom * 2]);
        translate([-5,-depth - 5,shellThicknessTopBottom]) cube([diameter * width + 10, shellReachLength + shellThickness + depth + 10, 70]);
    }
}


module topSection(width, depth, odd) {

    difference() {
        shellTopStep1(width, depth);
        for (a =[1:width - 1]) {
            if((a + (odd ? 0 : 1)) % 3 == 0) {
                translate([diameter * a, diameter + shellThickness, -15]) cylinder(h = 100, r = shellHoleDiameter/2);
            }
        }
     }
}

module connectingSection(length,depth, backWidth) {

    difference() {
        translate([0,-depth,shellThicknessTopBottom/2]) cube([length, shellReachLength + backWidth + depth, 70 + shellThicknessTopBottom]);
        translate([-5,-depth - 5,shellThicknessTopBottom]) cube([length + 10, shellReachLength + backWidth + depth + 10, 70]);
    }
    translate([0,shellReachLength + depth,shellThicknessTopBottom/2]) cube([length, backWidth, 70 + shellThicknessTopBottom]);
}
/*
testPackPack(
    row = 6,
    col = 9,
    connectorFront = false,
    connectorBack = true,
    connectorLeft = false,
    connectorRight = true
);

testPackPack(
    row = 6,
    col = 10,
    connectorFront = false,
    connectorBack = true,
    connectorLeft = true,
    connectorRight = false
);

testPackPack(
    row = 7,
    col = 9,
    connectorFront = true,
    connectorBack = false,
    connectorLeft = false,
    connectorRight = true
);*/

//testPackPack(
//    row = 7,
//    col = 10,
//    connectorFront = true,
//    connectorBack = false,
//    connectorLeft = true,
//    connectorRight = false
//);/**/
//translate([0,0,10]) packHelper(10,5);
//packCleaner();