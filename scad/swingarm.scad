include <NopSCADlib/utils/core/core.scad>
use <NopSCADlib/utils/sweep.scad>
use <NopSCADlib/utils/maths.scad>
use <NopSCADlib/utils/bezier.scad>

baseProfileWidth = 40;
baseProfileHeight = 91.5;
baseProfileInsetDepth = 3;
baseProfileInsetLength = 52;
baseLength = 570;
baseStraightLength = 220;
baseBendOffset = 85;
baseBendRadius = 100;
baseOffset = 50;

endBaseTaperWidthStart = 35;
endBaseTaperWidthEnd = 30;
endLength = 97.5;
endPreBaseTaperRadius = 30;
endBaseTaperHeightStart = 76;
endBaseTaperHeightEnd = 68;
endBaseTaperLength = 72.5;

endHeightTopChamferHeight = 13;
endHeightTopChamferLength = 10;
endHeightBottomChamferRadius = 12;
endWidthChamferDepth = 7.4;
endWidthChamferLength = 9.2;

insetLength = 92.5;
insetDepth = 23;

insetHeight = 22;

insetChamferDepth = 21.5;
insetChamferHeight = 19;
insetChamferLength = 87.5;
insetChamferRoundingHeight = 14.8;
insetChamferRoundingRadius = 12;

holeWidth = 21;
holeheight = 10;
holeInsetPadding = -8.5;

axleHoleWidth = 40;
axleHoleHeight = 20;
axleHolePadding = 15;

module swingarm() {
    //todo 40mm swingarm mounting cylinder



    module base() {
        baseProfile = [
            [0, 0, 0],
            [0, baseProfileWidth, 0],
            [(baseProfileHeight - baseProfileInsetLength) / 2, baseProfileWidth, 0],
            [(baseProfileHeight - baseProfileInsetLength) / 2, baseProfileWidth - baseProfileInsetDepth, 0],
            [baseProfileInsetLength + (baseProfileHeight - baseProfileInsetLength) / 2, baseProfileWidth - baseProfileInsetDepth, 0],
            [baseProfileInsetLength + (baseProfileHeight - baseProfileInsetLength) / 2, baseProfileWidth, 0],
            [baseProfileHeight, baseProfileWidth, 0],
            [baseProfileHeight, 0, 0]
        ];
        basePath = [[0, 0, 0], [baseLength - baseStraightLength, baseBendOffset, 0], baseBendRadius, [baseLength, baseBendOffset, 0]];
        basePathRounded = rounded_path(basePath);

        translate([0, baseOffset, 0]) sweep(basePathRounded, baseProfile, loop = false, convexity = 2);
    }

    module endBaseTaperNegative() {
        CubePoints = [
        [  0,  0, -(baseProfileHeight - endBaseTaperHeightStart)/2 ],  //0
        [ endBaseTaperLength,  0,  -(baseProfileHeight - endBaseTaperHeightEnd)/2 ],  //1
        [ endBaseTaperLength + 0.01, endBaseTaperWidthStart + 10,  -(baseProfileHeight - endBaseTaperHeightEnd)/2 ],  //2
        [  0 + 0.01,  endBaseTaperWidthStart + 10,  -(baseProfileHeight - endBaseTaperHeightStart)/2 ],  //3
        [  0,  0,  10 ],  //4
        [ endBaseTaperLength,  0,  10 ],  //5
        [ endBaseTaperLength + 0.01,  endBaseTaperWidthStart + 10, 10 ],  //6
        [  0 + 0.01,  endBaseTaperWidthStart + 10,  10 ]]; //7
        
