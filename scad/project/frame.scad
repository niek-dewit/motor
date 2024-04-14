include <../NopSCADlib/utils/core/core.scad>
use <../NopSCADlib/utils/sweep.scad>
use <../NopSCADlib/utils/maths.scad>
use <../NopSCADlib/utils/bezier.scad>
include <../testpack.scad>



extraHeight = 4;
    
//End settings

$fn= resolution;



module cell(){  
    //translate([0,0, -0.005]) cylinder(h=height +0.01,d=hole_diam);
    //translate([0,0, -0.005]) cylinder(h=height-bottom_thickness +0.01,d=inside_diam);
}
 
module hex(row, col){
    for (a=[0:row-1]){
        posx=diameter*a; 
        for (b=[0:col-1]){
            posy=diameter*b; 
            translate([posx,posy,0]) cell();
            if(a != row -1 && b != col -1) {
             //   translate([posx + rad,posy + rad,0]) cylinder(h = screwInsertHoleDepth + 1, r = screwInsertHoleDiameter/2);
             //   translate([posx + rad,posy + rad,0]) cylinder(h = height + 1, r = shellHoleDiameter/2);

                
            }

        }   
    }
}

module pack(row, col, cutout, cellheightcutout) {
    if(!cutout) {
        difference() {
            translate([-0.5* diameter, -0.5* diameter, 0]) cube([diameter * row, diameter*col, height]);
            hex(row, col);
        }
    }
    if(cutout) {
       translate([-0.5* diameter, -0.5* diameter, -10]) cube([diameter * row, diameter*col, 100]);
    }
}
      
    








tubeDiameter = 38.5;
tubeRadius = tubeDiameter / 2;

cradleDownLength = -660;
cradleDownInward = 286; //?
cradleDownWidening = -177 + tubeRadius;
cradleDownToBottomRadius = 105; //?
cradleBottomNarrowing = 10;
cradleBottomLength = 365;
cradleBottomLengthVisualExtend = 100;

cradleInitialDownLength = -250;
cradleInitialDownInward = 105;
cradleInitialDownWidening = -100 + tubeRadius;
cradleInitialToDownRadius = 200;
cradle = [[0, 0, 0], [cradleInitialDownInward, cradleInitialDownWidening, cradleInitialDownLength], cradleInitialToDownRadius, [cradleDownInward, cradleDownWidening, cradleDownLength], cradleDownToBottomRadius, [cradleDownInward + cradleBottomLength + cradleBottomLengthVisualExtend, cradleDownWidening + cradleBottomNarrowing, cradleDownLength]];

topLength = 620;
topWidening = -82;
topToBackRadius = 120; //?
topBaseFall = -157; //?
backExtraReach = 85; //?
backDownLength = -260;

backConnectorHeight = 230;
backConnectorOffset = 45;
backConnectorSizeWidth = 60;
backConnectorSizeHeight = 60;
backConnectorSizeDepth = 70;

frontConnectorHeight = 110;
frontConnectorOffset = 145;
frontConnectorSizeWidth = 40;
frontConnectorSizeHeight = 70;
frontConnectorSizeDepth = 30;

top = [[0, 0, 0], [topLength, topWidening, topBaseFall], topToBackRadius, [topLength + backExtraReach, cradleDownWidening + cradleBottomNarrowing, backDownLength + topBaseFall]];


bottomToBackConnectionLength = 240;

module frame() {
    sweep(rounded_path(top), circle_points(tubeRadius, $fn = 64));

    sweep(rounded_path(cradle), circle_points(tubeRadius, $fn = 64));
    translate([cradleBottomLength + cradleDownInward, cradleDownWidening - cradleBottomNarrowing, cradleDownLength + tubeRadius]) rotate([0,8,0]) cube([100, tubeDiameter, bottomToBackConnectionLength]);
    translate([cradleBottomLength + cradleDownInward - 20, backConnectorOffset, cradleDownLength + backConnectorHeight]) cube([backConnectorSizeDepth, backConnectorSizeWidth, backConnectorSizeHeight]);
    
    translate([cradleDownInward - 62, frontConnectorOffset, cradleDownLength + frontConnectorHeight]) rotate([10, -25, -2]) cube([frontConnectorSizeDepth, frontConnectorSizeWidth, frontConnectorSizeHeight]);

}

module renderFrame() {

    color("white") frame();
    mirror([0,1]) {
        color("white") frame();
    }


    frameCrossbarHeight = 90;
    frameSecondCrossbarHeight = 340;
    swingArmMountHeight = 135;

