$fn=100;
// include the YAPPgenerator library
include <../YAPP_Box/YAPPgenerator_v3.scad>

// Option variables useful for debugging, uncomment what is needed

//showPCB = true;
//hideLidWalls = true;
//hideBaseWalls = true;
//showMarkersPCB = true;
//showSideBySide = false;
//inspectX = 55;
//inspectZ = 9;
//showOrientation = false;

// version, incremented by 1 for each print of modified model
 prVersion = "13";

//--- PCB dimensions
pcbLength     = 64.47;
pcbWidth      = 27.00;
pcbThickness  =  1.10;
coverThickness=  1.5;

// Lid an Base dimensions
lidWallHeight  = 11.00;   // was  6.30 - 13.00 - 10 - 9 - 8.50 - 9
baseWallHeight = 11.30;   // was 18.00

//-- padding between pcb and inside wall
paddingFront        =  0.5; // was 1.0
paddingBack         =  1.0;
paddingRight        =  4.0;
paddingLeft         =  0.0;

//-- Thickness
wallThickness       = 2.4;
basePlaneThickness  = 3.0;
lidPlaneThickness   = 2.0;

//-- ridge where base and lid off box can overlap
//-- Make sure this isn't less than lidWallHeight
ridgeHeight         = 4.5;  // was 5.0
ridgeSlack          = 0.3;

//-- the radius of all outside edges and corners
roundRadius         = 3.0;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 17.00;
standoffDiameter    =  3.2;
standoffPinDiameter =  1.8;
standoffHoleSlack   =  0.2;

//  *** Snap Joins ***
snapJoins   =   
[
    [pcbLength/2, 3,           yappLeft, yappRight, yappRectangle]
   //,[pcbLength-20, 5, yappLeft, yappRight]
]; 

 
// module holder3d() {
//     translate([0, 0, -1])
//     rotate([-90, 0, 0])
//     difference() {
//        cylinder(4, 1.5, 1.5);
//        translate([-4, -2, -0.5]) cube([4, 4, 6]);
//     }
// }

module antennaHolder() {
    ahW =  1.5;        // Width
    ahH = 10.3;  // Height was 8.0
    ahL =  6.0;        // Length
    ahX = wallThickness + 52.45 + 0.2 + ahW;
    ahY = wallThickness + 18.85 - 0.2 + 1.8;
    ahZ = basePlaneThickness;
    translate([ahX - ahL, ahY - ahW, ahZ])
    cube([ahL, ahW, ahH]);

    translate([ahX, ahY - ahW, ahZ])
    cube([ahW, ahL, ahH]);
    
    translate([ahX - ahL - ahW, ahY - ahW, ahZ])
    cube([ahW, ahL, ahH]);
    
}

module printVersion() {
    font      = "Liberation Sans";
    fontSize  = 10;
    textH     =  0.25;
    textX     = [15, 47,  20]; // Base, Lid, Battery Cover
    textY     = [15, 72, -30];
    textZ     = [basePlaneThickness - textH, lidPlaneThickness - textH, coverThickness - textH];
    for (ipv = [0 : 2])
      translate([textX[ipv], textY[ipv], textZ[ipv]])
      linear_extrude(textH+0.1)
      text(text = prVersion, font = font, size = fontSize);
}

//module battery() {
//    
//    // Back wall
//    backBatteryX = 6.1;                 //x position
//    backBatteryY = wallThickness;       //y position
//    backBatteryZ = basePlaneThickness;  //z posizion
//    backBatteryW = 1.5;                 // width
//    backBatteryL = shellWidth-(wallThickness*2); // length
//    backBatteryH = 11.2;                // height was 11.2
//    
//    // Front wall
//    frontBatteryX = backBatteryX + backBatteryW + 41;
//    frontBatteryY = wallThickness;
//    frontBatteryZ = basePlaneThickness;
//    frontBatteryW = 1.5;
//    frontBatteryL = shellWidth-(wallThickness*2);
//    frontBatteryH = 5;
//    
//    // Back holders
//    backHolderY1 = backBatteryY +  4;
//    backHolderY2 = backBatteryY + 22;
//    backHolderX  = backBatteryX + backBatteryW;
//    backHolderZ  = backBatteryH + basePlaneThickness;
//    
//    // Left holders
//    leftHolderX  = backBatteryX + 23;
//    leftHolderX2 = backBatteryX +  9;
//    leftHolderY  = backBatteryY;
//    leftHolderZ  = backHolderZ;
//    
//    // Right holders
//    rightHolderX  = backBatteryX + 19;
//    rightHolderX2 = backBatteryX +  5;
//    rightHolderY  = backBatteryY + backBatteryL;
//    rightHolderZ  = backHolderZ;
//    
//    // Draw back wall
//    translate([backBatteryX, backBatteryY, backBatteryZ])
//    cube([backBatteryW, backBatteryL, backBatteryH]);
//
//    // Draw front wall
//    translate([frontBatteryX, frontBatteryY, frontBatteryZ])
//    cube([frontBatteryW, frontBatteryL, frontBatteryH]);
//    
//    // Draw back holders
//    translate([backHolderX, backHolderY1, backHolderZ]) holder3d();
//    translate([backHolderX, backHolderY2, backHolderZ]) holder3d();
//
//    // Draw left holders
//    translate([leftHolderX,  leftHolderY,  leftHolderZ])  rotate([0, 0, 90]) holder3d();
//    translate([leftHolderX2, leftHolderY,  leftHolderZ])  rotate([0, 0, 90]) holder3d();
//    
//    // Draw right holders
//    translate([rightHolderX, rightHolderY, rightHolderZ]) rotate([0, 0, -90]) holder3d();
//    translate([rightHolderX2,rightHolderY, rightHolderZ]) rotate([0, 0, -90]) holder3d();
//}