        CubeFaces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3]]; // left

        translate([0, -5, 0]) polyhedron( CubePoints, CubeFaces );
        translate([0, endBaseTaperWidthStart + 5, endPreBaseTaperRadius - (baseProfileHeight - endBaseTaperHeightStart)/2]) rotate([90, 0, 0]) cylinder(h = endBaseTaperWidthStart + 10, r = endPreBaseTaperRadius);

    }

    module endBaseWidthTaperNegative() {
        CubePoints = [
        [  0,  0, -endBaseTaperWidthEnd ],  //0
        [ endLength,  0,  -endBaseTaperWidthStart ],  //1
        [ endLength , baseProfileHeight ,  -endBaseTaperWidthStart ],  //2
        [  0 ,  baseProfileHeight,  -endBaseTaperWidthEnd ],  //3
        [  0,  0,  0 ],  //4
        [ endLength,  0,  0 ],  //5
        [ endLength,  baseProfileHeight, 0 ],  //6
        [  0,  baseProfileHeight,  0 ]]; //7
        
        CubeFaces = [
        [0,1,2,3],  // bottom
        [4,5,1,0],  // front
        [7,6,5,4],  // top
        [5,6,2,1],  // right
        [6,7,3,2],  // back
        [7,4,0,3]]; // left

        translate([0.01, endBaseTaperWidthStart + endBaseTaperWidthEnd, 0]) rotate([-90, 0, 0]) polyhedron( CubePoints, CubeFaces );

    }


    module chamferNegative(width, chamferLength, chamferHeight) {

        CubePoints = [
        [  -0.01,  0,  0 ],  //0
        [  -0.01,  width + 10,  0 ],  //3
        [  -0.01,  0,  chamferHeight ],  //4
        [ chamferLength,  0,  chamferHeight ],  //5
        [ chamferLength,  width + 10,  chamferHeight ],  //6
        [  -0.01,  width + 10,  chamferHeight ]]; //7
        
        CubeFaces = [
        [0,3,4,1],  // bottom
        [2,3,3,0],  // front
        [5,4,3,2],  // top
        [3,4,4,3],  // right
        [4,5,1,4],  // back
        [5,2,0,1]]; // left


        polyhedron( CubePoints, CubeFaces );
    }

    module roundedChamferNegative(width, radius) {
        difference() {
            cube([radius / 2, width, radius / 2]);
            rotate([90, 0, 0]) translate([radius / 2, 0, -width - 5]) cylinder(h = width + 10, r = radius / 2, $fn=16);
        }
       
    }
    

    module longRoundedHole(width, height) {
        union() {
            translate([0, 0, 0]) cube([width - height, endBaseTaperWidthStart+10, height]);
            translate([0, endBaseTaperWidthStart + 10, height/2]) rotate([90, 0, 0]) cylinder(h = endBaseTaperWidthStart+10, r = height/2, $fn=16);
            translate([width - height, endBaseTaperWidthStart + 10, height/2]) rotate([90, 0, 0]) cylinder(h = endBaseTaperWidthStart+10, r = height/2, $fn=16);
        }
    }

    module insetChamfer() {
        difference() {
            translate([0, 0.01, -(insetHeight / 2)]) chamferNegative(insetChamferLength, insetChamferDepth, insetChamferHeight); 
            translate([-0.25, 10 + insetChamferLength - insetChamferRoundingRadius, -(insetHeight / 2) + 0.5]) difference() {
               translate([-0.01,0,0]) rotate([0, 0, 15]) cube([insetChamferDepth, insetChamferRoundingRadius + 0.01, insetChamferRoundingRadius]);
               translate([insetChamferRoundingHeight ,5,insetChamferRoundingRadius ]) rotate([15, 270, 0]) cylinder(h = insetChamferRoundingHeight, r1 = 0, r2=insetChamferRoundingRadius);
            }
        }
    }


    difference() {
        base();
        //End section width
        translate([baseLength - endLength, baseOffset + baseBendOffset + baseProfileWidth - (baseProfileWidth - endBaseTaperWidthStart), -baseProfileHeight - 10]) cube([endLength + 10, baseProfileWidth - endBaseTaperWidthStart + 10, baseProfileHeight + 20]);
        
        //End section vertical taper
        translate([baseLength - endBaseTaperLength, baseOffset + baseBendOffset, 0]) endBaseTaperNegative(); 
        rotate([180, 0, 0]) translate([baseLength - endBaseTaperLength, -(baseOffset + baseBendOffset + endBaseTaperWidthStart), baseProfileHeight]) endBaseTaperNegative(); 
        
        translate([baseLength - endLength, baseOffset + baseBendOffset, 0]) endBaseWidthTaperNegative(); 

        //End section cap chamfer
        translate([baseLength, baseOffset + baseBendOffset + endBaseTaperWidthStart + 5, -(baseProfileHeight - endBaseTaperHeightEnd)/2 - endHeightTopChamferHeight - ((endHeightTopChamferLength / endBaseTaperLength) * ((endBaseTaperHeightEnd - endBaseTaperHeightStart)/2))]) rotate([0, 0, 180]) chamferNegative(endBaseTaperWidthStart, endHeightTopChamferLength, endHeightTopChamferHeight); 
        translate([baseLength + 0.01, baseOffset + baseBendOffset - 0.01, -baseProfileHeight + (baseProfileHeight - endBaseTaperHeightEnd)/2 + endHeightBottomChamferRadius / 2 + ((endHeightBottomChamferRadius / endBaseTaperLength) * ((endBaseTaperHeightEnd - endBaseTaperHeightStart)/2)) - 0.01]) rotate([0, 180, 0]) roundedChamferNegative(endBaseTaperWidthStart, endHeightBottomChamferRadius + 0.02);
        translate([baseLength + (endWidthChamferDepth * 1.5 - endWidthChamferDepth) - 2, baseOffset + baseBendOffset + endBaseTaperWidthEnd - endWidthChamferDepth - (endWidthChamferDepth * 1.5 - endWidthChamferDepth) + 2, -baseProfileHeight + 5]) rotate([90, 0, 180]) chamferNegative(endBaseTaperHeightEnd, endWidthChamferLength * 1.5, endWidthChamferDepth * 1.5); 
        
        //End section inset
        translate([baseLength - insetLength, baseOffset + baseBendOffset + endBaseTaperWidthStart - insetDepth, -baseProfileHeight / 2 - insetHeight /2]) cube([insetLength + 10, insetDepth+10, insetHeight]);
        
        //inset chamfer
        translate([baseLength + 10, baseOffset + baseBendOffset + endBaseTaperWidthStart, -(baseProfileHeight / 2) - insetChamferHeight + 0.01]) rotate([180, 0, 270]) mirror([0,0, 1]) insetChamfer();
        translate([baseLength + 10, baseOffset + baseBendOffset + endBaseTaperWidthStart, -(baseProfileHeight / 2) + insetChamferHeight - 0.01]) rotate([180, 0, 270]) insetChamfer();

    //    //End section holes
        translate([baseLength - endLength + holeheight / 2 + 0.01, baseOffset + baseBendOffset - 5, -(baseProfileHeight / 2) - (insetHeight / 2) + holeInsetPadding]) longRoundedHole(holeWidth, holeheight);
        translate([baseLength - endLength + holeheight / 2 + 0.01, baseOffset + baseBendOffset - 5, -(baseProfileHeight / 2) + (insetHeight / 2) - holeheight - holeInsetPadding]) longRoundedHole(holeWidth, holeheight);
        translate([baseLength + axleHoleHeight / 2 - axleHoleWidth - axleHolePadding, baseOffset + baseBendOffset - 5, -(baseProfileHeight / 2) + (insetHeight / 2) - insetHeight + (insetHeight - axleHoleHeight) / 2]) longRoundedHole(axleHoleWidth, axleHoleHeight);

    }


}