    rotate([90, 0,0]) translate([cradleBottomLength + cradleDownInward + (tubeDiameter / 2), cradleDownLength, cradleDownWidening]) color("white")  cylinder(cradleDownWidening * -2, tubeDiameter /2 , tubeDiameter/2 );
    rotate([90, 0,0]) translate([cradleDownInward + (tubeDiameter / 2) - 58, cradleDownLength + frameCrossbarHeight, cradleDownWidening + 15]) color("white") cylinder(cradleDownWidening * -2 - 30, tubeDiameter /2 , tubeDiameter/2 );
    rotate([90, 0,0]) translate([cradleDownInward + (tubeDiameter / 2) - 169, cradleDownLength + frameSecondCrossbarHeight, cradleInitialDownWidening - 10]) color("white") cylinder(cradleInitialDownWidening * -2 + 20, tubeDiameter /2 , tubeDiameter/2 );
    rotate([90, 0,0]) translate([cradleBottomLength + cradleDownInward + (tubeDiameter / 2) + 17, cradleDownLength + swingArmMountHeight, cradleDownWidening]) color("white") cylinder(cradleDownWidening * -2, tubeDiameter /2 , tubeDiameter/2 );

    //translate([cradleBottomLength + cradleDownInward - 20, -100, cradleDownLength + backConnectorHeight + backConnectorSizeHeight - 10]) cube([200, 200, 10]);
    translate([ 70, -65, -170]) rotate([0, -15, 0]) cube([250, 130, 10]);
}


packBottomFromFrame = 50;
packSpacing = 35;
holderHeight = 10;
holderSpacing = cellHeight - holderHeight * 2;

module renderLayer0Spacers(cutout) {

