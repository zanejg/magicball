
$fn=50;
LEG_WD = 15;
LEG_LN  = 100;
LEG_TN = 2;
HOLE_DISTANCE = 121;
FRAME_SZ = 50;
BRACE_LN=15;



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


module brace(){
    // Filleted buttresses

    difference(){
        cube([BRACE_LN,LEG_TN,BRACE_LN],center=true);

        translate([-BRACE_LN/2-LEG_TN,0,BRACE_LN/2]){
            rotate(90,[1,0,0]){
                cylinder(h=LEG_TN*2,r=(BRACE_LN),center=true);
            }
        }
    }

}


module leg(leg_len){
    
    difference(){
        // main body of leg
        translate([0,-LEG_WD/2,0]){
            cube([leg_len ,LEG_WD,LEG_TN]);
        }
        // holes for cable tie
        translate([leg_len -(LEG_TN*3),0,LEG_TN/2]){
            cube([3,5,LEG_TN*2],center=true);
        }
        translate([leg_len -(LEG_TN*5),0,LEG_TN/2]){
            cube([3,5,LEG_TN*2],center=true);
        }
    }

    // longitudinal ribs
    translate([0,-LEG_WD/3,0]){
        cube([leg_len ,LEG_TN,LEG_TN*2]);
    }
    translate([0,LEG_WD/3-LEG_TN,0]){
        cube([leg_len ,LEG_TN,LEG_TN*2]);
    }
    
    // frame on the end to put the lights
    translate([leg_len ,0,FRAME_SZ/2]){
        rotate(90,[0,1,0]){
            light_mount_frame();
        }
    }

    // braces for strength
    translate([leg_len -(BRACE_LN/2),FRAME_SZ/6,BRACE_LN/2]){
        brace();
    }
    translate([leg_len -(BRACE_LN/2),-FRAME_SZ/6,BRACE_LN/2]){
        brace();
    }

    



}

module hole_standoff(){
        cylinder(h=2*LEG_TN,r=5);
}

module hole(){
    cylinder(h=2.1*LEG_TN,r=3.2/2);
}

difference(){
    // holes for screws
    xval = ((HOLE_DISTANCE/2)*sin(30))/cos(30);
    
    union(){
        leg(LEG_LN*(2/3));
        rotate(120,[0,0,1]){
            leg(LEG_LN);
        }

        rotate(240,[0,0,1]){
            leg(LEG_LN);
        }
    
        translate([-xval,HOLE_DISTANCE/2,0]){
            hole_standoff();
        }
        translate([-xval,-HOLE_DISTANCE/2,0]){
            hole_standoff();
        }
    }
    translate([-xval,HOLE_DISTANCE/2,-0.1]){
        hole();
    }
    translate([-xval,-HOLE_DISTANCE/2,-0.1]){
        hole();
    }
}
translate([0,-LEG_WD/2,0])
cube([LEG_WD/2,LEG_WD,7]);