axleRoundRiameter = 22;
axleFlat = 18;

module motor() {
    rimDiameter = 459;
    rimWidth = 174;
    axleRoundWidth = 230;
    axleWidth = 320;
    union() {
        rotate([90, 0, 0]) translate([0, 0, -rimWidth/2]) cylinder(h = rimWidth, r = rimDiameter /2 );
        union() {
            intersection() {
                color("#5555aa") rotate([90, 0, 0]) translate([0, 0, -axleWidth/2]) cylinder(h = axleWidth, r = axleRoundRiameter /2 );
                union() {
                    translate([-50, axleWidth/2 - (axleWidth - axleRoundWidth) / 2 , -axleFlat/2]) cube([100, (axleWidth - axleRoundWidth) / 2 + 0.01, axleFlat]);
                    translate([-50, -axleWidth/2 - 0.01 , -axleFlat/2]) cube([100, (axleWidth - axleRoundWidth) / 2 + 0.01, axleFlat]);
                }
            }
            color("#5555aa") rotate([90, 0, 0]) translate([0, 0, -(axleWidth - (axleWidth - axleRoundWidth))/2]) cylinder(h = axleWidth - (axleWidth - axleRoundWidth) + 0.02, r = axleRoundRiameter /2 );
        }

    }


}

module mount() {
    mountBaseWidth = 15;
    mountBaseHeight = baseProfileHeight - 1;
    mountBaseLength = 210;
    mountLengthOffset = 60;
    tolerance = 0.1;

