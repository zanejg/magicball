

$fn=30;



RAD = 15/2;
MAIN_LEN = 115;
TOT_WIDTH = 74.5;
RING_HT=10;

ARM_THICKNESS = 5;
FRAME_WD = 4;

//=######################################################################
//SCREW STANCHIONS

SCREWHOLE_WD = 75;
SCREWHOLE_LEN = 87;
screw_x = SCREWHOLE_WD/2;
screw_y = SCREWHOLE_LEN/2;
STANCHION_RAD = 9/2;
STANCHION_HT = 20;

sh_coords = [
    [screw_x, screw_y],
    [-screw_x, screw_y],
    [-screw_x, -screw_y],
    [screw_x, -screw_y],
];



module stanchion(){
    difference(){
        cylinder(h=STANCHION_HT,r=STANCHION_RAD,center=true);
        cylinder(h=STANCHION_HT+3,r=4.2/2,center=true);

    }
}

for(coords = sh_coords){
    translate([coords[0],coords[1],RAD+STANCHION_HT/2]){
        stanchion();
    }
}

translate([0,0,RAD+(ARM_THICKNESS/2)])
difference(){
    cube([SCREWHOLE_WD+STANCHION_RAD,
            SCREWHOLE_LEN+STANCHION_RAD,
            ARM_THICKNESS],
            center=true);

    cube([SCREWHOLE_WD+STANCHION_RAD-FRAME_WD,
            SCREWHOLE_LEN+STANCHION_RAD-FRAME_WD,
            ARM_THICKNESS+2],
            center=true);
}


translate([0,screw_y+7,RAD+(ARM_THICKNESS/2)-1]){
    difference(){
        cube([15,10,3],center=true);
        cylinder(h=5,r=3/2,center=true);
    }
}

translate([0,-screw_y-7,RAD+(ARM_THICKNESS/2)-1]){
    difference(){
        cube([15,10,3],center=true);
        cylinder(h=5,r=3/2,center=true);
    }
}


//***********************************************************************






//################################################################
// RING ARMS
arm_len = TOT_WIDTH -(RAD);


translate([0, RING_HT/2 - 4, RAD+(ARM_THICKNESS/2)]){
    cube([20,MAIN_LEN,ARM_THICKNESS],center=true);
}

translate([0, MAIN_LEN/2 , RAD+(ARM_THICKNESS/2)]){
    cube([arm_len,RING_HT,ARM_THICKNESS],center=true);
}


translate([0, -MAIN_LEN/2 , RAD+(ARM_THICKNESS/2)]){
    cube([arm_len,RING_HT,ARM_THICKNESS],center=true);
}

// ##############################
// join arms to stanchions for strength
translate([-(SCREWHOLE_WD/2)+5,MAIN_LEN/2 - RING_HT*(3/4) ,RAD+(ARM_THICKNESS/2)]){
    cube([FRAME_WD/2,RING_HT,ARM_THICKNESS],center=true);
}

translate([(SCREWHOLE_WD/2)-5,-MAIN_LEN/2 + RING_HT*(3/4) ,RAD+(ARM_THICKNESS/2)]){
    cube([FRAME_WD/2,RING_HT,ARM_THICKNESS],center=true);
}

translate([(SCREWHOLE_WD/2)-5,MAIN_LEN/2 - RING_HT*(3/4) ,RAD+(ARM_THICKNESS/2)]){
    cube([FRAME_WD/2,RING_HT,ARM_THICKNESS],center=true);
}

translate([-(SCREWHOLE_WD/2)+5,-MAIN_LEN/2 + RING_HT*(3/4) ,RAD+(ARM_THICKNESS/2)]){
    cube([FRAME_WD/2,RING_HT,ARM_THICKNESS],center=true);
}


