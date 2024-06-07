include <./final-details.scad>
include <../testpack.scad>




module layer0hollow(showShell, showConnectors, showPlug, showCover, showSpacers, showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer0Spacers(showSpacersCutout);
    }

    if(showConnectors) {
        translate([202 - 18, -70 - 15 , -680 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(70, showPlug, showCover, !showCover, true);
   //     translate([202 - 18, -70 - 15 , -680 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(70, showPlug, true, false, true);

        translate([202 + 16, 70 + 15 , -680 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(60, false, showCover);
    }

    if(showShell) {
      import("./shell-outside/layer0-hollow.stl", convexity=3);
    }
}

module layer1hollow(showShell, showPlug, showCover, showSpacers, showAddon, showConnectors,showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer1Spacers(showSpacersCutout);
    }

    if(showConnectors) {
        translate([160 - 18, -70 - 15 , -585 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(69, showPlug, false, true);
        translate([160 + 16, 70 + 15 , -585 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(30, true, showCover);
    }

    if(showShell) {
      color("magenta", 1)  import("./shell-outside/layer1-base-hollow.stl", convexity=3);
    }
    if(showAddon) {
      color("magenta", 1)  import("./shell-outside/layer1-addon-hollow.stl", convexity=3);
    }
}


module layer2hollow(showShell, showPlug, showCover, showSpacers, showAddon, showConnectors,showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer2Spacers(showSpacersCutout);
    }

    if(showConnectors && showShell) {
        translate([118 - 12, -120 - 15 , -490 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(50, showPlug);
        translate([118 + 22, 120 + 15 , -490 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(20, false, showCover);
    }

    if(showShell) {
      import("./shell-outside/layer2-base-hollow.stl", convexity=3);
    }
    if(showAddon) {
      import("./shell-outside/layer2-addon-hollow.stl", convexity=3);
    }
}

module layer3hollow(showShell, showPlug, showCover, showSpacers, showAddon, showConnectors,showSpacersCutout) {
    if(showSpacers) {
        color("magenta", 0.2) renderLayer3Spacers(showSpacersCutout);
    }

    if(showConnectors && showShell) {
        translate([76 - 12, -120 - 15 , -395 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  connector(50, showPlug);
        translate([76 + 22, 120 + 15 , -395 ]) rotate([90,90,0]) rotate([0,180 ,23.8])  power(30, true, showCover);
    }
    if(showShell) {
      import("./shell-outside/layer3-base-hollow.stl", convexity=3);
    }
    if(showAddon) {
      import("./shell-outside/layer3-addon-hollow.stl", convexity=3);
    }
}

//color("#292928",1)/*color("red")*/  import("./renders/frame.stl", convexity=3);
//translate([515,115,-1040]) rotate([90,0,177]) scale(990) color("#696968") import("./scan.stl", convexity=3);
//translate([275,-150,-638-5 - 65 - 2.5]) cube([100, 300, 65]);

module layer0parts(part0, part1, cover) {
  if(part0) {
    intersection() {
      difference() {
      
        layer0hollow(
          showShell = true,
          showPlug = false,
          showCover = false,
          showSpacers = false,
          showConnectors = false,
          showSpacersCutout = false
        );
        translate([260,-110,-638-5 - 2.5 - 8 + extraHeight + 0.5]) rotate([0,-45,0]) translate([-100,5,0]) cube([200, 50, 2.5]);

        translate([261,-110,-638-10.02 - 52]) rotate([0,45,0]) translate([-100,5,0]) cube([200, 50, 2.5]);
        translate([285,-110,-638-10.02 - 90 ]) rotate([0,-45,0]) translate([0,5,0])  cube([30, 50, 30]);

        translate([258,-150,-637-5+ extraHeight - 0.5]) cube([500,300,8 + 50]);


        translate([627,-125.4,-638-5 - 110]) rotate([0,-45,0]) cube([50,250.8,8 + 50]);

        translate([247,-5.45,-638-5 + extraHeight + 0.5 ]) rotate([0,45,0]) translate([8,-120,10]) cube([30,150,30]);
        
        translate([264,125.4,-638-5 -80]) rotate([0,20,0]) translate([0,-120,10]) cube([10,120,23]);
        translate([264,125.4,-638-5 -80]) rotate([0,20,0]) translate([0,0,10]) cube([10,30,15]);

        translate([253,125.4,-638-5 -77.65]) rotate([0,45,0]) translate([-72.07,15,18]) cube([80,15,15]);

        translate([247,-5.45,-638-5 + extraHeight + 0.5 ]) rotate([0,45,0]) translate([12.5,15,-50]) cube([15,15,100]);
        
        
       

        difference() {

          translate([200,-105,-638 - 70.57]) cube([100, 50.06, 68]);
          translate([200,-105,-638 - 70.57]) rotate([0,-23.8, 0]) translate([64,-30,-40]) cube([100, 100, 100]);

        }
        translate([200,-105,-638 - 70.57]) cube([56, 50.06, 68]);

        translate([654,500,-638 - 55]) rotate([90,0,0]) cylinder(h = 1000, r = 2.5);
        translate([654,139 - 4,-638 - 55]) rotate([90,0,0]) cylinder(h = 10, r = 7.5);
        mirror([0,1]) {
            translate([654,139 - 4,-638 - 55]) rotate([90,0,0]) cylinder(h = 10, r = 7.5);
        }

        translate([270,500,-638 - 42]) rotate([90,0,0]) cylinder(h = 1000, r = 2.5);
        translate([270,210 - 4,-638 - 42]) rotate([90,0,0]) cylinder(h = 10, r = 7.5);
        mirror([0,1]) {
            translate([270,210 - 4,-638 - 42]) rotate([90,0,0]) cylinder(h = 10, r = 7.5);
        }

        translate([0,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 1000, r = 2.5);
        translate([590,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 100, r = 7.5);
        mirror([0,1]) {
          translate([0,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 1000, r = 2.5);
          translate([590,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 100, r = 7.5);

        }


        translate([30 + screwInsertHoleDepth + 2,0,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = screwInsertHoleDiameter/2);
        translate([54 + screwInsertHoleDepth + 2,0,-638 - 65]) rotate([0,90,0]) cylinder(h = 200, r = screwInsertHoleDiameter/2);

        translate([30 + screwInsertHoleDepth + 2,136.5,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = screwInsertHoleDiameter/2);
        translate([30 + screwInsertHoleDepth + 2,-136.5,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = screwInsertHoleDiameter/2);


      }
      translate([384.8,-500,-1000 ]) rotate([0,-23.8,0]) cube([1000, 1000, 1000]);
    }

    translate([272.35,125.45,-713]) rotate([0,0,-90]) topSection(13, 14, false);

    translate([275.35,-128.45,-713]) topSection(19, 0, false);
    mirror([0,1]){
      translate([275.35,-128.45,-713]) topSection(19, 0, false);
      
    }
    translate([645.05,-125.45,-713]) rotate([0,0,90]) topSection(13, 0, false);
    translate([645,-125.45,-713.01]) cube([15, 252, 4]);
    translate([265,120,-713.01]) cube([15, 50, 1.75]);

  }

  if(part1) {
    intersection() {
      union() {
        difference() {
          layer0hollow(
              showShell = false,
              showPlug = false,
              showCover = cover,
              showSpacers = false,
              showConnectors = true,
              showSpacersCutout = false
          );
        translate([210,90,-638 ]) translate([22,15 -95,-53]) cube([30,145,38]);

          translate([258,-120,-638 - 83.01]) cube([100, 240, 8]);
     //  #   translate([245,-109,-638 - 74.77]) cube([20, 48, 1.5]);
          intersection() {
            translate([200,-90,-638 - 74.77]) cube([200, 100, 72.2]);
            translate([350, 400, -505]) rotate([90, 0, 0]) cylinder(800, 220, 220);
          }
        }
        if(!cover) {
          difference() {
            layer0hollow(
                showShell = true,
                showPlug = false,
                showCover = false,
                showSpacers = false,
                showConnectors = false,
                showSpacersCutout = false
            );
          translate([100,65,-638 - 70]) cube([200, 40, 60]);

            translate([210,90,-638 + 3.5 ]) translate([22,15 -95,-53]) cube([30,145,38]);

            translate([150,-109 - 6,-638 - 75.77]) cube([200, 60, 73.2]);
            intersection() {
              translate([200,-109,-638 - 74.77]) cube([200, 100, 72.2]);
              translate([350, 400, -505]) rotate([90, 0, 0]) cylinder(800, 220, 220);
            }
            translate([0,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 1000, r = 2.5);
            translate([140,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 100, r = 7.5);
            mirror([0,1]) {
              translate([0,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 1000, r = 2.5);
              translate([140,-136.5,-638 - 58]) rotate([0,90,0]) cylinder(h = 100, r = 7.5);

            }

            translate([100,0,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = 3.3/2);
            translate([100,0,-638 - 65]) rotate([0,90,0]) cylinder(h = 200, r = 3.3/2);
            translate([19,0,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = 8/2);
            translate([43,0,-638 - 65]) rotate([0,90,0]) cylinder(h = 200, r = 8/2);

            translate([40,136.5,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = 3.3/2);
            translate([40,-136.5,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = 3.3/2);

            translate([18,136.5,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = 8/2);
            translate([18,-136.5,-638 - 10]) rotate([0,90,0]) cylinder(h = 200, r = 8/2);
          }
        }
      }



      translate([-708.14,-500,-1000 ]) rotate([0,-23.8,0]) translate([0,0, -300]) cube([1000, 1000, 1000]);

    }
  }

}



module layer1parts(part0, part1) {
  if(part0) {
    difference() {
      layer1hollow(
        showShell = true,
        showPlug = false,
        showCover = false,
        showSpacers = false,
        showConnectors = false,
        showSpacersCutout = false,
        showAddon = false
      );
      
      translate([300,-40,-619]) rotate([0,-45,0]) cube([115,80,10]);
      translate([185,-40,-619]) cube([115,80,10]);

      translate([304.2,-231.15,-619]) rotate([0,-45,0]) translate([14,-10,0]) cube([12,480.1,10]);
      translate([315.4,-200,-630]) cube([115,400,100]);
      translate([300,-231.15,-629]) rotate([45,0,0]) translate([35.35,-10,-6]) cube([173,30,20]);
      translate([300,-231.15,-629]) translate([51,-10,-10]) rotate([0,-45,0]) cube([10,15,57.24]);
      difference(){
       translate([300,-231.15,-629]) translate([7,-10,27]) rotate([0,90,0]) cube([10,480.1,18.3]);
       translate([305,-250,-612]) rotate([0,45,45]) translate([0,-2,0]) cube([10,20,10]);
        mirror([0,1]){
        translate([305,-250,-612]) rotate([0,45,45]) translate([0,-2,0]) cube([10,20,10]);
        }

      }

   // #  translate([310,231.15,-619]) rotate([0,-45,0]) translate([10,0,0]) cube([12,10,10]);


      translate([300,231.15,-555]) rotate([45,0,0]) translate([15.35,-10,-6]) cube([193,30,20]);
      translate([315.4,228.95,-603.5]) cube([10,10,90]);

    }
  }

  if(part1) {
  
    difference() {
      layer1hollow(
          showShell = false,
          showPlug = false,
          showCover = false,
          showSpacers = false,
          showConnectors = true,
          showSpacersCutout = false,
          showAddon = true
      );
      translate([185,-40,-619]) cube([300,80,10]);
    }
  }

}
    
module layer0frontmiddle() {
  difference() {
    intersection() {

      translate([-100,0,0]) layer0parts(
        part0 = false,
        part1 = true
      );
      translate([00,-54.95,-800]) cube([220,109.9,250]);
    }
    
    translate([125,155 - screwInsertHoleDepth - 5,-660]) rotate([90,0,0]) cylinder(h = 100, r = screwInsertHoleDiameter/2);
    translate([145,155 - screwInsertHoleDepth - 5,-700]) rotate([90,0,0]) cylinder(h = 100, r = screwInsertHoleDiameter/2);


    translate([138,-55 + screwInsertHoleDepth + 5,-698.5]) rotate([90,0,0]) cylinder(h = 200, r = screwInsertHoleDiameter/2);
    translate([95,-55 + screwInsertHoleDepth + 5,-650]) rotate([90,0,0]) cylinder(h = 200, r = screwInsertHoleDiameter/2);

  }
}

module layer0frontleft() {
  difference() {

    intersection() {

      translate([-100,0,0]) layer0parts(
        part0 = false,
        part1 = true
      );
      translate([0,55,-800]) cube([220,220,250]);
    }
    translate([125,70,-660]) rotate([90,0,0]) cylinder(h = 50, r = 3.3/2);
    translate([125,66,-660]) rotate([90,0,0]) cylinder(h = 4, r = 8/2);
    
    translate([145,70,-700]) rotate([90,0,0]) cylinder(h = 50, r = 3.3/2);
    translate([145,66,-700]) rotate([90,0,0]) cylinder(h = 4, r = 8/2);



  }
}

module layer0frontright() {
  difference() {

    intersection() {

     translate([-100,0,0]) layer0parts(
        part0 = false,
        part1 = true
      );
      translate([0,-275,-800]) cube([220,220,250]);
    }

  
    translate([138,-35,-698.5]) rotate([90,0,0]) cylinder(h = 40, r = 3.3/2);
    translate([95,-35,-650]) rotate([90,0,0]) cylinder(h = 40, r = 3.3/2);

    translate([138,-58,-698.5]) rotate([90,0,0]) cylinder(h = 4, r = 7.5/2);
    translate([95,-58,-650]) rotate([90,0,0]) cylinder(h = 4, r = 8/2);


  }
}

module layer0frontleftcover() {
  intersection() {

    translate([-100,0,0]) layer0parts(
      part0 = false,
      part1 = true,
      cover = true
    );
    translate([0,55,-800]) cube([220,220,250]);
  }

}
module layer0frontrightcover() {
    intersection() {

      translate([-100,0,0]) layer0parts(
        part0 = false,
        part1 = true,
        cover = true
      );
        translate([0,-275,-800]) cube([220,220,250]);
    }
}



module layer0rearfrontmiddle() {
  difference() {
    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([200,-55,-800]) cube([220,110,250]);
    }
   
  }
  difference() {
    union() {
      translate([299.8,-69.99,-713]) rotate([0,0,90]) connectingSection(15,0,2);
      difference() {
          translate([265,-69.99,-713]) rotate([0,45,0]) translate([0,0,3]) cube([15,15,9]);
          translate([265,-75,-713 - 2.6]) rotate([0,45,0]) cube([25,25,25]);
          translate([265,-75,-713 - 2.6]) rotate([0,45,0]) translate([-10,0,8.187]) cube([25,25,2.5]);
          translate([265,-75,-713 - 25 + shellThicknessTopBottom/2]) cube([25,25,25]);

      }
      translate([268.5,-70,-713 + shellThicknessTopBottom/2]) cube([15,15,shellThicknessTopBottom/2]);



      difference() {
          translate([265,-69.99,-713 + 65 + extraHeight + 0.5]) rotate([0,45,0]) translate([-5.5,0,-1.414]) cube([19.1,15,20]);
          translate([265 + 3.14,-69.99 -1,-713 + 65 + extraHeight + 0.5]) rotate([0,45,0]) translate([-18,0,-1.414]) cube([40,20,20]);
          translate([265,-69.99,-713 + 52.92 + extraHeight + 0.5]) rotate([0,-45,0]) translate([-10,0,8.187]) cube([25,25,2.5]);
          translate([255,-71,-713 + 70 - shellThicknessTopBottom/2 + extraHeight + 0.5]) cube([25,25,25]);

      }
      translate([261,-70,-713 + 70 - shellThicknessTopBottom + extraHeight + 0.5]) cube([25,25,shellThicknessTopBottom/2]);

    }
     difference() {
      translate([265,-75,-713 - 2.6]) rotate([0,45,0]) cube([25,25,25]);
      translate([260,-70,-713 + shellThicknessTopBottom - 15]) cube([40,15,15]);

    }

    difference() {
      translate([265 + 3.14,-69.99 -1,-713 + 65 + extraHeight + 0.5]) rotate([0,45,0]) translate([-18,0,-1.414]) cube([40,20,20]);
      translate([255,-71,-713 + 70 - shellThicknessTopBottom + extraHeight + 0.5]) cube([50,25,25]);

    }
  }

  difference() {
    union() {
      mirror([0,1]) {
        translate([299.8,-69.99,-713]) rotate([0,0,90]) connectingSection(15,0,2);
      }


      difference() {
        translate([265,69.99 - 15,-713]) rotate([0,20,0]) translate([0,0,-5]) cube([15,15,30]);
        translate([265,65- 15,-713 - 2.6]) rotate([0,20,0]) translate([1.6,0,-5]) cube([25,25,50]);
        translate([255,65 - 15,-713 - 25 + shellThicknessTopBottom/2]) cube([25,25,25]);

      }
      translate([268,70 - 15 ,-713 + shellThicknessTopBottom/2]) cube([15,15,shellThicknessTopBottom/2]);

    }
    difference() {
      translate([265,65- 15,-713 - 2.6]) rotate([0,20,0]) translate([1.6,0,-5]) cube([25,25,50]);
      translate([260,70 - 15,-713 + shellThicknessTopBottom - 15]) cube([40,15,15]);

    }
    translate([275.35,65- 15,-700]) cube([25,25,50]);
    translate([251.5,70 - 15,-720]) cube([15,15,20]);

  }
}
module layer0rearfrontleft() {
  difference() {

    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([170,55,-800]) cube([220,220,250]);

    }
    translate([390 -15,100.99,-713]) connectingSection(15,0,1.9);
   

    translate([299.9,40 + 15,-713]) rotate([0,0,90]) connectingSection(15,0,2.1);

    difference() {
        translate([265,69.99 - 15,-713]) rotate([0,20,0]) translate([0,0,-5]) cube([15,15,30]);
        translate([265,65- 15,-713 - 2.6]) rotate([0,20,0]) translate([1.6,0,-5]) cube([25,25,50]);
        translate([255,65 - 15,-713 - 25 + shellThicknessTopBottom/2]) cube([25,25,25]);

      }
      translate([266,70 - 20 ,-713 + shellThicknessTopBottom/2]) cube([15,20,shellThicknessTopBottom/2]);

  }


}

module layer0rearfrontright() {
  difference() {

    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([170,-55 - 220,-800]) cube([220,220,250]);
    }

    mirror([0,1]) {
      translate([390 -15,100.99,-713]) connectingSection(15,0,1.9);
    }

    
    translate([299.9,-69.99,-713]) rotate([0,0,90]) connectingSection(15,0,2.1);
    difference() {
      translate([265,-69.99,-713]) rotate([0,45,0]) cube([15,15,15]);
      translate([200,-69.99,-713 - 15 + shellThicknessTopBottom / 2]) cube([100,15,15]);

    }

    difference() {
      translate([253,-69.99,-713 + 75 + extraHeight + 0.5]) rotate([0,45,0])  cube([30,15,15]);
      translate([200,-69.99,-713 + 69 + 0.125 + extraHeight + 0.25]) cube([100,15,15]);

    }
  }

}



module layer0rearmiddleleft() {
  difference() {

    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
     // translate([442,55,-800]) cube([220,220,250]);
      translate([390,55,-800]) cube([125,220,250]);

    }


  }
  translate([375.01,101,-713]) connectingSection(15,0,1.8);
  translate([514.99,101,-713]) connectingSection(15,0,1.8);

}

module layer0rearmiddleright() {
  difference() {

    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([390,-55 -220,-800]) cube([125,220,250]);

    }


  }

  mirror([0,1]) {
    translate([375.01,101,-713]) connectingSection(15,0,1.8);
    translate([514.99,101,-713]) connectingSection(15,0,1.8);
  }
}

module layer0rearrearmiddleaddition() {

  difference() {
    union( ) {
      translate([617.6,69.99,-713]) rotate([0,0,-90]) connectingSection(15,0,1.5);
      difference() {
        translate([640,70 -15,-713 + shellThicknessTopBottom /2 ]) cube([19, 15, 20]);
        translate([640,70 -15,-694 ]) rotate([0,45,0]) translate([-10,0,0]) cube([70, 15, 15]);
      }
      translate([640,70 -15,-713 + shellThicknessTopBottom /2 ])cube([10, 15, shellThicknessTopBottom /2]);
    }
    difference() {
        translate([600,70 -15.01,-713 + shellThicknessTopBottom ])  cube([70, 15.02, 25]);
      union() {
         translate([640,70 -15,-695.3 ]) rotate([0,45,0]) translate([-10,0,0]) cube([70, 15, 15]);
         translate([600,70 -15,-713 + shellThicknessTopBottom - 15])  cube([70, 15, 15]);
         translate([645,70 -15,-713 + shellThicknessTopBottom - 13.25])  cube([70, 15, 15]);
      }
    }
    translate([632.05,70 -15,-700])  cube([10, 15, 10]);
    translate([656.05,70 -15,-718])  cube([10, 15, 10]);

  }
}

module layer0rearrearmiddle() {
  difference() {
    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([515,-55,-800]) cube([220,110,250]);

    }

  }
  layer0rearrearmiddleaddition();
  mirror([0,1]) {
    layer0rearrearmiddleaddition();
  }

}

module layer0rearrearleft() {
  difference() {

    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([515.01,55,-800]) cube([220,220,250]);

    }

    translate([514.99,100.99,-713]) connectingSection(15,0,1.9);

    translate([617.59,70,-713]) rotate([0,0,-90]) connectingSection(15,0,1.51);
    difference() {
      translate([640,70 -15,-713 + shellThicknessTopBottom /2 ]) cube([15, 15, 15]);
      translate([640,70 -15,-694 ]) rotate([0,45,0]) cube([50, 15, 15]);
    }
  }
}

module layer0rearrearright() {
  difference() {

    intersection() {

      translate([0,0,0]) layer0parts(
        part0 = true,
        part1 = false
      );
      translate([515,-55 - 220,-800]) cube([220,220,250]);

    }
    mirror([0,1]) {

      translate([514.99,100.99,-713]) connectingSection(15,0,1.9);

      translate([617.59,70,-713]) rotate([0,0,-90]) connectingSection(15,0,1.51);
      difference() {
        translate([640,70 -15,-713 + shellThicknessTopBottom /2 ]) cube([15, 15, 15]);
        translate([640,70 -15,-694 ]) rotate([0,45,0]) cube([50, 15, 15]);
      }
    }


  }
}

    //    translate([-500, -500, -433]) cube([2000, 1000, 80 + extraHeight]);
//
    //    translate([-500, -500, -528]) cube([2000, 1000, 80 + extraHeight]);
//
    //    translate([-500, -500, -623]) cube([2000, 1000, 80 + extraHeight]);
    //  color("red")  translate([-500, -500, -623 - 11]) cube([2000, 1000, 11]);
//
    //    translate([-500, -500, -818 + extraHeight]) cube([2000, 1000, 180]);

//
translate([0,100,0]) layer0frontleft();
translate([-100,100,0]) layer0frontleftcover();
layer0frontmiddle();
translate([0,-100,0]) layer0frontright();
translate([0,-100,-100]) layer0frontrightcover();

translate([0,100,0]) layer0rearfrontleft();
layer0rearfrontmiddle();
translate([0,-100,0]) layer0rearfrontright();

translate([100,100,0]) layer0rearmiddleleft();

translate([100,-100,0]) layer0rearmiddleright();

translate([200,100,0]) layer0rearrearleft();
translate([200,0,0]) layer0rearrearmiddle();
translate([200,-100,0]) layer0rearrearright();


//layer0hollow(
//  showShell = false,
//  showPlug = false,
//  showCover = false,
//  showSpacers = true,
//  showConnectors = false,
//  showSpacersCutout = false
//);



//layer0parts(
//  part0 = true,
//  part1 = false
//);
//
//translate([-100, 0, 0]) layer0parts(
//  part0 = false,
//  part1 = true
//);



  //translate([274,125.4 - 10,-638-5 -68]) rotate([0,90,90]) cylinder(100, 3, 3);

//

//layer1hollow(
//  showShell = true,
//  showPlug = true,
//  showCover = true,
//  showSpacers = false,
//  showAddon = false,
//  showConnectors = true,
//  showSpacersCutout = false
//);
/*
layer2hollow(
  showShell = true,
  showPlug = true,
  showCover = true,
  showSpacers = false,
  showAddon = false,
  showConnectors = true,
  showSpacersCutout = false
);*/
/*layer3hollow(
  showShell = true,
  showPlug = true,
  showCover = true,
  showSpacers = false,
  showAddon = false,
  showConnectors = true,
  showSpacersCutout = false
);*/