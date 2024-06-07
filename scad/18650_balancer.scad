
resolution = 64;
$fn= resolution;

nothing = 0.01;
cellHeight = 65.5;
cellDiameter = 18.5;
cellTopBottomMargin = 5;
cellDiameterMargin = 0.7;
cellPadding = 2;
cellCount = 7;

holderTopWireWidth = 20;
holderBottomWireWidth = 40;
holderWalls = 2;
holderCapHeight = 5;
holderHeight = cellDiameter + cellDiameterMargin + holderWalls - holderCapHeight;


holderDepth = cellCount * (cellDiameter + cellDiameterMargin) + (cellCount - 1) * cellPadding + holderWalls * 2;


holderWidth = cellHeight + cellTopBottomMargin + holderTopWireWidth + holderBottomWireWidth;
fingerHoleWidth = 20;
fingerHoleStartHeight = 2;

connectingWireDiameter = 1.1;
connectingSheetWidth = 5;

holderCapPresserTolerance = 0.25;
holderCapPresserWireDistance = 0.5;

holderTopCapPresserDepth = holderTopWireWidth / 2 - connectingWireDiameter/2 - holderWalls - holderCapPresserWireDistance - holderCapPresserTolerance;
holderTopCapPresserDepth2 = holderTopWireWidth / 2 - connectingWireDiameter/2 - holderCapPresserWireDistance;

holderBottomCapPresserWireDistance = 1;

holderCapPresserWidth = connectingSheetWidth - holderCapPresserTolerance;


screwInsertHoleDiameter = 4.5;
screwInsertDepth = 7 + 7;
screwHoleDiameter = 3.3;
screwHeadDiameter = 3.3;
screwWallDistance = 5;

resistorDiameter = 4;
resistorWireDiameter = 0.65;
resistorWireDepth = connectingWireDiameter;
resistorPresserWidth = 3;
resistorLength = 12;

resistorConnectingLength = 5;

connectorLargeWidth = 4;
connectorSmallWidth = 2.5;
connectorLength = 2;
connectorTolerance = 0.2;

module testPackConnector(tolerance) {

    CubePoints = [
    [  (connectorLargeWidth - connectorSmallWidth) / 2 + (tolerance / 2),  0,  0 ],  //0
    [ connectorSmallWidth + (connectorLargeWidth - connectorSmallWidth) / 2 - (tolerance / 2),  0,  0 ],  //1
    [ connectorLargeWidth - (tolerance / 2),  connectorLength,  0 ],  //2
    [   (tolerance / 2),  connectorLength,  0 ],  //3
    [  (connectorLargeWidth - connectorSmallWidth) / 2 + (tolerance / 2),  0,  holderHeight ],  //4
    [ connectorSmallWidth + (connectorLargeWidth - connectorSmallWidth) / 2 - (tolerance / 2),  0,  holderHeight ],  //5
    [ connectorLargeWidth - (tolerance / 2),  connectorLength,  holderHeight ],  //6
    [  (tolerance / 2),  connectorLength,  holderHeight ]]; //7
    
    CubeFaces = [
    [0,1,2,3],  // bottom
    [4,5,1,0],  // front
    [7,6,5,4],  // top
    [5,6,2,1],  // right
    [6,7,3,2],  // back
    [7,4,0,3]]; // left
    
    translate([-connectorLargeWidth / 2, 0, 0]) polyhedron( CubePoints, CubeFaces );
}


