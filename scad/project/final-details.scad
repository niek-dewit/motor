include <./pack-detail.scad>




module connectingObjects() {

  //  translate([280, 170, -720]) rotate([0,0,-90]) cube([430, 100, 2]);
  // translate([560, 170, -720]) rotate([0,0,-90]) cube([300, 100, 2]);

   // translate([210, 170, -625]) rotate([0,0,-12]) cube([550, 100, 2]);
   // translate([170, 170, -530]) rotate([0,0,-12]) cube([550, 100, 2]);
    //translate([130, 170, -435]) rotate([0,0,-12]) cube([550, 100, 2]);

    difference() {
        union() {

            translate([720, 230, -1642]) rotate([0,-23.8,0]) cylinder(1450, 15, 15);
            translate([628, 150, -632]) rotate([0,0,0]) cylinder(300, 15,15);

        }
        translate([0,0,-1750]) cube([1000, 1000, 1000]);
    }



}

module connectorPanel() {
    intersection() {
        difference() {
            cube([110, 100, 6]);
            translate([4.5 + 27.95,4.5 + 37.475,-10]) cylinder(100, 4.5, 4.5);
            translate([4.5 + 27.95,-4.5 + 37.475 + 25.05,-10]) cylinder(100, 4.5, 4.5);

            translate([-4.5 + 27.95 + 44.1,4.5 + 37.475,-10]) cylinder(100, 4.5, 4.5);
            translate([-4.5 + 27.95 + 44.1,-4.5 + 37.475 + 25.05,-10]) cylinder(100, 4.5, 4.5);
            
            translate([27.95 + 4.5, 37.475, -5]) cube([44.1-9, 25.05, 20]);
            translate([27.95, 37.475 + 4.5, -5]) cube([44.1, 25.05 - 9, 20]);

            translate([27.95-5.3 + 44.1/2, 37.475 - (32-25.05) /2, -5]) cube([10.6, 32, 10]);
            translate([27.95-5.3 + 44.1/2, 37.475 - (32-25.05) /2, -5]) rotate([0,23.8,0]) translate([-4,0,-0.9]) cube([10.6, 32, 10]);

            translate([50 - 31,50 - 12,-10]) cylinder(100, 3.75/2, 3.75/2);
            translate([50 + 31,50 - 12,-10]) cylinder(100, 3.75/2, 3.75/2);
            translate([50 - 31,50 + 12,-10]) cylinder(100, 3.75/2, 3.75/2);
            translate([50 + 31,50 + 12,-10]) cylinder(100, 3.75/2, 3.75/2);

        }
       rotate([0,23.8,0]) translate([8,20,0]) cube([80 + extraHeight + 0.45, 60, 100]);
    }
    difference() {
     rotate([0,23.8,0]) translate([8,20,-150]) cube([80  + extraHeight + 0.45, 60, 200]);
     rotate([0,0,0]) translate([6,00,00]) cube([100, 100, 200]);

    }

}