module batteryCover() {
    
    // Back wall
    backBatteryX = 5.6;                 //x position
    backBatteryY = wallThickness;       //y position
    backBatteryZ = basePlaneThickness;  //z posizion
    backBatteryW = 2.0;                 // width
    backBatteryL = shellWidth-(wallThickness*2); // length
    backBatteryH = 10.3;                // height was 9.5
    
    // Front wall
    frontBatteryX = backBatteryX + backBatteryW + 41;
    frontBatteryY = backBatteryY;
    frontBatteryZ = backBatteryZ;
    frontBatteryW = backBatteryW;
    frontBatteryL = backBatteryL;
    frontBatteryH = backBatteryH;
    
    // Back holders
    backHolderY1 = backBatteryY +  4;
    backHolderY2 = backBatteryY + 22;
    backHolderX  = backBatteryX + backBatteryW;
    backHolderZ  = backBatteryH + basePlaneThickness;
    
    // Left holders
    leftHolderX  = backBatteryX + 23;
    leftHolderX2 = backBatteryX +  9;
    leftHolderY  = backBatteryY;
    leftHolderZ  = backHolderZ;
    
    // Right holders
    rightHolderX  = backBatteryX + 19;
    rightHolderX2 = backBatteryX +  5;
    rightHolderY  = backBatteryY + backBatteryL;
    rightHolderZ  = backHolderZ;
    
    // Battery Conver
    bcThick     = 1.5;     // Battery Cover Thickness
    bcTolerance = 0.3;     // Battery Cover Tolerance

    // Tooth (to join Battery Cover with Battery compartment)
    toothW = backBatteryW * 2;   // tooth Width 
    toothD = backBatteryW - 0.5; // tooth Depth
    toothH = backBatteryW + 2;   // tooth Height
   
    // Draw back wall
    translate([backBatteryX, backBatteryY, backBatteryZ])
    difference(){
        cube([backBatteryW,   backBatteryL, backBatteryH]);

        translate([backBatteryW - toothD, backBatteryL/4, backBatteryH-toothH])
        cube([toothD+1, toothW, toothH+1]);

        translate([backBatteryW - toothD, backBatteryL-backBatteryL/2.5, backBatteryH-toothH])
        cube([toothD+1, toothW, toothH+1]);
    }

    // Draw front wall
    color("red")
    translate([frontBatteryX, frontBatteryY+5, frontBatteryZ])
    difference() {
        cube([frontBatteryW, frontBatteryL - 15.7, frontBatteryH]);

        // -1.4 _?
        translate([-1, (frontBatteryL - 11)/8,  frontBatteryH - toothH])
        cube([toothD+1, toothW, toothH+1]);

        translate([-1, frontBatteryL - frontBatteryL/1.4, frontBatteryH-toothH])
        cube([toothD+1, toothW, toothH+1]);
    }
    
    //----- Draw battery cover
    color("blue")
    rotate([180, 0,0])
    translate([0,8,-basePlaneThickness-backBatteryH-backBatteryW+0.5])
    union(){
    
        // Draw Back tooths
        translate([backBatteryX, backBatteryY, backBatteryZ+bcTolerance])
        union() {
            // 0.6 = 0.4 (reduced wall) + bcTolerance
            translate([frontBatteryW-toothD+bcTolerance*1.5, backBatteryL/4+bcTolerance/2, backBatteryH-toothH])
            cube([toothD-bcTolerance, toothW-bcTolerance*1.5, toothH-bcTolerance]);
    
            translate([frontBatteryW-toothD+bcTolerance*1.5, backBatteryL-backBatteryL/2.5+bcTolerance/2, backBatteryH-toothH])
            cube([toothD-bcTolerance*1.5, toothW-bcTolerance, toothH-bcTolerance]);
        }
    
       //--- Draw Front tooths
        translate([frontBatteryX, frontBatteryY+5, frontBatteryZ])
        union(){
            translate([0, (frontBatteryL-11)/8+0.1, frontBatteryH-toothH+bcTolerance])
            cube([toothD-bcTolerance*1.5, toothW-bcTolerance, toothH-bcTolerance]);
    