module base() {
  difference() {
    cube([holderWidth,holderDepth,holderHeight]);
    translate([holderTopWireWidth,0 - nothing,(cellDiameter + cellDiameterMargin) / 2 + holderWalls + nothing]) cube([cellHeight + cellTopBottomMargin,holderDepth + nothing * 2,(cellDiameter + cellDiameterMargin) / 2 + nothing]);
    translate([-fingerHoleWidth/2 + holderWidth/2,-nothing,holderWalls + fingerHoleStartHeight + nothing]) cube([fingerHoleWidth,holderDepth + nothing * 2,(cellDiameter + cellDiameterMargin) / 2 + nothing]);
    for (cell=[0:cellCount-1]){
      rotate([0,90,0]) translate([
        -(cellDiameter + cellDiameterMargin)/2 - holderWalls,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls,
        holderTopWireWidth
      ]) cylinder(h = cellHeight + cellTopBottomMargin, r = (cellDiameter + cellDiameterMargin)/2);

      translate([
        holderWalls,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls - connectingSheetWidth / 2 ,
        holderHeight - connectingWireDiameter + nothing
      ]) cube([holderTopWireWidth - holderWalls,connectingSheetWidth,connectingWireDiameter]);

      translate([
        holderWidth - holderBottomWireWidth - nothing,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls - connectingSheetWidth / 2 ,
        holderHeight - resistorWireDepth + nothing
      ]) cube([holderBottomWireWidth / 2,connectingSheetWidth,resistorWireDepth]);
      
      translate([
        holderWidth - holderBottomWireWidth / 2 - resistorLength/2,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls + connectingSheetWidth/2 - nothing,
        holderHeight - resistorWireDepth + nothing
      ]) cube([resistorWireDiameter,resistorConnectingLength, resistorWireDepth]);
     
      translate([
        holderWidth - holderBottomWireWidth / 2 - resistorLength/2,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls + connectingSheetWidth/2 + resistorConnectingLength - resistorDiameter/2 - nothing,
        holderHeight - resistorDiameter/2 + nothing
      ]) cube([resistorLength,resistorDiameter, resistorDiameter]);

      translate([
        holderWidth - holderBottomWireWidth / 2 - resistorLength/2 + resistorLength - nothing,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls + connectingSheetWidth/2 + resistorConnectingLength - resistorPresserWidth/2 - nothing,
        holderHeight - resistorWireDepth + nothing
      ]) cube([(holderBottomWireWidth - resistorLength)/2 - holderWalls, resistorPresserWidth, resistorWireDepth]);

      if(cell % 2 == 0) {
        translate([
          screwWallDistance,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - screwInsertDepth
        ]) cylinder(h = screwInsertDepth + nothing, r = screwInsertHoleDiameter/2);

        translate([
          holderWidth - holderBottomWireWidth/2 - resistorLength/2,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - screwInsertDepth
        ]) cylinder(h = screwInsertDepth + nothing, r = screwInsertHoleDiameter/2);


      } else {
        translate([
          holderTopWireWidth - screwWallDistance,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - screwInsertDepth
        ]) cylinder(h = screwInsertDepth + nothing, r = screwInsertHoleDiameter/2);


        translate([
          holderWidth - holderBottomWireWidth/2 + resistorLength/2,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - screwInsertDepth
        ]) cylinder(h = screwInsertDepth + nothing, r = screwInsertHoleDiameter/2);

      }

    }

    translate([holderTopWireWidth/2 - connectingWireDiameter/2,0,holderHeight - connectingWireDiameter + nothing]) cube([connectingWireDiameter,holderDepth, connectingWireDiameter]);

    translate([holderWidth - connectingWireDiameter/2 - holderWalls - ((holderBottomWireWidth - resistorLength)/2 - holderWalls)/2,0,holderHeight - connectingWireDiameter + nothing]) cube([connectingWireDiameter,holderDepth, connectingWireDiameter]);

    translate([holderTopWireWidth- holderTopWireWidth/4,0,0]) testPackConnector(0);
    translate([holderWidth - holderBottomWireWidth/2,0,0]) testPackConnector(0);
  }
  translate([holderTopWireWidth- holderTopWireWidth/4,holderDepth - nothing,0]) testPackConnector(connectorTolerance);
  translate([holderWidth - holderBottomWireWidth/2,holderDepth - nothing,0]) testPackConnector(connectorTolerance);
}



module cap (){
  for (cell=[0:cellCount-1]){

    translate([
      holderTopWireWidth/2 - holderTopCapPresserDepth - connectingWireDiameter/2 - holderCapPresserWireDistance,
      cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls - holderCapPresserWidth / 2 ,
      holderHeight - connectingWireDiameter + nothing
    ]) cube([holderTopCapPresserDepth,holderCapPresserWidth,connectingWireDiameter + holderCapHeight]);

    translate([
      holderTopWireWidth/2 + connectingWireDiameter/2 + holderCapPresserWireDistance,
      cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls - holderCapPresserWidth / 2 ,
      holderHeight - connectingWireDiameter + nothing
    ]) cube([holderTopCapPresserDepth2,holderCapPresserWidth,connectingWireDiameter + holderCapHeight]);
  }
  difference() {
    translate([0,0,holderHeight]) cube([holderTopWireWidth,holderDepth,holderCapHeight]);
    for (cell=[0:cellCount-1]){
      if(cell % 2 == 0) {
        translate([
          screwWallDistance,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - nothing
        ]) cylinder(h = holderCapHeight + nothing, r = screwHoleDiameter/2);

        translate([
          screwWallDistance,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight + holderCapHeight - 2 + nothing
        ]) cylinder(h = 2, r = screwHeadDiameter/2);
      } else {
        translate([
          holderTopWireWidth - screwWallDistance,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - nothing
        ]) cylinder(h = holderCapHeight + nothing, r = screwHoleDiameter/2);

        translate([
          holderTopWireWidth - screwWallDistance,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight + holderCapHeight - 2 + nothing
        ]) cylinder(h = 2, r = screwHeadDiameter/2);
      }
    }
  }
}