module powerPanel(openUnder) {
    difference() {
        union() {
            difference() {
                intersection() {
                    union() {
                        difference() {
                            cube([200, 100, 15]);
                        
                            translate([52 - 22,65,-10]) rotate([45,0,0]) cube([19,2.5,50]);
                           translate([52 + 22.05 - 19,30,-8.25]) rotate([-45,0,0]) cube([19,2.5,50]);
                        

                        }

                        translate([52 -2,50 - 25 + 15,-(45-15)/2]) cube([4, 35, 45]);
                        translate([52 -2,50 - 25 + 15,-(45-15)/2 + 25]) cube([100, 4, 20]);
                        
                        translate([-77,0,-70]) cube([100, 100, 100]);

                        difference() {
                            translate([52 -30,50 - 30,-(45-15)/2]) cube([100, 60, 45]);
                            translate([52 -25,50 - 25,-(45-15)/2 - 1]) cube([110, 50, 60]);
                        }
                        difference() {
                            rotate([0,23.8,0]) translate([8,20,-150]) cube([80, 60, 200]);
                            rotate([0,0,0]) translate([6,00,00]) cube([100, 100, 200]);
                        }
                    }
                    rotate([0,23.8,0]) translate([8,20,0]) translate([0,0,-100]) cube([80 + extraHeight + 0.45, 60, 200]);
                }
                if(openUnder) {
                    translate([-15,25,15.01]) cube([100, 15, 15]);
                    translate([-15,60,15.01]) cube([100, 15, 15]);


                }

                rotate([0,90,0]) translate([-30,34,0]) cylinder(100, 3, 3);
                rotate([0,90,0]) translate([-30,50,0]) cylinder(100, 3, 3);
                rotate([0,90,0]) translate([-30,66,0]) cylinder(100, 3, 3);

                difference() {
                    rotate([0,23.8,0]) translate([8,20,0]) translate([10,10,-100]) cube([60, 40, 200]);
                    translate([8,20,0]) translate([-5,-20,0]) cube([200, 200, 200]);
                }

            }
            translate([52 -2,50 -30,-(45-15)/2 ]) cube([4, 60, 15]);

            translate([95,50,15]) union() {
                difference() {
                    union() {
                        cylinder(15, 5,5);
                        translate([-5,-10,0]) cube([10,10,15]);
                    }
                    translate([0,0, 3]) cylinder(13, 4.5/2,4.5/2);
                }
            }
            translate([30,25,15]) union() {
                cylinder(15, 5,5);
                if(!openUnder) {
                    translate([-5,-5,0]) cube([5,10,15]);
                }
            }
            translate([30,75,15]) union() {
                cylinder(15, 5,5);
                if(!openUnder) {
                    translate([-5,-5,0]) cube([5,10,15]);
                }
            }
        }
        translate([30,25,15]) translate([0,0, 3]) cylinder(13, 4.5/2,4.5/2);
        translate([30,75,15]) translate([0,0, 3]) cylinder(13, 4.5/2,4.5/2);

    }
}

module powerPanelCover() {
    difference() {
       intersection() {
            union() {
                translate([0,0,30]) cube([200, 100, 5]);
            }
            rotate([0,23.8,0]) translate([8,20,0]) translate([0,0,-100]) cube([80 + extraHeight + 0.5, 60, 200]);
        }

        difference() {
            translate([-83, 0, 84]) rotate([0,58,0]) cube([100, 100,100]);
            translate([27.4, 100, 30.01]) rotate([90,0,0]) cylinder(100, 5, 5);
        }
        difference() {
            translate([74 + extraHeight + 0.87, 0, 84]) rotate([0,58,0]) cube([100, 100,100]);
            translate([104.4 + extraHeight + 0.87, 100, 30.01]) rotate([90,0,0]) cylinder(100, 5, 5);
        }
        translate([95,50,-100]) translate([0,0, 8.1]) cylinder(150, 3.3/2,3.3/2);
        translate([30,25,-100]) translate([0,0, 8.1]) cylinder(150, 3.3/2,3.3/2);
        translate([30,75,-100]) translate([0,0, 8.1]) cylinder(150, 3.3/2,3.3/2);

    }
}

