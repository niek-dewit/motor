screwInsertHoleDiameter = 4.5;

throttleCablePulleyDiameter = 50;
throttleCablePulleyWidth = 7;
throttleCablePulleyAxleDiameter = 10;
throttleCablePulleyAxleExtraHeight = 7;
throttleCablePulleyAxleExtraHeightDiameter = 20;

//pulley
color("grey") difference() {
  union() {
    translate([0,0,-throttleCablePulleyWidth/2]) cylinder(h=throttleCablePulleyWidth, r=throttleCablePulleyDiameter/2);
    translate([0,0,-throttleCablePulleyWidth/2 - throttleCablePulleyAxleExtraHeight]) cylinder(h=throttleCablePulleyWidth+throttleCablePulleyAxleExtraHeight, r=throttleCablePulleyAxleExtraHeightDiameter/2);

  }
  translate([0,0,-throttleCablePulleyWidth/2 - 5]) cylinder(h=throttleCablePulleyWidth + throttleCablePulleyAxleExtraHeight + 10, r=throttleCablePulleyAxleDiameter/2);

}

//cable holders
springHeight = 6;
bearingHeight = 4;
bearingHolderEdgeThickness = 2;
springHolderWireMargin = 3;

throttleCableStopWidth = 43;
throttleCableStopDistance = 40;
throttleCableStopHeight = 15;

throttleCableStopDepth = 100 - (100 - springHeight - 1 - springHolderWireMargin) + 6 + throttleCablePulleyWidth + throttleCablePulleyAxleExtraHeight+ 1+ bearingHeight + bearingHolderEdgeThickness;




difference() {
  translate([-throttleCableStopWidth/2,throttleCableStopDistance,-throttleCableStopDepth + throttleCablePulleyWidth/2 + bearingHeight + bearingHolderEdgeThickness+springHeight + springHolderWireMargin + 1]) cube([throttleCableStopWidth,throttleCableStopHeight,throttleCableStopDepth]);

  innerThrottleCableDiameter = 2;
  outerThrottleCableDiameter = 7;
  throttleCableEntranceAngle = 11;
  throttleCableMargin = 21;
  throttleCableSlotMargin = 13;

  #rotate([90,0,throttleCableEntranceAngle]) translate([throttleCableMargin,0,-throttleCableStopDistance - throttleCableStopHeight ]) cylinder(h=throttleCableStopHeight + 100, r=innerThrottleCableDiameter/2);
  mirror([1,0]) {
    #rotate([90,0,throttleCableEntranceAngle]) translate([throttleCableMargin,0,-throttleCableStopDistance - throttleCableStopHeight ]) cylinder(h=throttleCableStopHeight + 100, r=innerThrottleCableDiameter/2);
  }

  rotate([90,0,throttleCableEntranceAngle]) translate([throttleCableMargin,0,-throttleCableStopDistance - throttleCableStopHeight ]) cylinder(h=throttleCableStopHeight/2, r=outerThrottleCableDiameter/2);
  rotate([90,0,throttleCableEntranceAngle]) translate([throttleCableMargin,0,-throttleCableStopDistance ]) cylinder(h=throttleCableStopHeight/2, r=outerThrottleCableDiameter/2);
  mirror([1,0]) {
    rotate([90,0,throttleCableEntranceAngle]) translate([throttleCableMargin,0,-throttleCableStopDistance - throttleCableStopHeight ]) cylinder(h=throttleCableStopHeight/2, r=outerThrottleCableDiameter/2);
    rotate([90,0,throttleCableEntranceAngle]) translate([throttleCableMargin,0,-throttleCableStopDistance ]) cylinder(h=throttleCableStopHeight/2, r=outerThrottleCableDiameter/2);

  }

  translate([throttleCableSlotMargin,throttleCableStopDistance - 5,-innerThrottleCableDiameter/2]) rotate([0,0,throttleCableEntranceAngle]) cube([20, throttleCableStopHeight + 10, innerThrottleCableDiameter]);
  mirror([1,0]){
    translate([throttleCableSlotMargin,throttleCableStopDistance - 5,-innerThrottleCableDiameter/2]) rotate([0,0,throttleCableEntranceAngle]) cube([20, throttleCableStopHeight + 10, innerThrottleCableDiameter]);
  }
}

module bearing() {
  color("grey") difference() {
    cylinder(h = bearingHeight, r = bearingOuterDiameter/2);
    translate([0,0,-1]) cylinder(h = bearingHeight + 2, r = bearingAxleDiameter/2);
  }
}


