    //
    // units: mm
    //
    //Settings:
    bottom_thickness = 0.3; //thickness of the bottom holder part
    inside_diam = 18.7; //inside diameter of the cell holder
    hole_diam = 9; //diameter of the center hole
    height = 7; //total height of the holder
    wall = 0.41; // wall size, number should be slightly bigger than nozzle size
    resolution = 3; //best to be divisible by 4

    screwInsertHoleDepth = 4;
    screwInsertHoleDiameter = 4;
     
    //End settings

    diameter = inside_diam + wall;
    rad=diameter/2;
    $fn= resolution;


module cell(){  
   // translate([0,0, -0.005]) cylinder(h=height +0.01,d=hole_diam);
   // translate([0,0, -0.005]) cylinder(h=height-bottom_thickness +0.01,d=inside_diam);
}
 
module hex(row, col){
    for (a=[0:row-1]){
        posx=diameter*a; 
        for (b=[0:col-1]){
            posy=diameter*b; 
       //     translate([posx,posy,0]) cell();
            if(a != row -1 && b != col -1) {
          //      translate([posx + rad,posy + rad,height - screwInsertHoleDepth]) cylinder(h = screwInsertHoleDepth + 1, r = screwInsertHoleDiameter/2);
            }

        }   
    }
}

module pack(row, col) {
    difference() {
        translate([-0.5* diameter, -0.5* diameter, 0]) cube([diameter * row, diameter*col, height]);
        hex(row, col);
    }
}
      
    