module connectorBase(length, singlescrew) {
    difference() {
        union() {
            difference() {

                difference() {
                    rotate([90,0,0]) translate([-50,-50,0.5]) connectorPanel();
                    translate([-500,length,-500]) rotate([0,0,0]) cube([1000, 1000, 1000]);

                    intersection() {
                        translate([-500,-0.51,-500]) cube([1000, 1000, 1000]);
                        difference() {

                            translate([0,0,-20]) rotate([0,0,23.8]) translate([-36.8,-32,-4]) cube([76.2  + extraHeight, 200, 48]);
                            translate([0,0,-20]) rotate([0,0,18]) translate([-36.8 - 83 + 5,-32,-4]) cube([76.2, 200, 48]);

                        }



                    }


                }

                translate([1.2 + extraHeight + 0.55,-2,0]) difference() {
                    translate([98.5, -100, -50]) rotate([0,0,58]) cube([100, 100,100]);
                    translate([40.28, 0.5, -50]) cylinder(100, 5, 5);
                }

                translate([1,-2,0]) difference() {
                    translate([-72, -100, -50]) rotate([0,0,58]) cube([100, 100,100]);
                    translate([-36.24, 0.48, -50]) cylinder(100, 5, 5);
                }
            }
            translate([32, 15.07, -30]) cylinder(18.5, 1.5, 1.5);
            translate([32, 15.07, -28.9]) cylinder(15, 4, 4);
            translate([32, 15.07, -28.9]) rotate([0,0,23.8]) translate([0,-4,0]) cube([6, 8, 15]);



            translate([-36.45, 15.13, -30]) cylinder(18.5, 1.5, 1.5);
            translate([-36.45, 15.13, -28.9]) cylinder(15, 4, 4);
            translate([-36.45, 15.13, -28.9]) rotate([0,0,4]) translate([-9.8,-4,0]) cube([9.8, 8, 15]);


            translate([5.4, 75.3, -30]) cylinder(18.5, 1.5, 1.5);
            translate([5.4, 75.3, -28.9]) cylinder(15, 4, 4);
            translate([5.4, 75.3, -28.9]) rotate([0,0,23.8]) translate([0,-4,0]) cube([6, 8, 15]);

            if(singlescrew) {
                difference() {
                    rotate([0,90,23.8]) translate([25 -1,42,-37.9]) cylinder(50, 5,5);
                    rotate([0,0,23.8]) translate([-15,22,-20]) rotate([0,20,0]) translate([-5,0,0]) cube([55, 100,20]);
                }
                difference() {
                    rotate([0,90,23.8]) translate([-25 +1,42,-37.9]) cylinder(50, 5,5);
                    rotate([0,0,23.8]) translate([-15,22,-1.3]) rotate([0,-20,0]) translate([-5,0,0]) cube([55, 100,20]);
                }
            } else {

                difference() {
                    rotate([0,90,23.8]) translate([25 -1,32,-37.9]) cylinder(50, 5,5);
                    rotate([0,0,23.8]) translate([-10,22,-20]) rotate([0,20,0]) translate([-5,0,0]) cube([55, 100,20]);
                }
                
                difference() {
                    rotate([0,90,23.8]) translate([25 -1,70,-37.9]) cylinder(50, 5,5);
                    rotate([0,0,23.8]) translate([-17,22,-20]) rotate([0,20,0]) translate([-5,0,0]) cube([55, 100,20]);
                }

                difference() {
                    rotate([0,90,23.8]) translate([-25 +1,32,-37.9]) cylinder(50, 5,5);
                    rotate([0,0,23.8]) translate([-6,22,-0]) rotate([0,-20,0]) translate([-5,0,0]) cube([55, 100,20]);
                }

                difference() {
                    rotate([0,90,23.8]) translate([-25 +1,70,-37.9]) cylinder(50, 5,5);
                    rotate([0,0,23.8]) translate([-17,22,-1]) rotate([0,-20,0]) translate([-5,0,0]) cube([55, 100,20]);
                }
            }

        }
        if(singlescrew) {
            
            rotate([0,90,23.8]) translate([24,42,-42]) cylinder(25, 3.3/2,3.3/2);
            rotate([0,90,23.8]) translate([-24,42,-42]) cylinder(25, 3.3/2,3.3/2);
            rotate([0,90,23.8]) translate([24,42,-57]) cylinder(25, 4,4);
            rotate([0,90,23.8]) translate([-24,42,-57]) cylinder(25, 4,4);

        } else {
            rotate([0,90,23.8]) translate([24,32,-38]) cylinder(25, 3.3/2,3.3/2);
            rotate([0,90,23.8]) translate([-24,32,-38]) cylinder(25, 3.3/2,3.3/2);
            rotate([0,90,23.8]) translate([24,70,-38]) cylinder(14, 3.3/2,3.3/2);
            rotate([0,90,23.8]) translate([-24,70,-38]) cylinder(14, 3.3/2,3.3/2);
        }
    }
}
module connector(length, showPlug, cover, base, singlescrew) {
    if(showPlug) {
     
        translate([0,0,0]) import("./new_connector.stl", convexity=3);
        translate([-45,-20,0]) rotate([0,0,90]) import("./new_connector-2.stl", convexity=3);
        rotate([0,0,-66.2]) translate([-186.7,110.1,-13]) import("renders/connector-pcb.stl", convexity=3);
    }

