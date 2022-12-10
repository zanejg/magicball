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

module screw_plate(){
    difference(){
        union(){
            cube([FRAME_PLATE_LN, cs_plate_wid, FRAME_PLATE_TN]);
            translate([0,cos(90-FACET_ANGLE) * FRAME_PLATE_TN,tan(90-FACET_ANGLE)*FRAME_PLATE_TN]){
                rotate([180 - FACET_ANGLE,0,0]){
                    difference(){
                        cube([FRAME_PLATE_LN, cs_plate_wid, FRAME_PLATE_TN]);
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

NOODLE_RD =2.5;
CURVE_RD=20;
NOODLE_ANG=100;
KNOB_RD=4;
RIB_RD = 0.5;

noodle_y_offset = CURVE_RD - 
                    (cs_plate_wid * sin(90 - FACET_ANGLE))+
                    NOODLE_RD + 0.18;

//translate([NOODLE_RD,16.2,22.5]){


noodle_xposis = [
    NOODLE_RD,
    NOODLE_RD + 10,
    FRAME_PLATE_LN/2 - 10,
    FRAME_PLATE_LN/2 + 10,
    FRAME_PLATE_LN - NOODLE_RD -10,
    FRAME_PLATE_LN - NOODLE_RD
];

for(posi = noodle_xposis){
    translate([posi,
                noodle_y_offset,
                CURVE_RD + KNOB_RD -0.6]){
        // making it symmetrical about the two sides
        rotate([-86 ,0,0]){
            rotate([0,90,0]){
                union(){
                    // NOODLE
                    rotate_extrude(angle=NOODLE_ANG){
                        translate([CURVE_RD,0,0]){ 
                            circle(r=NOODLE_RD);
                        }
                    }
                    // KNOBS
                    translate([CURVE_RD,0,0]){
                        sphere(r = KNOB_RD);
                    }
                    rotate([0,0,NOODLE_ANG]){
                        translate([CURVE_RD,0,0]){
                            sphere(r = KNOB_RD);
                        }
                    }
                    // RIBS
                    for(ang = [0:-10:-(NOODLE_ANG -20)]){
                        rotate([0,0,ang]){ 
                            translate([0,CURVE_RD,0]){ 
                                rotate([0,90,0]){
                                    rotate_extrude(angle=360){
                                        translate([NOODLE_RD,0,0]){
                                            circle(r = RIB_RD);
                                        } 
                                    }
                                }
                            }
                        }
                    }
                } 
            }
        }
    }
}


screw_plate();
