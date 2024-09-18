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



// -------------------------------------------------------

pcbLength     = 64.47;
pcbWidth      = 27.00;
pcbThickness  =  1.10;

lidWallHeight  =  9.00;   // was  6.30 - 13.00 - 10 - 9 - 8.50
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
ridgeHeight         = 5.0;
ridgeSlack          = 0.3;

//-- the radius of all outside edges and corners
roundRadius         = 3.0;

//-- How much the PCB needs to be raised from the base
//-- to leave room for solderings and whatnot
standoffHeight      = 15.00;
standoffDiameter    =  3.2;
standoffPinDiameter =  1.8;
standoffHoleSlack   =  0.2;

//  *** Snap Joins ***
snapJoins   =   
[
    [pcbLength/2, 3,           yappLeft, yappRight, yappRectangle]
   //,[pcbLength-20, 5, yappLeft, yappRight]
]; 


 module holder2d() {
     rotate([90, 0, 0])
     union() {
         square([1.4,1.5]);
         square([1.5,1.5]);
         //translate([1.5, 1.5, 0]) circle(1.5);
     }
 } 
 
 module holder3d() {
     translate([0, 0, -1])
     rotate([-90, 0, 0])
     difference() {
        cylinder(4, 1.5, 1.5);
        translate([-4, -2, -0.5]) cube([4, 4, 6]);
     }
 }

module antennaHolder() {
    ahW =  1.5;  // Width
    ahH =  9.0 - 1.0;  // Height
    ahL =  6.0;  // Length
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

module battery() {
    backBatteryX = 6.1;            //x position
    backBatteryY = wallThickness;  //y position
    backBatteryZ = basePlaneThickness; //z posizion
    backBatteryW = 1.5;            // width
    backBatteryL = shellWidth-(wallThickness*2); // length
    backBatteryH = 11.2;           // height
    
    frontBatteryX = backBatteryX + backBatteryW + 41;
    frontBatteryY = wallThickness;
    frontBatteryZ = basePlaneThickness;
    frontBatteryW = 1.5;
    frontBatteryL = shellWidth-(wallThickness*2);
    frontBatteryH = 5;
    
    backHolderY1 = backBatteryY +  4;
    backHolderY2 = backBatteryY + 22;
    backHolderX  = backBatteryX + backBatteryW;
    backHolderZ  = backBatteryH + basePlaneThickness;
    
    leftHolderX  = backBatteryX + 23;
    leftHolderX2 = backBatteryX +  9;
    leftHolderY  = backBatteryY;
    leftHolderZ  = backHolderZ;
    
    rightHolderX  = backBatteryX + 19;
    rightHolderX2 = backBatteryX +  5;
    rightHolderY  = backBatteryY + backBatteryL;
    rightHolderZ  = backHolderZ;
    
    translate([backBatteryX, backBatteryY, backBatteryZ])
    cube([backBatteryW, backBatteryL, backBatteryH]);

    translate([frontBatteryX, frontBatteryY, frontBatteryZ])
    cube([frontBatteryW, frontBatteryL, frontBatteryH]);
    
    translate([backHolderX, backHolderY1, backHolderZ]) holder3d();
    translate([backHolderX, backHolderY2, backHolderZ]) holder3d();