    if(base) {
        difference() {
            connectorBase(length, singlescrew);
            difference() {
                rotate([0,0,32]) translate([-115,-17,-50]) cube([100,200,100]);
                rotate([0,0,75]) translate([55,20,-50]) cube([100,100,100]);
            }

            rotate([0,90,23.8]) translate([-24,42,-46 + screwInsertHoleDepth]) cylinder(25, screwInsertHoleDiameter/2,screwInsertHoleDiameter/2);
            rotate([0,90,23.8]) translate([24,42,-46 + screwInsertHoleDepth]) cylinder(25, screwInsertHoleDiameter/2,screwInsertHoleDiameter/2);

        }

        rotate([0,0,32]) translate([-17.5,5,-28.45 + 0.1]) cube([10,100,1.6]);
        rotate([90,0,32]) translate([-17.5,15.1,-6 + 0.1]) cube([5,13.25,1.6]);

        mirror([0,0,1]){
            rotate([0,0,32]) translate([-17.5,5,-28.45 + 0.1]) cube([10,100,1.6]);
            rotate([90,0,32]) translate([-17.5,15.1,-6 + 0.1]) cube([5,13.25,1.6]);
        }
    }
    if(cover) {
        difference() {
            intersection() {
                connectorBase(length < 80 ? 80 : length, singlescrew);
                difference() {
                    rotate([0,0,32]) translate([-115,-17,-50]) cube([100,200,100]);
                    rotate([0,0,75]) translate([55,20,-50]) cube([100,100,100]);
                }
            }
            rotate([0,0,32]) translate([-18,4.1,-28.45 - 0.1]) cube([10,100,2]);
            rotate([90,0,32]) translate([-18,15,-6 - 0.1]) cube([5,13.45,2]);
            mirror([0,0,1]){
                rotate([0,0,32]) translate([-18,4.1,-28.45 - 0.1]) cube([10,100,2]);
                rotate([90,0,32]) translate([-18,15,-6 - 0.1]) cube([5,13.45,2]);
            }
        }
    }
}
module power(length, openUnder, showCover) {
    difference() {

        difference() {
            rotate([90,0,0]) translate([-50,-50,0.5]) union() {
                if(!showCover) {
                    powerPanel(openUnder);
                }
                if(showCover) {
                    powerPanelCover();
                }
            }
            translate([-500,length,-500]) rotate([0,0,0]) cube([1000, 1000, 1000]);
        }

    }
}

//color("red") translate([0,-0.01,0.01]) connector(
//    length = 80,
//    showPlug = false,
//    cover = true,
//    base = false
//);
//
//color("green") connector(
//    length = 90,
//    showPlug = false,
//    cover = false,
//    base = true
//);
//

module layer0RearMountCutout() {
    difference() {
        translate([590,-229,-750]) rotate([0,0,0]) cube([100, 100, 200]);
    
        difference() {
            translate([565,-150,-800]) cube([50, 50, 200]);
            translate([614, -153, -1485]) rotate([0, 0, 0]) cylinder(1800, 25, 25);
        }
    }
}


module layer1RearMountCutout() {
    translate([614, 145, -632])  rotate([0, 10, 0]) cylinder(1800, 25, 25);
     translate([577,-245,-700]) rotate([0,10,0]) cube([100, 100, 200]);
     translate([602,-220,-700]) rotate([0,10,0]) cube([100, 100, 200]);

}