//axle
axleHeight = throttleCablePulleyWidth + throttleCablePulleyAxleExtraHeight + 2;
bearingAxleDiameter = 8;
bearingOuterDiameter = 15;

difference() {
  union() {
    translate([0,0,-throttleCablePulleyAxleExtraHeight - throttleCablePulleyWidth/2 - 1]) cylinder(h=axleHeight, r=throttleCablePulleyAxleDiameter/2);
    translate([0,0,-throttleCablePulleyAxleExtraHeight - throttleCablePulleyWidth/2 - 1 - bearingHeight]) cylinder(h=axleHeight + bearingHeight*2, r=bearingAxleDiameter/2);
  }
  translate([0,0,0]) cylinder(h=100, r=screwInsertHoleDiameter/2);

}
sensorAxleDiameter = 5;
sensorAxleHeight = bearingHolderEdgeThickness + 5;
translate([0,0,-sensorAxleHeight - throttleCablePulleyWidth/2 - throttleCablePulleyAxleExtraHeight - 1 - bearingHeight + 0.001]) cylinder(h=sensorAxleHeight, r=sensorAxleDiameter/2);

translate([0,0,throttleCablePulleyWidth/2 + 1 - 0.001]) bearing();
translate([0,0,-bearingHeight - throttleCablePulleyWidth/2 - throttleCablePulleyAxleExtraHeight - 1 + 0.01]) bearing();

//spring
springDiameter = 6;
springBearingMargin = 2;
color("grey") translate([0,0,throttleCablePulleyWidth/2 + 1 + bearingHeight+ springBearingMargin]) cylinder(h=springHeight, r=springDiameter/2);

//bearing holder
holderMargin = 7;
bearingHolderEdgeWidth = 2;
difference() {
  union() {
    translate([-(bearingOuterDiameter + holderMargin * 2)/2,0,throttleCablePulleyWidth/2+1]) cube([bearingOuterDiameter + holderMargin * 2,throttleCableStopDistance  + throttleCableStopHeight,bearingHeight + bearingHolderEdgeThickness]);
    translate([0,0,throttleCablePulleyWidth/2 + 1]) cylinder(h = bearingHeight + bearingHolderEdgeThickness, r = bearingOuterDiameter/2 + holderMargin);
  }
  translate([0,0,throttleCablePulleyWidth/2]) cylinder(h = bearingHeight + 1, r = bearingOuterDiameter/2);
  translate([0,0,throttleCablePulleyWidth/2]) cylinder(h = bearingHeight + 1 + bearingHolderEdgeThickness + 0.01, r = (bearingOuterDiameter - bearingHolderEdgeWidth)/2);

}
springHolderWidth = bearingOuterDiameter + holderMargin * 2;
springHolderlength = throttleCableStopDistance +  throttleCableStopHeight;
springHolderHoleDistance = 15;
difference() {
  difference() {
    translate([-springHolderWidth/2,0,throttleCablePulleyWidth/2+1+bearingHeight+ bearingHolderEdgeThickness]) cube([springHolderWidth,springHolderlength,springHeight+springHolderWireMargin]);
    rotate([45,0,0]) translate([-50,-10,2]) cube([100,100,100]);
  }
  rotate([90,0,0]) translate([springDiameter/2,throttleCablePulleyWidth/2+1+bearingHeight+bearingHolderEdgeThickness+springHeight,-100]) cylinder(h=100, r=1);
}

translate([0,0,-1-throttleCablePulleyWidth - throttleCablePulleyAxleExtraHeight - 1 - bearingHeight - bearingHolderEdgeThickness]) difference() {
  union() {
    translate([-(bearingOuterDiameter + holderMargin * 2)/2,0,throttleCablePulleyWidth/2+1]) cube([bearingOuterDiameter + holderMargin * 2,throttleCableStopDistance  + throttleCableStopHeight,bearingHeight + bearingHolderEdgeThickness]);
    translate([0,0,throttleCablePulleyWidth/2 + 1]) cylinder(h = bearingHeight + bearingHolderEdgeThickness, r = bearingOuterDiameter/2 + holderMargin);
  }
  translate([0,0,throttleCablePulleyWidth/2 + bearingHolderEdgeThickness + 1]) cylinder(h = bearingHeight + 1, r = bearingOuterDiameter/2);
  translate([0,0,throttleCablePulleyWidth/2]) cylinder(h = bearingHeight + 1 + bearingHolderEdgeThickness + 0.01, r = (bearingOuterDiameter - bearingHolderEdgeWidth)/2);

}