    translate([leftHolderX,  leftHolderY,  leftHolderZ])  rotate([0, 0, 90]) holder3d();
    translate([leftHolderX2, leftHolderY,  leftHolderZ])  rotate([0, 0, 90]) holder3d();
    translate([rightHolderX, rightHolderY, rightHolderZ]) rotate([0, 0, -90]) holder3d();
    translate([rightHolderX2,rightHolderY, rightHolderZ]) rotate([0, 0, -90]) holder3d();


}

module cutPins() {
    translate([wallThickness,wallThickness, basePlaneThickness + standoffHeight + pcbThickness + 0.3 ])
    cube([pcbLength,pcbWidth,10]);
}

//  *** Snap Joins ***
//snapJoins   =   
//[
//    [pcbLength/2 , 5,           yappLeft, yappRight]
//]; 


pcbStands =
[
      [ 2.56, 3.44, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 1 ],
      [ 2.56,25.59, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 1 ],
      [61.91, 3.44, standoffHeight, -1, standoffDiameter+1, 0,   standoffHoleSlack, 1, yappBaseOnly ],
      [61.91,25.59, standoffHeight, -1, standoffDiameter+1, 0,   standoffHoleSlack, 1, yappBaseOnly ],
      [49.97,23.00, standoffHeight, -1, 3.5, 2.25, standoffHoleSlack, 1, yappLidOnly ],
];

//pcbStands = 
//[
//    [ 3.5,  3.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 0 ],
//    [ 3.5, 52.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, rfr ],
//    [61.5,  3.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, 0 ],
//    [61.5, 52.5, standoffHeight, -1, standoffDiameter, standoffPinDiameter, standoffHoleSlack, rfr ]
//];
//
//cutoutsFront =
//[
//    [  0.9, 0.5, 15.5, 17.5, 2, yappRectangle, yappCoordPCB, yappOrigin ], 
//    [ 19.0, 0.5, 15.5, 17.5, 2, yappRectangle, yappCoordPCB, yappOrigin ], 
//    [ 37.2, 0.5, 17.0, 15.0, 2, yappRectangle, yappCoordPCB, yappOrigin ] 
//];
//
//cutoutsLeft =
//[
//    [11.2, 3.1, 12.5, 7.5, 1.0, yappRoundedRect, yappCoordPCB, yappCenter ], 
//    [32.0, 4.5, 16.5, 7.8, 2.0, yappRectangle,   yappCoordPCB, yappCenter ], 
//    [54.1, 3.2,  2.0, 2.0, 4.2, yappCircle,      yappCoordPCB, yappCenter ] 
//];
//
//cutoutsBack =
//[
//    [ 12.0,  3.0,  2,   2, 2.5, yappCircle,    yappCoordPCB, yappCenter ],
//    [ 28.2, -0.8, 13, 3.5, 2.5, yappRectangle, yappCoordPCB, yappCenter ]
//];
//
//
//cutoutsLid = [
//    [ 7.0, 7.0, 68.8, 35, 0, yappRectangle, yappCoordPCB, yappOrigin,
//    [maskHoneycomb, 0, 1, 30] ],
//    [ 7.0, 49.2, GPIOlen, GPIOwid, 0, yappRectangle, yappCoordPCB, yappOrigin ] // comment this line to remove GPIO access
//];
//
//cutoutsBase = [
//    [12, 12, 60, 32, 0, yappRectangle, yappCoordPCB, yappOrigin, [maskHoneycomb, 0, 1, 0] ],
//    [ 7, 7,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ],
//    [78, 7,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ],
//    [78,50,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ],
//    [ 7,50,   1,  1, 5, yappCircle, 1,   yappCoordPCB, yappCenter ]
//];
//
// 
//---- This is where the magic happens ----
//!holder2d();

cutoutsLeft =
[
    [50.10, -4.00, 8.55, 4.00, 2.0, yappRectangle, yappCoordPCB, yappOrigin ], // switch
    [47.10, -7.00,14.55,10.50, 2.0, yappRectangle, 2.0, yappCoordPCB, yappOrigin ], // switch
    [40.33, -2.50, 4.90, 2.50, 2.0, yappRectangle, yappCoordPCB, yappOrigin ], // reset    
];

cutoutsFront =
[
    [ 3.00, 0.5, 10.00, 4.50, 1.0, yappRoundedRect, yappCoordPCB, yappOrigin ], // USB
    [14.00, 0.5, 12.00, 4.50, 2.0, yappRectangle,   yappCoordPCB, yappOrigin ], // SD card
    
];

cutoutsLid =
[
    [46.00, 0.10, 0.00, 0.00,     1.8, yappCircle,      yappCoordPCB, yappOrigin ], // LED bottom
    [55.50,25.40, 6.00, 2.00,     0.5, yappRoundedRect, yappCoordPCB, yappOrigin ], // LED top
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

difference() {
    YAPPgenerate();
    cutPins();
}
battery();
antennaHolder();