module layer2RearMountCutout() {
    translate([632, 145, -632])  rotate([0, 0, 0]) cylinder(1800, 25, 25);
     translate([607,-245,-550]) rotate([0,0,0]) cube([100, 100, 200]);
     translate([632,-220,-550]) rotate([0,0,0]) cube([100, 100, 200]);

}

module layer3RearMountCutout() {
    translate([632, 145, -632]) rotate([0, 0, 0]) cylinder(1800, 25, 25);
     translate([607,-245,-550]) rotate([0,0,0]) cube([100, 100, 200]);
     translate([632,-220,-550]) rotate([0,0,0]) cube([100, 100, 200]);

}

module addonCutouts() {
    translate([730.2, 198.8, -1642]) rotate([0,-23.8,0]) cylinder(2000, 14, 14);
    translate([515, 185, -1642]) rotate([0,-23.8,0]) cube([200, 200, 2000]);
    mirror([0,1]) {
    translate([730.2, 198.8, -1642]) rotate([0,-23.8,0]) cylinder(2000, 14, 14);
        translate([515, 185, -1642]) rotate([0,-23.8,0]) cube([200, 200, 2000]);

    }
}

module layer0(showShell, showConnectors, showPlug, showCover, showSpacers, showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer0Spacers(showSpacersCutout);
    }

    if(showConnectors) {
        translate([202 - 18, -70 - 15 , -680 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(70, showPlug);
        translate([202 + 16, 70 + 15 , -680 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(60, false, showCover);
    }

    if(showShell) {
        difference() {
            //color("#e8e1df") import("./renders/layer0new2.stl", convexity=3);
            layer0base();
           translate([742,-500,-1000]) rotate([0,-15,0]) cube([1000, 1000, 1000]);
           translate([505,-500,-1000]) rotate([0,30,0]) cube([1000, 1000, 1000]);

           translate([570, -170, -485]) rotate([90, 0, 0]) cylinder(1800, 250, 250);

           layer0RearMountCutout();
           mirror([0,1]) {
               layer0RearMountCutout();
           }

        }
    }
}

module layer1(showShell, showPlug, showCover, showSpacers, showAddon, showConnectors,showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer1Spacers(showSpacersCutout);
    }

    if(showConnectors && showShell) {
        translate([160 - 18, -70 - 15 , -585 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(50, showPlug);
        translate([160 + 16, 70 + 15 , -585 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(30, true, showCover);
    }

    if(showShell) {
        difference() {
            //color("#e8e1df") import("./renders/layer1new2.stl", convexity=3);
            layer1base();

            layer1RearMountCutout();
            mirror([0,1]) {
                layer1RearMountCutout();
            }

        }

    }
    if(showAddon) {
        difference() {
            //color("#e8e1df") import("./renders/layer1addonnew2.stl", convexity=3);
            layer1addon();

            addonCutouts();
        }
    }
}


module layer2(showShell, showPlug, showCover, showSpacers, showAddon, showConnectors,showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer2Spacers(showSpacersCutout);
    }

    if(showConnectors && showShell) {
        translate([118 - 12, -120 - 15 , -490 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(50, showPlug);
        translate([118 + 22, 120 + 15 , -490 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(20, false, showCover);
    }

    if(showShell) {
        difference() {
            //color("#e8e1df") import("./renders/layer2new2.stl", convexity=3);
            layer2base();

            layer2RearMountCutout();
            mirror([0,1]) {
                layer2RearMountCutout();
            }

        }
    }
    if(showAddon) {
        difference() {
            //color("#e8e1df") import("./renders/layer2addonnew2.stl", convexity=3);
            layer2addon();

            addonCutouts();
        }
    }
}

module layer3(showShell, showPlug, showCover, showSpacers, showAddon, showConnectors,showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer3Spacers(showSpacersCutout);
    }

    if(showConnectors && showShell) {
        translate([76 - 12, -120 - 15 , -395 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(50, showPlug);
        translate([76 + 22, 120 + 15 , -395 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(30, true, showCover);
    }
    if(showShell) {
        difference() {
            //color("#e8e1df") import("./renders/layer3new2.stl", convexity=3);
            layer3base();
            layer3RearMountCutout();
            mirror([0,1]) {
                layer3RearMountCutout();
            }

        }
    }
    if(showAddon) {
        difference() {
            //color("#e8e1df") import("./renders/layer3addonnew2.stl", convexity=3);
            layer3addon();
            addonCutouts();
        }
    }
}


module layer0BottomPlate() {
    union() {
        intersection() {
            layer0(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-721.01]) cube([1000,1000,8]);
                translate([172,-500,-725.01]) cube([100,1000,15]);
                translate([-200,-229,-725.01]) cube([1000,100,15]);
                translate([-200,129,-725.01]) cube([1000,100,15]);
                translate([645,-500,-725.01]) cube([100,1000,15]);
            }
        }
        translate([258,-260,-721.01]) cube([89,520,8]);
        
        translate([347,-260,-721.01]) rotate([0,0,45]) cube([230,100,8]);
        mirror([0,1]){
            translate([347,-260,-721.01]) rotate([0,0,45]) cube([230,100,8]);
        }
        translate([372,-170,-721.01]) cube([283,340,8]);

    }
}

module layer1BottomPlate() {
    union() {
        intersection() {
            layer1(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showAddon = false,
                showConnectors = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-623.01]) cube([1000,1000,5]);
                translate([180,-500,-625.01]) cube([130,1000,15]);
                translate([172,-340,-625.01]) cube([1000,100,15]);
                mirror([0,1]){
                    translate([172,-340,-625.01]) cube([1000,100,15]);
                }
                translate([650,-500,-625.01]) cube([130,1000,15]);

            }
        }
        translate([550,-200,-623.01]) cube([100,400,5]);  

        translate([235,-245,-623.01]) cube([280,50,5]);
        translate([235,-260,-623.01]) cube([100,50,5]);
        translate([335,-260,-623.01]) rotate([0,0,45]) cube([120,65,5]);
        translate([300,-260,-623.01]) rotate([0,0,45]) cube([120,65,5]);

        mirror([0,1]){
            translate([235,-245,-623.01]) cube([280,50,5]);
            translate([235,-260,-623.01]) cube([100,50,5]);
            translate([335,-260,-623.01]) rotate([0,0,45]) cube([120,65,5]);
            translate([300,-260,-623.01]) rotate([0,0,45]) cube([120,65,5]);

        }  
    }
}

module layer1TopPlate() {

    union() {
        intersection() {
            layer1(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showAddon = false,
                showConnectors = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-547.99]) cube([1000,1000,5]);
                translate([172,-500,-550]) cube([130,1000,15]);
                translate([172,-340,-550]) cube([1000,100,15]);
                mirror([0,1]){
                    translate([172,-340,-550]) cube([1000,100,15]);
                }
                translate([650,-500,-550]) cube([130,1000,15]);

            }
        }
        translate([600,-200,-547.99]) cube([50,400,5]);    

        translate([200,-260,-547.99]) cube([315,65,5]);
        translate([270,-260,-547.99]) rotate([0,0,45]) cube([120,65,5]);

        mirror([0,1]){
            translate([200,-260,-547.99]) cube([315,65,5]);
            translate([270,-260,-547.99]) rotate([0,0,45]) cube([120,65,5]);

        }
    }
}

module layer2BottomPlate() {
    union() {
        intersection() {
            layer2(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showAddon = false,
                showConnectors = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-528.01]) cube([1000,1000,5]);
                translate([-15,-500,-530.01]) cube([150,1000,15]);

                translate([180,-335,-530.01]) cube([1000,100,15]);
                translate([105,-210,-530.01]) cube([150,120,15]);

                mirror([0,1]){
                    translate([180,-335,-530.01]) cube([1000,100,15]);
                    translate([105,-210,-530.01]) cube([150,120,15]);

                }



            }
        }
        translate([563,-200,-528.01]) cube([100,400,5]);  

        translate([190,-260,-528.01]) cube([325,65,5]);
        translate([270,-260,-528.01]) rotate([0,0,45]) cube([80,65,5]);
        translate([260,-130,-528.01]) rotate([0,0,45]) cube([80,65,5]);


        mirror([0,1]){
            translate([190,-260,-528.01]) cube([325,65,5]);
            translate([270,-260,-528.01]) rotate([0,0,45]) cube([80,65,5]);
            translate([260,-130,-528.01]) rotate([0,0,45]) cube([80,65,5]);
        }
    }
}

module layer2TopPlate() {

    union() {
        intersection() {
            layer2(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showAddon = false,
                showConnectors = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-452.99]) cube([1000,1000,5]);
                translate([-15,-500,-455.99]) cube([150,1000,15]);
                translate([663,-500,-455.99]) cube([150,1000,15]);

                translate([495,-300,-455.99]) cube([100,100,15]);

                translate([180,-335,-455.99]) cube([1000,100,15]);
                translate([75,-280,-455.99]) cube([150,200,15]);

                mirror([0,1]){
                    translate([495,-300,-455.99]) cube([100,100,15]);

                    translate([180,-335,-455.99]) cube([1000,100,15]);
                    translate([75,-280,-455.99]) cube([150,200,15]);

                }



            }
        }
        translate([563,-200,-452.99]) cube([100,400,5]);  

        translate([160,-260,-452.99]) cube([335,65,5]);
        translate([210,-245,-452.99]) rotate([0,0,45]) cube([100,65,5]);
        translate([235,-120,-452.99]) rotate([0,0,45]) cube([80,65,5]);


        mirror([0,1]){
            translate([160,-260,-452.99]) cube([335,65,5]);
            translate([210,-245,-452.99]) rotate([0,0,45]) cube([100,65,5]);
            translate([235,-120,-452.99]) rotate([0,0,45]) cube([80,65,5]);
        }
    }

}

module layer3BottomPlate() {

    union() {
        intersection() {
            layer3(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showAddon = false,
                showConnectors = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-433.01]) cube([1000,1000,5]);
                translate([-55,-500,-435.01]) cube([150,1000,15]);
                translate([623,-121,-435.01]) cube([150,242,15]);

                translate([180,-335,-435.01]) cube([1000,100,15]);
                translate([63,-290,-435.01]) cube([150,220,15]);
                translate([450,-300,-435.01]) cube([100,100,15]);

                mirror([0,1]){
                    translate([180,-335,-435.01]) cube([1000,100,15]);
                    translate([63,-290,-435.01]) cube([150,220,15]);
                    translate([450,-300,-435.01]) cube([100,100,15]);

                }



            }
        }
        translate([563,-200,-433.01]) cube([100,60,5]);  
        translate([606.5,-196.5,-433.01]) rotate([0,0,45]) cube([80,65,5]);


        translate([150,-260,-433.01]) cube([335,65,5]);
        translate([196,-241,-433.01]) rotate([0,0,45]) cube([100,65,5]);
        translate([95,-82,-433.01]) cube([130,100,5]);
        translate([220,-111,-433.01]) rotate([0,0,45]) cube([100,65,5]);

        mirror([0,1]){
            translate([563,-200,-433.01]) cube([100,60,5]);  
            translate([606.5,-196.5,-433.01]) rotate([0,0,45]) cube([80,65,5]);

            translate([150,-260,-433.01]) cube([335,65,5]);
            translate([196,-241,-433.01]) rotate([0,0,45]) cube([100,65,5]);
            translate([95,-82,-433.01]) cube([130,100,5]);
            translate([220,-111,-433.01]) rotate([0,0,45]) cube([100,65,5]);
        }
    }
}