module cap2 (){
  for (cell=[0:cellCount-1]){

    translate([
      holderWidth - holderBottomWireWidth,
      cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls - holderCapPresserWidth / 2 ,
      holderHeight - resistorWireDepth + nothing
    ]) cube([holderBottomWireWidth/2 - resistorLength/2 - holderBottomCapPresserWireDistance,holderCapPresserWidth,resistorWireDepth + holderCapHeight]);
    translate([
      holderWidth - holderBottomWireWidth/2 - resistorLength/2 + resistorWireDiameter + holderBottomCapPresserWireDistance,
      cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls - holderCapPresserWidth / 2 ,
      holderHeight - resistorWireDepth + nothing
    ]) cube([resistorLength/2 - resistorWireDiameter - holderBottomCapPresserWireDistance - holderCapPresserTolerance,holderCapPresserWidth,resistorWireDepth + holderCapHeight]);

    translate([
      holderWidth - holderBottomWireWidth/2 + resistorLength/2,
      cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls + resistorConnectingLength + resistorPresserWidth + holderCapPresserTolerance/2- resistorDiameter/2,
      holderHeight - resistorWireDepth + nothing
    ]) cube([((holderBottomWireWidth - resistorLength)/2 - holderWalls)/2 - connectingWireDiameter/2 - holderBottomCapPresserWireDistance,resistorPresserWidth- holderCapPresserTolerance,resistorWireDepth + holderCapHeight]);
    
    translate([
      holderWidth - holderWalls - (((holderBottomWireWidth - resistorLength)/2 - holderWalls)/2 - connectingWireDiameter/2 - holderBottomCapPresserWireDistance),
      cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls + resistorConnectingLength + resistorPresserWidth+ holderCapPresserTolerance/2 - resistorDiameter/2,
      holderHeight - resistorWireDepth + nothing
    ]) cube([((holderBottomWireWidth - resistorLength)/2 - holderWalls)/2 - connectingWireDiameter/2 - holderBottomCapPresserWireDistance - holderCapPresserTolerance,resistorPresserWidth - holderCapPresserTolerance,resistorWireDepth + holderCapHeight]);

  }
  difference() {
    translate([holderWidth - holderBottomWireWidth,0,holderHeight]) cube([holderBottomWireWidth,holderDepth,holderCapHeight]);
    for (cell=[0:cellCount-1]){

      translate([
        holderWidth - holderBottomWireWidth / 2 - resistorLength/2,
        cell * (cellDiameter + cellDiameterMargin + cellPadding) + (cellDiameter + cellDiameterMargin)/2 + holderWalls + connectingSheetWidth/2 + resistorConnectingLength - resistorDiameter/2 - nothing,
        holderHeight - resistorDiameter/2 + nothing
      ]) cube([resistorLength,resistorDiameter, resistorDiameter]);

      if(cell % 2 == 0) {
        translate([
          holderWidth - holderBottomWireWidth/2 - resistorLength/2,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - nothing
        ]) cylinder(h = holderCapHeight + nothing, r = screwHoleDiameter/2);

        translate([
          holderWidth - holderBottomWireWidth/2 - resistorLength/2,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight + holderCapHeight - 2 + nothing
        ]) cylinder(h = 2, r = screwHeadDiameter/2);
      } else {
        translate([
          holderWidth - holderBottomWireWidth/2 + resistorLength/2,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight - nothing
        ]) cylinder(h = holderCapHeight + nothing, r = screwHoleDiameter/2);

        translate([
          holderWidth - holderBottomWireWidth/2 + resistorLength/2,
          cell * (cellDiameter + cellDiameterMargin + cellPadding) + screwWallDistance,
          holderHeight + holderCapHeight - 2 + nothing
        ]) cylinder(h = 2, r = screwHeadDiameter/2);
      }
    }
  }
}

base();
color("yellow") translate([0,0,30]) cap();
color("yellow") translate([0,0,30]) cap2();

