

baseLineWidth=0.01;//mm
wallPlateWidth=50;//mm
wallPlateHeight=50;//mm
tubeRadius=8;//mm
tubeFirstStraightLength=250;//mm
tubeCurvesOuterRadius=100;//mm//
tubeSecondStraightLength=180;//mm//
tubeThirdStraightLength=100;//mm//
tubeFourthStraightLength=470;//mm//
lampShadeHolderHeight=30;//mm//
lampShadeHolderRadius=30;//mm//
lampShadeHolderEndOffset=-10;//mm//
lampShadeOuterRadius=200;//mm//
lampShadeThickness=1;//mm//
lampShadeHolderOverlap=5;//mm//
union() {
  tube(
    tubeCurvesOuterRadius=tubeCurvesOuterRadius,//mm
    tubeFirstStraightLength=tubeFirstStraightLength,//mm
    tubeSecondStraightLength=tubeSecondStraightLength,//mm
    tubeThirdStraightLength=tubeThirdStraightLength,//mm
    tubeFourthStraightLength=tubeFourthStraightLength,//mm
    tubeRadius=tubeRadius//mm
  );

  translate([baseLineWidth + tubeRadius -1, baseLineWidth/2 -wallPlateWidth/2, wallPlateHeight]) wallPlate(
    wallPlateThickness=2,//mm
    wallPlateWidth=wallPlateWidth,//mm
    wallPlateLength=100,//mm
    wallPlateHoleSize=5,//mm
    wallPlateHolePadding=4//mm
  );

  // lamp shade holder 
  translate([
    lampShadeHolderEndOffset -tubeCurvesOuterRadius * 3 - tubeSecondStraightLength - tubeFourthStraightLength + lampShadeHolderRadius * 2,
    baseLineWidth/2,
    tubeFirstStraightLength + tubeThirdStraightLength + tubeCurvesOuterRadius * 3 - lampShadeHolderHeight - tubeRadius + 1
  ]) cylinder(lampShadeHolderHeight, lampShadeHolderRadius, lampShadeHolderRadius);

  translate([
    lampShadeHolderEndOffset -tubeCurvesOuterRadius * 3 - tubeSecondStraightLength - tubeFourthStraightLength + lampShadeHolderRadius * 2 - baseLineWidth * 2,
    baseLineWidth /2,
    tubeFirstStraightLength + tubeThirdStraightLength + tubeCurvesOuterRadius * 3 - lampShadeHolderHeight - tubeRadius + 1 - lampShadeOuterRadius + lampShadeHolderOverlap
  ]) lampShade(
    lampShadeOuterRadius,
    lampShadeThickness
  );
}

module lampShade(
  lampShadeOuterRadius,
  lampShadeThickness
) {
  difference() {
    sphere(lampShadeOuterRadius);
    sphere(lampShadeOuterRadius - lampShadeThickness * 2);
    translate([-lampShadeOuterRadius*2, -lampShadeOuterRadius*2, -lampShadeOuterRadius*4]) cube([lampShadeOuterRadius*4, lampShadeOuterRadius*4, lampShadeOuterRadius*4]);
  }
}

module wallPlate(
  wallPlateThickness,
  wallPlateWidth,
  wallPlateLength,
  wallPlateHoleSize,
  wallPlateHolePadding
) {
  difference() {
    cube([wallPlateThickness, wallPlateWidth, wallPlateLength]);
    rotate([0, 90, 0]) translate([0 - wallPlateHoleSize / 2 - wallPlateHolePadding,  wallPlateHoleSize / 2 + wallPlateHolePadding, -0.5]) cylinder(wallPlateThickness + 1, wallPlateHoleSize / 2, wallPlateHoleSize / 2);
    rotate([0, 90, 0]) translate([-wallPlateLength +  wallPlateHoleSize / 2 + wallPlateHolePadding, wallPlateHoleSize / 2 + wallPlateHolePadding, -0.5]) cylinder(wallPlateThickness + 1, wallPlateHoleSize / 2, wallPlateHoleSize / 2);
    rotate([0, 90, 0]) translate([-wallPlateLength + wallPlateHoleSize / 2 + wallPlateHolePadding, wallPlateWidth - wallPlateHoleSize / 2 - wallPlateHolePadding, -0.5]) cylinder(wallPlateThickness + 1, wallPlateHoleSize / 2, wallPlateHoleSize / 2);
    rotate([0, 90, 0]) translate([ -wallPlateHoleSize / 2 - wallPlateHolePadding, wallPlateWidth - wallPlateHoleSize / 2 - wallPlateHolePadding, -0.5]) cylinder(wallPlateThickness + 1, wallPlateHoleSize / 2, wallPlateHoleSize / 2);

  }

}