module layer3TopPlate() {


    union() {
        intersection() {
            layer3(
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showAddon = false,
                showConnectors = false,
                showShell = true
            );
            difference() {
                translate([0,-500,-357.99]) cube([1000,1000,5]);
                translate([-55,-500,-360.01]) cube([150,1000,15]);
                translate([623,-125,-360.01]) cube([150,250,15]);

                translate([180,-335,-360.01]) cube([1000,100,15]);
                translate([30,-280,-360.01]) cube([150,220,15]);
                translate([400,-300,-360.01]) cube([100,100,15]);

                mirror([0,1]){
                    translate([180,-335,-360.01]) cube([1000,100,15]);
                    translate([30,-280,-360.01]) cube([150,220,15]);
                    translate([400,-300,-360.01]) cube([100,100,15]);


                }



            }
        }
        translate([558,-200,-357.99]) cube([100,60,5]);  
        translate([601.5,-196.5,-357.99]) rotate([0,0,45]) cube([80,65,5]);


        translate([120,-260,-357.99]) cube([335,65,5]);
        translate([166,-241,-357.99]) rotate([0,0,45]) cube([100,65,5]);
        translate([190,-100,-357.99]) rotate([0,0,45]) cube([50,60,5]);
        translate([95,-65,-357.99]) cube([100,65,5]);