    mountTorqueHolesSize = 8;
    mountTorqueHolesEndPadding = 10;
    mountTorqueHolesPadding = 30;
    mountTorqueHolesDepth = 20;

    module mountPlate() {

        translate([0, -mountBaseWidth/2, 0]) difference() {
            translate([-mountBaseLength / 2 - mountLengthOffset, -mountBaseWidth / 2, -mountBaseHeight/2]) cube([mountBaseLength, mountBaseWidth, mountBaseHeight]);
            intersection() {
                color("#5555aa") rotate([90, 0, 0]) translate([0, 0, -mountBaseWidth/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r = (axleRoundRiameter + tolerance) / 2 );
                translate([-50, mountBaseWidth/2 - mountBaseWidth -0.02, -(axleFlat + tolerance)/2 ]) cube([100, mountBaseWidth + 0.04, axleFlat + tolerance]);
            }
        }
    }
    module mountPlateOpposite() {
        translate([-mountBaseLength / 2 - mountLengthOffset, baseProfileWidth, -mountBaseHeight/2]) cube([mountTorqueHolesEndPadding * 2 + mountTorqueHolesPadding , mountBaseWidth, mountBaseHeight]);
    }

    module mountPlateTop() {
        translate([-mountBaseLength / 2 - mountLengthOffset, -mountBaseWidth, baseProfileHeight/2]) cube([mountTorqueHolesEndPadding * 2 + mountTorqueHolesPadding , baseProfileWidth + mountBaseWidth * 2, mountBaseWidth]);
    }
    color("#55aa55") difference() {
        mountPlate();
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, -mountBaseWidth/2, mountBaseHeight/2 - mountTorqueHolesDepth]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, -mountBaseWidth/2, mountBaseHeight/2 - mountTorqueHolesDepth]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, -mountBaseWidth/2, -mountBaseHeight/2 - 0.01]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, -mountBaseWidth/2, -mountBaseHeight/2 - 0.01]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
     
    }
    color("#55aa55")difference() {
        mountPlateOpposite();
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, baseProfileWidth + mountBaseWidth/2, mountBaseHeight/2 - mountTorqueHolesDepth]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, baseProfileWidth + mountBaseWidth/2, mountBaseHeight/2 - mountTorqueHolesDepth]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, baseProfileWidth + mountBaseWidth/2, -mountBaseHeight/2 - 0.01]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, baseProfileWidth + mountBaseWidth/2, -mountBaseHeight/2 - 0.01]) cylinder(h = mountTorqueHolesDepth + 0.01, r=mountTorqueHolesSize/2);
    }
    color("#55aadd")difference() {
        mountPlateTop();
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, baseProfileWidth + mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, baseProfileWidth + mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, -mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, -mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
    }
    color("#55aadd") translate([0,0,-baseProfileHeight - mountBaseWidth]) difference() {
        mountPlateTop();
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, baseProfileWidth + mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, baseProfileWidth + mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding, -mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
        translate([-mountBaseLength/2 - mountLengthOffset + mountTorqueHolesEndPadding + mountTorqueHolesPadding, -mountBaseWidth/2, baseProfileHeight/2 - 0.01]) cylinder(h = mountBaseWidth + 0.02, r=mountTorqueHolesSize/2);
 
    }
}



swingarm();
mirror([0,1,0]) swingarm();
translate([baseLength - axleHolePadding - axleHoleWidth/2, 0, -baseProfileHeight / 2]) motor();

translate([baseLength - axleHolePadding - axleHoleWidth/2, baseOffset + baseBendOffset, -baseProfileHeight / 2])  mount();
mirror([0,1,0]) translate([baseLength - axleHolePadding - axleHoleWidth/2, baseOffset + baseBendOffset, -baseProfileHeight / 2])  mount();

