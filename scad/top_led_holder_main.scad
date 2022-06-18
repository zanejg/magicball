include <Round-Anything/polyround.scad>

$fn=60;

MAIN_TN=2.5;
BRD_WD=90;
BRD_TN=2.4;
PYLON_HT=80;
CLAMP_LN=10;
FILLET=6;
LED_FOOT_WD=20;
FLAT_WD=10;

FRAME_SZ = 50;
BRACE_LN=15;
LEG_TN=2;



//############################################################
// light mount frames
module light_mount_frame(){
    // 2 uprights
    translate([0,FRAME_SZ/2-LEG_TN/2,0]){
        cube([FRAME_SZ,LEG_TN,LEG_TN*2],center=true);
        
    }
    translate([0,-FRAME_SZ/2+LEG_TN/2,0]){
        cube([FRAME_SZ,LEG_TN,LEG_TN*2],center=true);
    
    }

    // diagonals
    rotate(-45,[0,0,1]){
        cube([FRAME_SZ*(sqrt(2))-LEG_TN,LEG_TN,LEG_TN*2],center=true);
    }

    rotate(45,[0,0,1]){
        translate([0,0,0]){
            cube([FRAME_SZ*(sqrt(2))-LEG_TN,LEG_TN,LEG_TN*2],center=true);
        }
    }
    
    // base
    translate([FRAME_SZ/2-LEG_TN/2,0,0]){
        rotate(90,[0,0,1]){
            cube([FRAME_SZ,LEG_TN,LEG_TN*2],center=true);
        }
    }

    // 3/4 uprights
    translate([FRAME_SZ/2 - (2/6*FRAME_SZ),FRAME_SZ/6,0]){
        cube([FRAME_SZ*2/3,LEG_TN,LEG_TN*2],center=true);
    }
    translate([FRAME_SZ/2 - (2/6*FRAME_SZ),-FRAME_SZ/6,0]){
        cube([FRAME_SZ*2/3,LEG_TN,LEG_TN*2],center=true);
    }

    // center upright with hole
    translate([-FRAME_SZ/8,0,0]){
        cube([FRAME_SZ/4,LEG_TN,LEG_TN*2],center=true);
    }

    center_needle_points=[
        [-FRAME_SZ/8,0],
        [-FRAME_SZ/8-(LEG_TN*2),-(LEG_TN*2)],
        [-FRAME_SZ/2,-(LEG_TN*2)],
        [-FRAME_SZ/2,(LEG_TN*2)],
        [-FRAME_SZ/8-(LEG_TN*2),(LEG_TN*2)]
    ];
    difference(){
        translate([0,0,-LEG_TN]){
            linear_extrude(height=(LEG_TN*2)){
                polygon(center_needle_points);
            }
        }
        translate([-(FRAME_SZ/2-LEG_TN*1.5),0,0]){
            cube([3,5,LEG_TN*3],center=true);
        }
    }
    // struts for upright
    translate([-FRAME_SZ/6,-FRAME_SZ/10,0]){
        rotate(45,[0,0,1]){
            cube([LEG_TN,FRAME_SZ/8,LEG_TN],center=true);
        }
    }
    translate([-FRAME_SZ/6,FRAME_SZ/10,0]){
        rotate(-45,[0,0,1]){
            cube([LEG_TN,FRAME_SZ/8,LEG_TN],center=true);
        }
    }



}





pylon_points = [
    [0,0,0],
    [-CLAMP_LN-MAIN_TN, 0,0],
    [-CLAMP_LN-MAIN_TN, BRD_TN+(2*MAIN_TN), 0],
    [(BRD_WD/2)-CLAMP_LN-MAIN_TN, BRD_TN+(2*MAIN_TN), FILLET],
    [(BRD_WD/2)-CLAMP_LN-MAIN_TN, BRD_TN+(2*MAIN_TN)+PYLON_HT, FILLET],
    [(BRD_WD/2)-CLAMP_LN-MAIN_TN-(LED_FOOT_WD/2), BRD_TN+(2*MAIN_TN)+PYLON_HT,0],
    [(BRD_WD/2)-CLAMP_LN-MAIN_TN-(LED_FOOT_WD/2), BRD_TN+(3*MAIN_TN)+PYLON_HT,0],
    [(BRD_WD/2)-CLAMP_LN+(LED_FOOT_WD/2), BRD_TN+(3*MAIN_TN)+PYLON_HT,0],
    [(BRD_WD/2)-CLAMP_LN+(LED_FOOT_WD/2), BRD_TN+(2*MAIN_TN)+PYLON_HT,0],
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
    #translate([(BRD_WD/2)-CLAMP_LN-(MAIN_TN*2),(3*MAIN_TN)+BRD_TN+FILLET,FLAT_WD/2]){
        rotate(90,[0,1,0]){
            cylinder(h=12,r=4.2/2,center=true);
        }
    }
}
translate([(BRD_WD/2)-CLAMP_LN,BRD_TN+(3*MAIN_TN)+PYLON_HT,FRAME_SZ/2]){
    rotate(-90,[1,0,0]){
        rotate(90,[0,0,1]){
            light_mount_frame();
        }
    }
}