        mirror([0,1]){
            translate([558,-200,-357.99]) cube([100,60,5]);  
            translate([601.5,-196.5,-357.99]) rotate([0,0,45]) cube([80,65,5]);

            translate([120,-260,-357.99]) cube([335,65,5]);
            translate([166,-241,-357.99]) rotate([0,0,45]) cube([100,65,5]);
            translate([190,-100,-357.99]) rotate([0,0,45]) cube([50,60,5]);
            translate([95,-65,-357.99]) cube([100,65,5]);
        }
    }
}

//translate([515,115,-1040]) rotate([90,0,177]) scale(990) color("#696968") import("./scan.stl", convexity=3);

//color("#7c7f94") connectingObjects();
//mirror([0,1]) {
//    color("#7c7f94") connectingObjects();
//}

 //difference() {
 //    layer0(
 //        showPlug = false,
 //        showCover = false,
 //        showSpacers = false,
 //        showShell = true,
 //        showSpacersCutout = false
 //    );
 //    layer0(
 //        showPlug = false,
 //        showCover = false,
 //        showSpacers = true,
 //        showShell = false,
 //        showSpacersCutout = true
 //    );
 //    translate([0,-500,-721.01 - 50]) cube([1000,1000,8 + 50]);
 //}


//projection() {
//layer0BottomPlate();
//}

