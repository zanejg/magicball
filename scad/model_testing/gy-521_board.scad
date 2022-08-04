include <strip_connector_male.scad>
include <screw_connector.scad>

$fn=20;
WIDTH = 15.9;
LENGTH = 21.0;
DEPTH = 1.5;

PCB_MNT_HOLE_RAD = 3/2;

// [1.4+PCB_MNT_HOLE_RAD,4.4+PCB_MNT_HOLE_RAD],
// [19.3 + PCB_MNT_HOLE_RAD,4.4+PCB_MNT_HOLE_RAD],

hole_pts = [
    [PCB_MNT_HOLE_RAD+1,PCB_MNT_HOLE_RAD+1],
    [PCB_MNT_HOLE_RAD+1,PCB_MNT_HOLE_RAD+16.5],
];

difference(){
    // THE ACTUAL PCB
    cube([WIDTH,LENGTH,DEPTH]);

    for(pt = hole_pts){
        translate([pt[0],pt[1],0]){
            cylinder(r=PCB_MNT_HOLE_RAD,h=5,center=true);
        }
    }
}


translate([WIDTH-1,1.5,3.0]){
    rotate(180,[0,1,0]){
        rotate(90,[0,0,1]){
            multi_male_connector(4);
        }
    }
}
