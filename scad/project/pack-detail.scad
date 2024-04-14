include <./frame.scad>

transparancy = 1;



module cutouts() {
    translate([430,-218,-1000]) rotate([-9.5,-23.8,0]) cylinder(2000, 30, 30);
    translate([320,-383,-1000]) rotate([0,-23.8,0]) rotate([-9.5,0,0]) cube([100, 200,2000]);
    translate([353,-413,-1000]) rotate([0,-23.8,0]) rotate([-9.5,0,0]) cube([100, 200,2000]);

}

module cutoutsLayer0() {
    difference() {
        union() {
           // translate([0,-260,-685]) rotate([0,0, 1]) cube([2000, 100,60]);
           difference() {
            union() {

                translate([250,-179,-660]) rotate([0,0, 0]) cube([2000, 50,30 + extraHeight]);
                translate([2250,-154,-660]) rotate([0,-90,0]) cylinder(2000, 25, 25);
            }
            translate([160,-200,-700]) rotate([0,45,0]) cube([100, 100,100]);
           }
        }
      //  #translate([0,-260,-685]) rotate([0,0, 1]) cube([200, 100,100]);
    }

    translate([675,0,-660]) rotate([90,0,0]) cylinder(2000, 30, 30);

    translate([645,-0,-660]) rotate([0,0, 0]) cube([50, 400,60]);
    difference() {
      translate([801,0,-480]) rotate([90,0,0]) cylinder(2000, 250, 250);
      translate([457,-2000,-700]) rotate([0,0, 0]) cube([200, 2000,100]);

    }
    translate([720,-400,-760]) rotate([0,0, 0]) cube([200, 400,100]);

    translate([300,155,-1000]) rotate([0,0,0]) cylinder(2000, 5, 5);
    translate([450,155,-1000]) rotate([0,0,0]) cylinder(2000, 5, 5);
    translate([600,155,-1000]) rotate([0,0,0]) cylinder(2000, 5, 5);
   
    translate([270,-300,-800]) rotate([0,-23.8,0 ]) cube([100, 100,2000]);


}

module cutoutsLayer1() {
    cutouts();
    translate([133.45,-150,-750]) rotate([0,-23.8,0]) cube([200, 300,200]);
    translate([190,122,-785]) rotate([0,-45,0]) cube([200, 54.5,200]);
    translate([648,-400,-630]) rotate([0,8, 0]) cube([200, 400,200]);

}

module coutoutsLayer1AddOns() {
    translate([435,-218,-1000]) rotate([-9.5,-23.8,0]) cylinder(2000, 30, 30);
    translate([250,0,-570]) rotate([90,0,0]) cylinder(141, 35, 35);
    translate([240,280,-500]) rotate([90,0,0]) cylinder(150, 60, 60);
    translate([432,-248.2,-1000]) rotate([0,-23.8,0]) rotate([-9.5,0,0]) cube([100, 60,2000]);
    translate([132,-260,-1000]) cube([200, 60,2000]);
    translate([600,-260,-700]) cube([200, 1000,200]);

}


module cutoutsLayer2() {
    cutouts();
    translate([648,-400,-630]) rotate([0,8, 0]) cube([200, 400,200]);
}

module coutoutsLayer2AddOns() {
    translate([435,-218,-1000]) rotate([-9.5,-23.8,0]) cylinder(2000, 30, 30);
    translate([240,280,-500]) rotate([90,0,0]) cylinder(200, 60, 60);

    translate([432,-248.2,-1000]) rotate([0,-23.8,0]) rotate([-9.5,0,0]) cube([100, 60,2000]);
    translate([32,-260,-1000]) cube([300, 60,2000]);

   //# translate([195,-260,-540]) cube([300, 200,100]);
    translate([600,-260,-600]) cube([200, 1000,200]);

}


module cutoutsLayer3() {
    cutouts();
    translate([625,-400,-530]) rotate([0,0, 0]) cube([200, 400,200]);

}

module coutoutsLayer3AddOns() {
    translate([435,-218,-1000]) rotate([-9.5,-23.8,0]) cylinder(2000, 30, 30);

    translate([432,-248.2,-1000]) rotate([0,-23.8,0]) rotate([-9.5,0,0]) cube([100, 60,2000]);
    translate([32,-260,-1000]) cube([300, 60,2000]);

    translate([600,-260,-500]) cube([200, 1000,200]);

}

module cutoutsLayer4() {
    

}


module cutoutsLayer5() {
    

}

module layers() {
    union() {
//        difference() {
//            color("yellow", transparancy) renderLayer0Shell();
//            cutoutsLayer0();
//            mirror([0,1]) {
//                cutoutsLayer0();
//            }
//       }
//        difference() {
//            color("yellow", transparancy) renderLayer1Shell();
//            cutoutsLayer1();
//            mirror([0,1]) {
//                cutoutsLayer1();
//            }
//        }
    difference() {
        renderLayer2Shell();
        cutoutsLayer2();
        mirror([0,1]) {
            cutoutsLayer2();
        }
    }
//        difference() {
//            renderLayer3Shell();
//            cutoutsLayer3();
//            mirror([0,1]) {
//                cutoutsLayer3();
//            }
//    }
   //  difference() {
   //      color("yellow", transparancy) renderLayer4Shell();
   //      cutoutsLayer4();
   //      mirror([0,1]) {
   //          cutoutsLayer4();
   //      }
   //  }
   //  difference() {
   //      color("yellow", transparancy) renderLayer5Shell();
   //      cutoutsLayer5();
   //      mirror([0,1]) {
   //          cutoutsLayer5();
   //      }
   //  }
    }

}
module layersAddOns() {
    union() {
       