//difference() {
//    layer1(
//        showPlug = false,
//        showCover = false,
//        showSpacers = false,
//        showAddon = false,
//        showConnectors = false,
//        showShell = true
//    );

   // layer1(
   //     showPlug = false,
   //     showCover = false,
   //     showSpacers = true,
   //     showAddon = false,
   //     showConnectors = false,
   //     showShell = false,
   //     showSpacersCutout = true
   // );
   // layer1BottomPlate();
   // layer1TopPlate();
//}
    //layer1BottomPlate();
  //  layer1TopPlate();

/*
difference() {
    layer2(
        showPlug = false,
        showCover = false,
        showSpacers = false,
        showAddon = true,
        showConnectors = false,
        showShell = false
    );

    layer2(
        showPlug = false,
        showCover = false,
        showSpacers = true,
        showAddon = false,
        showConnectors = false,
        showShell = false,
        showSpacersCutout = true
    );
    layer2BottomPlate();
    layer2TopPlate();
}*/
 //   layer2BottomPlate();
 //   layer2TopPlate();

/*
difference() {
    layer3(
        showPlug = false,
        showCover = false,
        showSpacers = false,
        showAddon = true,
        showConnectors = false,
        showShell = false
    );

    layer3(
        showPlug = false,
        showCover = false,
        showSpacers = true,
        showAddon = false,
        showConnectors = false,
        showShell = false,
        showSpacersCutout = true
    );
    layer3BottomPlate();
    layer3TopPlate();
}*/
//    layer3BottomPlate();
//    layer3TopPlate();






//color("#292928",1)/*color("red")*/  import("./renders/frame.stl", convexity=3);