module tube(
  tubeCurvesOuterRadius,
  tubeFirstStraightLength,
  tubeSecondStraightLength,
  tubeThirdStraightLength,
  tubeFourthStraightLength,
  tubeRadius
) {
  difference() {
    minkowski() {
      union() {
        //first straight section
        cube([baseLineWidth, baseLineWidth, tubeFirstStraightLength]);
        
        //first curve
        translate ([0, 0, tubeFirstStraightLength]) curve(tubeCurvesOuterRadius);

        //second straight section
        translate ([-tubeSecondStraightLength - tubeCurvesOuterRadius + baseLineWidth, 0, tubeFirstStraightLength + tubeCurvesOuterRadius - baseLineWidth]) cube([tubeSecondStraightLength, baseLineWidth, baseLineWidth]);

        //second curve
        rotate([0, 180, 0]) translate([tubeCurvesOuterRadius * 2 + tubeSecondStraightLength - baseLineWidth * 2, 0, -tubeFirstStraightLength - tubeCurvesOuterRadius * 2 + baseLineWidth])  curve(tubeCurvesOuterRadius);

        //third straight section
        translate ([-tubeCurvesOuterRadius * 2 - tubeSecondStraightLength + baseLineWidth,0,tubeFirstStraightLength + tubeCurvesOuterRadius * 2 - baseLineWidth]) cube([baseLineWidth, baseLineWidth, tubeThirdStraightLength]);

        //third curve
        translate ([-tubeCurvesOuterRadius * 2 - tubeSecondStraightLength + baseLineWidth, 0, tubeFirstStraightLength + tubeCurvesOuterRadius * 2 + tubeThirdStraightLength - baseLineWidth]) curve(tubeCurvesOuterRadius);

        //fourth straight section
        translate ([-tubeSecondStraightLength - tubeCurvesOuterRadius * 3 - tubeFourthStraightLength + baseLineWidth * 2, 0, tubeFirstStraightLength + tubeThirdStraightLength + tubeCurvesOuterRadius * 3 - baseLineWidth * 2]) cube([tubeFourthStraightLength, baseLineWidth, baseLineWidth]);

      }
      sphere(tubeRadius, $fn=16);
    }
    translate([-tubeRadius * 2 + baseLineWidth / 2, -tubeRadius * 2 + baseLineWidth / 2, -tubeRadius * 4]) cube([tubeRadius * 4, tubeRadius * 4, tubeRadius * 4]);
    translate([-tubeSecondStraightLength - tubeCurvesOuterRadius * 3 - tubeFourthStraightLength + baseLineWidth / 2 - tubeRadius * 2, baseLineWidth / 2 - tubeRadius * 2, tubeFirstStraightLength + tubeThirdStraightLength + tubeCurvesOuterRadius * 3 - baseLineWidth * 2 + baseLineWidth/2 - tubeRadius * 2]) cube([tubeRadius * 4, tubeRadius * 4, tubeRadius * 4]);

  }

  module curve(radius) {
    intersection() {
      difference() {
        //outer cylinder as base
        rotate([-90,0,0]) translate([-radius + baseLineWidth, 0, 0]) cylinder(baseLineWidth, radius, radius);
        //inner cylinder to subtract
        rotate([-90,0,0]) translate([-radius + baseLineWidth, 0, -0.5]) cylinder(baseLineWidth + 1, radius - baseLineWidth, radius - baseLineWidth);
      }
      // cube to intersect, get 1/4th of the curve
      translate([-radius + baseLineWidth, -0.5, 0]) cube([radius, baseLineWidth + 1, radius]);
    }
  }

}