   //     difference() {
   //         renderLayer1Shell();
   //         difference() {
   //             renderLayer1Shell();
   //             cutoutsLayer1();
   //             mirror([0,1]) {
   //                 cutoutsLayer1();
   //             }
   //         }
   //         coutoutsLayer1AddOns();
   //         mirror([0,1]) {
   //             coutoutsLayer1AddOns();
   //         }
   //     }
   union() {

        difference() {
            union() {
                renderLayer2Shell();
            }
            difference() {
                renderLayer2Shell();
                cutoutsLayer2();
                mirror([0,1]) {
                    cutoutsLayer2();
                }
            }
            coutoutsLayer2AddOns();
            mirror([0,1]) {
                coutoutsLayer2AddOns();
            }
        }

        difference(){
            union() {
                translate([180,-200,-463.01]) cube([60,52,15]);
                mirror([0,1]) {
                    translate([180,-200,-463.01]) cube([60,52,15]);
                }
            }
            difference() {
                renderLayer2Shell();
                cutoutsLayer2();
                mirror([0,1]) {
                    cutoutsLayer2();
                }
            }
        }

   }
//        difference() {
//            renderLayer3Shell();
//            difference() {
//                renderLayer3Shell();
//                cutoutsLayer3();
//                mirror([0,1]) {
//                    cutoutsLayer3();
//                }
//            }
//            coutoutsLayer3AddOns();
//            mirror([0,1]) {
//                coutoutsLayer3AddOns();
//            }
//        }
//
    }

}
module layersWithoutSpacers() {
    union() {
 //       difference() {
 //           color("yellow", transparancy) renderLayer0Shell();
 //           cutoutsLayer0();
 //           mirror([0,1]) {
 //               cutoutsLayer0();
 //           }
 //           translate([275.4,-126,-718]) cube([367, 252, 100]);
 //       }
 //       difference() {
 //           color("yellow", transparancy) renderLayer1Shell();
 //           cutoutsLayer1();
 //           mirror([0,1]) {
 //               cutoutsLayer1();
 //           }
 //           translate([315,-193,-628]) cube([329, 387, 90]);
 //           translate([315,-231,-628]) cube([195, 463, 90]);
//
 //       }


        difference() {
            color("yellow", transparancy) renderLayer2Shell();
            cutoutsLayer2();
            mirror([0,1]) {
                cutoutsLayer2();
            }
            translate([255,-193,-533]) cube([406, 387, 90]);
            translate([278,-232,-533]) cube([213, 464, 90]);
            translate([138,-95,-533]) cube([213, 192, 90]);

        }

  //      difference() {
  //          color("yellow", transparancy) renderLayer3Shell();
  //          cutoutsLayer3();
  //          mirror([0,1]) {
  //              cutoutsLayer3();
  //          }
//
  //          translate([215,-193,-438]) cube([406, 387, 90]);
  //          translate([238,-232,-438]) cube([213, 464, 90]);
  //          translate([98,-78,-438]) cube([183, 155, 90]);
//
  //      }
    }
}

//renderFrame();
//renderLayer0Spacers();
//renderLayer1Spacers();
//renderLayer2Spacers();
//renderLayer3Spacers();

module layer0base() {
        difference() {
            color("yellow", transparancy) renderLayer0Shell();
           cutoutsLayer0();
           mirror([0,1]) {
               cutoutsLayer0();
           }
       }
}


module layer1addon() {
        difference() {
            renderLayer1Shell();
            difference() {
                renderLayer1Shell();
                cutoutsLayer1();
                mirror([0,1]) {
                    cutoutsLayer1();
                }
            }
            coutoutsLayer1AddOns();
            mirror([0,1]) {
                coutoutsLayer1AddOns();
            }
        }
}

module layer1base() {
        difference() {
            color("yellow", transparancy) renderLayer1Shell();
            cutoutsLayer1();
            mirror([0,1]) {
                cutoutsLayer1();
            }
        }
}

module layer2addon() {

        difference() {
            union() {
                renderLayer2Shell();
            }
            difference() {
                renderLayer2Shell();
                cutoutsLayer2();
                mirror([0,1]) {
                    cutoutsLayer2();
                }
            }
            coutoutsLayer2AddOns();
            mirror([0,1]) {
                coutoutsLayer2AddOns();
            }
        }

        difference(){
            union() {
                translate([180,-200,-463.01]) cube([60,52,15]);
                mirror([0,1]) {
                    translate([180,-200,-463.01]) cube([60,52,15]);
                }
            }
            difference() {
                renderLayer2Shell();
                cutoutsLayer2();
                mirror([0,1]) {
                    cutoutsLayer2();
                }
            }
        }

}

module layer2base() {
    difference() {
        renderLayer2Shell();
        cutoutsLayer2();
        mirror([0,1]) {
            cutoutsLayer2();
        }
    }
}

module layer3addon() {
        difference() {
            renderLayer3Shell();
            difference() {
                renderLayer3Shell();
                cutoutsLayer3();
                mirror([0,1]) {
                    cutoutsLayer3();
                }
            }
            coutoutsLayer3AddOns();
            mirror([0,1]) {
                coutoutsLayer3AddOns();
            }
        }
}

module layer3base() {
        difference() {
            renderLayer3Shell();
            cutoutsLayer3();
            mirror([0,1]) {
                cutoutsLayer3();
            }
    }
}


//layersWithoutSpacers();