            translate([0, frontBatteryL - frontBatteryL/1.4, frontBatteryH-toothH+bcTolerance])
            cube([toothD-bcTolerance*1.5, toothW-bcTolerance, toothH-bcTolerance]);
        }
        
        
        //--- Draw Cover
        translate([backBatteryX+bcTolerance, backBatteryY+bcTolerance, backBatteryH+backBatteryZ])
        difference() {
            cube([frontBatteryX - backBatteryX + backBatteryW - bcTolerance*2, frontBatteryL-bcTolerance*2, 1.5]);
    
            translate([0,3.3,-2]) linear_extrude(10)
            circle(standoffDiameter/2+bcTolerance*3);
    
            translate([0,25.3,-2]) linear_extrude(10)
            circle(standoffDiameter/2+bcTolerance*3);
            
            translate([frontBatteryX-7/1.7, frontBatteryY+frontBatteryL-9,-2]) linear_extrude(10)
            rotate([0,0,22])
            square(9);

    }
}
        
    
//    // Draw back holders
//    translate([backHolderX, backHolderY1, backHolderZ]) holder3d();
//    translate([backHolderX, backHolderY2, backHolderZ]) holder3d();
//
//    // Draw left holders
//    translate([leftHolderX,  leftHolderY,  leftHolderZ])  rotate([0, 0, 90]) holder3d();
//    translate([leftHolderX2, leftHolderY,  leftHolderZ])  rotate([0, 0, 90]) holder3d();
//    
//    // Draw right holders
//    translate([rightHolderX, rightHolderY, rightHolderZ]) rotate([0, 0, -90]) holder3d();
//    translate([rightHolderX2,rightHolderY, rightHolderZ]) rotate([0, 0, -90]) holder3d();
}



// Cut pins generated by the YAPP library. They tend to break if too hight
module cutPins() {
    translate([wallThickness,wallThickness, basePlaneThickness + standoffHeight + pcbThickness + 0.3 ])
    cube([pcbLength,pcbWidth,10]);
}


pcbStands =
[
      [ 2.56, 3.44, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 1 ],
      [ 2.56,25.59, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 1 ],
      [61.91, 3.44, standoffHeight, -1, standoffDiameter+1, 0,   standoffHoleSlack, 1, yappBaseOnly ],
      [61.91,25.59, standoffHeight, -1, standoffDiameter+1, 0,   standoffHoleSlack, 1, yappBaseOnly ],
      [49.97,23.00, standoffHeight, -1, 3.5, 2.25, standoffHoleSlack, 1, yappLidOnly ],
];

cutoutsLeft =
[
    [50.10, -4.00, 8.55, 4.00, 2.0, yappRectangle, yappCoordPCB, yappOrigin ], // switch
    [47.10, -7.00,14.55,10.50, 2.0, yappRectangle, 2.0, yappCoordPCB, yappOrigin ], // switch
    [40.33, -2.50, 4.90, 3.25, 2.0, yappRectangle, yappCoordPCB, yappOrigin ], // reset    
];

cutoutsFront =
[
    [ 3.00, 0.5, 10.00, 4.50, 1.0, yappRoundedRect, yappCoordPCB, yappOrigin ], // USB
    [14.00, 0.5, 12.00, 4.50, 2.0, yappRectangle,   yappCoordPCB, yappOrigin ], // SD card
    
];


lightTubes =
[
      [47.50, 1.60, 3.00, 3.00, 0.75, 1.5, yappCircle,
           0, standoffHeight+pcbThickness, 1.0, yappCoordPCB ], // LED bottom

      [58.50,26.40, 2.00, 6.00, 0.75, 3.4, yappRectangle, 
        0, standoffHeight+pcbThickness, 1.0, yappCoordPCB ],  // LED top
  
];

cutoutsLid =
[
//    [46.00, 0.10, 0.00, 0.00,     1.5, yappCircle,      yappCoordPCB, yappOrigin ], // LED bottom
//    [55.50,25.40, 6.00, 2.00,     0.5, yappRoundedRect, yappCoordPCB, yappOrigin ], // LED top
    [14.50, 8.50,24.50,14.70+1.0, 0.5, yappRectangle,   yappCoordPCB, yappOrigin ], // Display
    
    
];

cutoutsRight =
[
    [49.97, -7.00, 0.00, 0.00, 4.5, yappCircle,      yappCoordPCB, yappCenter ], // Antenna        
    [ 0.00,  1.20, 0.00, 0.00, 1.5, yappCircle,      yappCoordPCB, yappOrigin ], // Handle cord
];

cutoutsBack =
[
    [ pcbWidth,  1.20, 0.00, 0.00, 1.5, yappCircle,      yappCoordPCB, yappOrigin ], // Handle cord

];

//-------- Generate the case
difference() {
    YAPPgenerate();
    cutPins();
    printVersion();
}
difference() {
    batteryCover();
    printVersion();
}
antennaHolder();
//printVersion();