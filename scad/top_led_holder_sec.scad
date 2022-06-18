include <Round-Anything/polyround.scad>

$fn=60;
MAIN_TN=2.5;
BRD_WD=90;
BRD_TN=2.4;
PYLON_HT=20;
CLAMP_LN=10;
FILLET=6;
LED_FOOT_WD=20;
FLAT_WD=10;

pylon_points = [
    [0,0,0],
    [-CLAMP_LN-MAIN_TN, 0,0],
    [-CLAMP_LN-MAIN_TN, BRD_TN+(2*MAIN_TN), 0],
    [(BRD_WD/2)-CLAMP_LN-MAIN_TN, BRD_TN+(2*MAIN_TN), FILLET],
    [(BRD_WD/2)-CLAMP_LN-MAIN_TN, BRD_TN+(2*MAIN_TN)+PYLON_HT, FILLET],
    // [(BRD_WD/2)-CLAMP_LN-MAIN_TN-(LED_FOOT_WD/2), BRD_TN+(2*MAIN_TN)+PYLON_HT,0],
    // [(BRD_WD/2)-CLAMP_LN-MAIN_TN-(LED_FOOT_WD/2), BRD_TN+(3*MAIN_TN)+PYLON_HT,0],
    // [(BRD_WD/2)-CLAMP_LN+(LED_FOOT_WD/2), BRD_TN+(3*MAIN_TN)+PYLON_HT,0],
    // [(BRD_WD/2)-CLAMP_LN+(LED_FOOT_WD/2), BRD_TN+(2*MAIN_TN)+PYLON_HT,0],
    [(BRD_WD/2)-CLAMP_LN, BRD_TN+(2*MAIN_TN)+PYLON_HT, FILLET],
    [(BRD_WD/2)-CLAMP_LN, BRD_TN+(MAIN_TN),0],
    [-CLAMP_LN, BRD_TN+MAIN_TN,0],
    [-CLAMP_LN,MAIN_TN,0],
    [0,MAIN_TN,0],
];


difference(){
    union(){
        linear_extrude(height=FLAT_WD){
            polygon(polyRound(pylon_points,$fn));
        }
        translate([(BRD_WD/2)-CLAMP_LN-(2*MAIN_TN),PYLON_HT/2+(2*MAIN_TN)+BRD_TN,MAIN_TN/2]){
            cube([2*MAIN_TN,PYLON_HT,MAIN_TN],center=true);
        }

        translate([(BRD_WD/2)-CLAMP_LN-(MAIN_TN*2), (3*MAIN_TN)+BRD_TN+FILLET, FLAT_WD/2]){
            cube([3*MAIN_TN,8,FLAT_WD],center=true);
        }
    }
    translate([(BRD_WD/2)-CLAMP_LN-(MAIN_TN*2),(3*MAIN_TN)+BRD_TN+FILLET,FLAT_WD/2]){
        rotate(90,[0,1,0]){
            cylinder(h=12,r=3.2/2,center=true);
        }
    }
    translate([(BRD_WD/2)-CLAMP_LN-(MAIN_TN*3.1),(3*MAIN_TN)+BRD_TN+FILLET,FLAT_WD/2]){
        rotate(90,[0,1,0]){
            cylinder(h=6,r1=6,r2=0.1,center=true);
        }
    }


}