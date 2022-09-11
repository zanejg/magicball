
$fn=30;



RAD = 15/2;
MAIN_LEN = 115;
TOT_WIDTH = 74.5;
RING_HT=10;

ARM_THICKNESS = 8;
FRAME_WD = 8;

//=######################################################################
//SCREW STANCHIONS

SCREWHOLE_WD = 75;
SCREWHOLE_LEN = 87;
screw_x = SCREWHOLE_WD/2;
screw_y = SCREWHOLE_LEN/2;
STANCHION_RAD = 9/2;
STANCHION_HT = 20;
SCREWHOLE_RAD = 1.5/2;

sh_coords = [
    [screw_x, screw_y],
    [-screw_x, screw_y],
    [-screw_x, -screw_y],
    [screw_x, -screw_y],
];

RPI_HOLE_WD = 58;
RPI_HOLE_LN = 23;
rpi_screwhole_x = RPI_HOLE_WD/2;
rpi_screwhole_y = RPI_HOLE_LN/2;

rpi_coords = [
    [rpi_screwhole_x, rpi_screwhole_y],
    [-rpi_screwhole_x, rpi_screwhole_y],
    [-rpi_screwhole_x, -rpi_screwhole_y],
    [rpi_screwhole_x, -rpi_screwhole_y],
];


module stanchion(ht){
    difference(){
        cylinder(h=ht,r=STANCHION_RAD,center=true);
        cylinder(h=ht+3,r=SCREWHOLE_RAD,center=true);

    }
}

module PCB_mount(ht, the_coords){
    translate([0,0,ARM_THICKNESS/2]){
        // the stanchions
        for(coords = the_coords){
            translate([coords[0],coords[1],ht/2-ARM_THICKNESS/2]){ //RAD+ht/2]){
                stanchion(ht);
            }
        }

        translate([0,0,0]){//RAD+(ARM_THICKNESS/2)])
            difference(){
                cube([(the_coords[0][0] * 2) + STANCHION_RAD,
                        (the_coords[0][1] * 2) + STANCHION_RAD,
                        ARM_THICKNESS],
                        center=true);

                cube([(the_coords[0][0] * 2) + STANCHION_RAD - FRAME_WD,
                        (the_coords[0][1] * 2) + STANCHION_RAD - FRAME_WD,
                        ARM_THICKNESS+2],
                        center=true);
            }
        }
    }


    // translate([0,screw_y+7,RAD+(ARM_THICKNESS/2)-1]){
    //     difference(){
    //         cube([15,10,3],center=true);
    //         cylinder(h=5,r=3/2,center=true);
    //     }
    // }

    // translate([0,-screw_y-7,RAD+(ARM_THICKNESS/2)-1]){
    //     difference(){
    //         cube([15,10,3],center=true);
    //         cylinder(h=5,r=3/2,center=true);
    //     }
    // }
}