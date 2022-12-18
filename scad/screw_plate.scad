$fn=40;
OUTER_WALL_TN = 2;
WID = 17;
FACET_ANGLE = 70.5288;
FRAME_PLATE_TN = 3;
FRAME_PLATE_LN = 100;

UNDER_NOODLE_SZ = 6;

CS_ANGLE_RATIO = (5.6 -3) / 1.6;
CS_MIN_RAD = 2.8/2;
CS_HT = 2;
cs_max_rad = CS_HT * CS_ANGLE_RATIO;
cs_plate_wid = WID * 1.1;

module m3_countersink(){
    cylinder(h=CS_HT, r1 = CS_MIN_RAD,r2=cs_max_rad );
}


module corner_trimmer(){
    difference() {
        cube([5,5,FRAME_PLATE_TN*1.1],center=true);
        translate([2.5,2.5,-2]){
            cylinder(r=4,h=FRAME_PLATE_TN*1.5);
        }
    }
}
//corner_trimmer();

module screw_plate(){
    difference(){
        union(){
            cube([FRAME_PLATE_LN, cs_plate_wid, FRAME_PLATE_TN]);
            

            translate([0,cos(90-FACET_ANGLE) * FRAME_PLATE_TN,tan(90-FACET_ANGLE)*FRAME_PLATE_TN]){
                rotate([180 - FACET_ANGLE,0,0]){
                    difference(){
                        union(){
                            cube([FRAME_PLATE_LN, cs_plate_wid, FRAME_PLATE_TN]);
                            
                        }
                        // screwholes on upright side
                        translate([FRAME_PLATE_LN-(FRAME_PLATE_LN/2 - 25),10 + OUTER_WALL_TN * 0.75,-1]){
                            cylinder(h=6, r=3/2);
                            translate([0,0,2.5]){
                                rotate([180,0,0]){
                                    m3_countersink();
                                }
                            }
                        }
                        translate([(FRAME_PLATE_LN/2 - 25),10 + 0.75* OUTER_WALL_TN,-1]){
                            cylinder(h=6, r=3/2);
                            translate([0,0,2.5]){
                                rotate([180,0,0]){
                                    m3_countersink();
                                }
                            }
                        }
                        // trim the corners
                        translate([1.5,cs_plate_wid-1.5,1.5]){ 
                            rotate([0,0,270]){
                                corner_trimmer();
                            }
                        }
                        // trim the corners
                        translate([FRAME_PLATE_LN-1.5,cs_plate_wid-1.5,1.5]){ 
                            rotate([0,0,180]){
                                corner_trimmer();
                            }
                        }

                    }
                }
            }
        }
        // screwholes on flat side
        translate([FRAME_PLATE_LN-(FRAME_PLATE_LN/2 - 25),10 + 0.75* OUTER_WALL_TN,-1]){
            cylinder(h=6, r=3/2);
            translate([0,0,2.5]){
                m3_countersink();
            }
        }
        translate([(FRAME_PLATE_LN/2 - 25),10 + 0.75* OUTER_WALL_TN,-1]){
            cylinder(h=6, r=3/2);
            translate([0,0,2.5]){
                m3_countersink();
            }
        }
        // trim the corners
        translate([1.5,cs_plate_wid - 1.5,1.5]){ 
            rotate([0,0,-90]){
                corner_trimmer();
            }
        }
        // trim the corners
        translate([FRAME_PLATE_LN-1.5,cs_plate_wid - 1.5,1.5]){ 
            rotate([0,0,180]){
                corner_trimmer();
            }
        }
    }

    translate([0,2,2.5]){ 
        hull(){
            cube([FRAME_PLATE_LN, UNDER_NOODLE_SZ,1]);
            rotate([180 - FACET_ANGLE,0,0]){
                        difference(){
                            cube([FRAME_PLATE_LN, UNDER_NOODLE_SZ, 1]);
                        }
            }
        }
    }
}
screw_plate();


// // veins
// translate([FRAME_PLATE_LN -5 ,cs_plate_wid -5 ,FRAME_PLATE_TN-1]){ 
//     rotate([90,0,0]){
//         rotate_extrude(angle=90) {
//             translate([2,0,0]){
//                 circle(r = 1.5);
//             } 
//         }
//     }
// }

// translate([FRAME_PLATE_LN -5 ,cs_plate_wid -20 ,FRAME_PLATE_TN + 1]){ 
//     rotate([0,0,90]){
//         rotate_extrude(angle=45) {
//             translate([15,0,0]){
//                 circle(r = 1.5);
//             } 
//         }
//     }
// }

// translate([FRAME_PLATE_LN -28 ,cs_plate_wid - 3  ,FRAME_PLATE_TN + 6]){ 
//     rotate([-20,0,-105]){
//         rotate_extrude(angle=80) {
//             translate([15,0,0]){
//                 circle(r = 1.5);
//             } 
//         }
//     }
// }


// translate([FRAME_PLATE_LN/2 + 4.8 ,2*cs_plate_wid +36  ,-5]){ 
//     rotate([10,-5,-124]){
//         rotate_extrude(angle=45) {
//             translate([75,0,0]){
//                 circle(r = 1.5);
//             } 
//         }
//     }
// }