    /* Level 0
    * 247 cells
    * 35s7p
    * 2 spare
    */
    if(!cutout ) {
      //  translate([285,-115.8,-100 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) testPackPack(13, 19);
        translate([285,-115.8,-100 + cradleDownLength + packBottomFromFrame + 65.25]) rotate([180, 0, 90]) testPackPack(13, 19);
    }
    if(cutout) {
        //translate([285,-115.8,-100 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) testPackPack(13, 19);

        translate([285,-115.8,-100 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(13, 19, true);
    } 

}

module renderLayer0Shell() {
    intersection() {
        import("../frame-area6.stl", convexity=3);
        translate([-500, -500, -713]) cube([2000, 1000, 70 + shellThicknessTopBottom * 2 + 5]);
    }
}


module renderLayer1Spacers(cutout) {
    /* Level 1
    * 380 cells
    * 35s10p
    * 30 spare
    */
    if(!cutout) {
        difference() {
            union() {
                translate([325,-183,-5 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(20, 17);
                translate([325,-183,-5 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(20, 17);

                translate([325, -221.5,-5 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(2, 10);
                translate([325, -221.5,-5 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 10);

                translate([325, 203,-5 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(2, 10);
                translate([325, 203,-5 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 10);
            }
            translate([644 - diameter*3, 194- diameter * 4,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, 100, 100]);
            translate([644 - diameter*3, -293 + diameter * 4,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, 100, 100]);
            translate([215 + diameter, -290 + diameter * 6,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([215 + diameter, -290 + diameter * 21,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);

        }
    } else {
        difference() {
            union() {
                translate([325,-183,-5 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(20, 17, true);

                translate([325, -221.5,-5 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 10,true);

                translate([325, 203,-5 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 10,true);
            }
            translate([644 - diameter*3, 194- diameter * 4,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, 100, 100]);
            translate([644 - diameter*3, -293 + diameter * 4,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, 100, 100]);
            translate([215 + diameter, -290 + diameter * 6,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([215 + diameter, -290 + diameter * 21,-5 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);

        }
    }
}

module renderLayer1Shell() {

    intersection() {
        import("../frame-area6.stl", convexity=3);
        translate([-500, -500, -623]) cube([2000, 1000, 80]);
    }
}


module renderLayer2Spacers(cutout) {
    /* Level 2
    * 524 cells
    * 35s14p
    * 34 spare
    */
    if(!cutout) {
        difference() {
            union() {
                translate([265,-183,90 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(20, 21);
                translate([265,-183,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(20, 21);

                translate([149.2,-86,90 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) color("orange") pack(10, 6);
                translate([149.2,-86,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) color("orange") pack(10, 6);

                translate([288, -221.5,90 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(2, 11);
                translate([288, -221.5,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11);

                translate([288, 203,90 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(2, 11);
                translate([288, 203,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11);
            }

            translate([38 + diameter * 5, 97.5 - diameter,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([38 + diameter * 5, -153.8+diameter,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
        
        
            translate([661 - diameter * 3, -250.7+diameter * 3,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([661 - diameter * 3, -250.7+diameter * 4,90 + cradleDownLength + packBottomFromFrame - 20]) cube([diameter*3, diameter* 3, 100]);

            translate([661 - diameter * 3, -250+diameter * 20,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([661 - diameter * 3, -250+diameter * 19,90 + cradleDownLength + packBottomFromFrame - 20]) cube([diameter*3, diameter* 3, 100]);

        }
    } else {
        difference() {
            union() {
                translate([265,-183,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(20, 21, true);

                translate([149.2,-86,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) color("orange") pack(10, 6, true);

                translate([288, -221.5,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11, true);

                translate([288, 203,90 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11, true);
            }

            translate([38 + diameter * 5, 97.5 - diameter,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([38 + diameter * 5, -153.8+diameter,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
        
        
            translate([661 - diameter * 3, -250.7+diameter * 3,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([661 - diameter * 3, -250.7+diameter * 4,90 + cradleDownLength + packBottomFromFrame - 20]) cube([diameter*3, diameter* 3, 100]);

            translate([661 - diameter * 3, -250+diameter * 20,90 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([661 - diameter * 3, -250+diameter * 19,90 + cradleDownLength + packBottomFromFrame - 20]) cube([diameter*3, diameter* 3, 100]);

        }
    }
}

module renderLayer2Shell() {

    intersection() {
        import("../frame-area6.stl", convexity=3);
        translate([-500, -500, -528]) cube([2000, 1000, 80]);
    }
}

module renderLayer3Spacers(cutout) {
    /* Level 3
    * 512 cells
    * 35s14p
    * 22 spare
    */
    if(!cutout) {
        difference() {
            union() {
                translate([225,-183,185 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(20, 21);
                translate([225,-183,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(20, 21);

                translate([109.2,-68,185 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) color("orange") pack(8, 6);
                translate([109.2,-68,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) color("orange") pack(8, 6);

                translate([248, -221.5,185 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(2, 11);
                translate([248, -221.5,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11);

                translate([248, 203,185 + cradleDownLength + packBottomFromFrame]) rotate([180, 0, 90]) pack(2, 11);
                translate([248, 203,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11);
            }

            translate([38 + diameter * 2, 97.5 - diameter*2,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([38 + diameter * 2, -153.8+diameter*2,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([660 - diameter * 3, -250.7+diameter * 3,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 4, 100]);
            translate([660 - diameter * 4, -250.7+diameter * 3,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);

            translate([660 - diameter * 3, -250+diameter * 19,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 4, 100]);
            translate([660 - diameter * 4, -250+diameter * 20,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);

        }
    } else {
        difference() {
            union() {
                translate([225,-183,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(20, 21, true);

                translate([109.2,-68,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) color("orange") pack(8, 6, true);

                translate([248, -221.5,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11, true);

                translate([248, 203,185 + cradleDownLength + packBottomFromFrame + 72]) rotate([180, 0, 90]) pack(2, 11, true);
            }

            translate([38 + diameter * 2, 97.5 - diameter*2,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([38 + diameter * 2, -153.8+diameter*2,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);
            translate([660 - diameter * 3, -250.7+diameter * 3,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 4, 100]);
            translate([660 - diameter * 4, -250.7+diameter * 3,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);

            translate([660 - diameter * 3, -250+diameter * 19,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 4, 100]);
            translate([660 - diameter * 4, -250+diameter * 20,185 + cradleDownLength + packBottomFromFrame - 20]) cube([100, diameter* 3, 100]);

        }
    }
}

module renderLayer3Shell() {
    intersection() {
        import("../frame-area6.stl", convexity=3);
        translate([-500, -500, -433]) cube([2000, 1000, 80]);
    }
}

module renderLayer4Shell() {
    intersection() {
        import("../frame-area6.stl", convexity=3);
        translate([-500, -500, -338]) cube([2000, 1000, 150]);
    }
}

module renderLayer5Shell() {
    intersection() {
        import("../frame-area6.stl", convexity=3);
        translate([-500, -500, -173]) cube([2000, 1000, 500]);
    }
}




/* shell shape
transparancy = 0.01;
translate([500,190,-640]) color("pink") cube([10, 10, 150]);
translate([500,190,-495]) rotate([0, -23.8, 0]) color("pink") cube([10, 10, 450]);
difference() {
    union() {
        difference() {
            union() {
                difference() {
                    union(){
                        difference() {
                            difference() {
                                union() {
                                    translate([555, 0, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cylinder(1500, 265, 265);
                                    translate([555, -265, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cube([130, 530, 1500]);

                                }
                                translate([697, -250, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cube([200, 500, 1800]);
                                translate([80, -250, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cube([200, 500, 1800]);

                            }
                            difference() {
                                translate([343 - 800, 400, -920]) rotate([90, 0, 0]) color("cyan", transparancy) cube([800, 350, 800]);
                                translate([343, 400, -510]) rotate([90, 0, 0]) color("cyan", transparancy) cylinder(800, 220, 220);
                            }

                        }
                        translate([690, -250, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cube([200, 500, 400]);
                    }
                    difference() {
                        translate([0, -300, -520 - 500]) color("cyan", transparancy) cube([1800, 600, 500]);
                        translate([0, 0, -520]) rotate([90, 0, 90]) color("cyan", transparancy) cylinder(1800, 265, 265);
                    }
                    translate([0, -300, -1230]) color("cyan", transparancy) cube([1800, 600, 500]);
                    translate([515, 200, -702.2]) color("cyan", transparancy) cube([310, 100, 265]);
                    translate([515, -300, -702.2]) color("cyan", transparancy) cube([310, 100, 265]);
                }
                difference() {
                    union() {
                        translate([225, -200, -540]) color("cyan", transparancy) cube([500, 400, 700]);
                        difference() {
                            translate([225, -265, -216]) color("cyan", transparancy) cube([160, 530, 285]);
                            translate([125, -265, -300]) color("cyan", transparancy) cube([160, 600, 200]);

                        }

                    }
                    translate([175, -250, 105.6]) rotate([0, 20, 0]) color("cyan", transparancy) cube([700, 500, 400]);

                }
            }
            
            difference() {
                translate([-369, -400, -275]) color("cyan", transparancy) cube([800, 800, 950]);
                translate([231, 400, -180]) rotate([90, 0, 0]) color("cyan", transparancy) cylinder(800, 250, 250);
            }
        }
        translate([175, -200, -320]) rotate([0, 20, 0]) color("cyan", transparancy) cube([500, 400, 400]);//
        difference() {
            translate([245, -265, -132.6]) rotate([0, 20, 0]) color("cyan", transparancy) cube([58.5, 530, 200]);
            translate([365, -300, -132.6])  color("cyan", transparancy) cube([58.5, 600, 200]);

        }
    }
    difference() {
        translate([-300, -300, 36]) rotate([0, 20, 0]) color("cyan", transparancy) cube([2000, 600, 400]);
        translate([-200, 0, 0]) rotate([110, 0, 90]) color("cyan", transparancy) cylinder(1800, 265, 265);
    }
    translate([0, 0, 11.5]) difference() {
        translate([0, 200, -80]) rotate([0, 20, 0]) rotate([22, 0, 0]) color("cyan", transparancy) cube([800, 100, 350]);
        translate([-15, 0, -230]) color("cyan", transparancy) cube([400, 500, 500]);
       translate([549.85, 180, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cube([130, 150, 1500]);

        translate([-15, 0, -230]) rotate([0, 20, 0]) color("cyan", transparancy) cube([900, 150, 500]);

    }
    mirror([0, 1]) {
        translate([0, 0, 11.5]) difference() {
            translate([0, 200, -80]) rotate([0, 20, 0]) rotate([22, 0, 0]) color("cyan", transparancy) cube([800, 100, 350]);
            translate([-15, 0, -230]) color("cyan", transparancy) cube([400, 500, 500]);
                   translate([549.85, 180, -900]) rotate([0, -23.8, 0]) color("cyan", transparancy) cube([130, 150, 1500]);

            translate([-15, 0, -230]) rotate([0, 20, 0]) color("cyan", transparancy) cube([900, 150, 500]);
        }
    }
    difference() {
        translate([-410, -300, -380]) rotate([0, -23.8 + 70, 0]) color("cyan", transparancy) cube([300, 600, 1500]);

        translate([-311, 0, -700]) rotate([0, -23.8 + 70, 0]) color("cyan", transparancy) cylinder(1500, 265, 265);
    }
}*/
 

//renderLayer3Spacers();
//
//color("red", 0.2) renderLayer3Shell();
