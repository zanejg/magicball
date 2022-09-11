//include <MI_10Ah_powerbank_holder.scad>
include <PCB_assy_mnt.scad>
include <model_testing/Al_hex_frame.scad>
include <model_testing/belkin_power_bank.scad>

// the idea here is to provide a framework to support the electronics
// It is to be printed in TPU to provide some resilience to being dropped

FACET_ANGLE = 70.5288;
leg_angle = 180 - FACET_ANGLE;
angle_from_flat = leg_angle - 90;

// we will start with 4 cylinders arranged tetragonally
LEG_LEN = 100;
LEG_RD = 5;
RAD = 15/2;
MAIN_LEN = 115;
TOT_WIDTH = 74.5;

RING_HT=15;
RING_TN = 2;
SCREW_BLOCK_WD = 8;

ARM_THICKNESS = 5;
cyl_offset = (TOT_WIDTH - (2*RAD) )/2;

rt3 = sqrt(3);



module tet_leg(){
    cylinder(h=LEG_LEN,r=LEG_RD);
    translate([0,0,LEG_LEN]){
        rotate(30,[0,0,1]){
            cylinder(h=3,r=20,$fn=3);
        }
    }


}

module holding_ring(ring_ht){

    difference(){
        hull(){
            translate([cyl_offset,0,0]){
                cylinder(ring_ht,RAD+RING_TN,RAD+RING_TN,center=true);
            }
            translate([-cyl_offset,0,0]){
                cylinder(ring_ht,RAD+RING_TN,RAD+RING_TN,center=true);
            }

        }

        hull(){
            translate([cyl_offset,0,0]){
                cylinder(MAIN_LEN,RAD,RAD,center=true);
            }
            translate([-cyl_offset,0,0]){
                cylinder(MAIN_LEN,RAD,RAD,center=true);
            }

        }
        
    }
}

module batt_ring_assy(ht){
    difference(){
        union(){
            // ring
            holding_ring(ht);
            // stanchions
            translate([15, RAD+(SCREW_BLOCK_WD/2), 0]){
                cube([SCREW_BLOCK_WD,SCREW_BLOCK_WD,ht],center=true);
            }
            translate([-15, RAD+(SCREW_BLOCK_WD/2), 0]){
                cube([SCREW_BLOCK_WD,SCREW_BLOCK_WD,ht],center=true);
            }
        }
        // screwhole
        // translate([cyl_offset-RAD,RAD+(SCREW_BLOCK_WD/2),3]){
        //     rotate(90,[1,0,0]){
        //         cylinder(h=8,r=4.2/2,center=true);
        //     }
        // }
    }
}

TOP_SCREW_MNT_HT = 5;
SCREW_HEAD_RAD = 5.5/2;
SCREW_HEAD_HT = 2.2;
SCREW_RAD = 3.1/2;
HORIZ_FLAP_LN =30;

module top_screw_mount(angle){
    rotate(angle,[0,0,1]){
        difference(){
            cylinder(h=TOP_SCREW_MNT_HT, r=STANCHION_RAD);
            // counter sinking
            translate([0,0,-0.1]){
                cylinder(h=SCREW_HEAD_HT * 1.1, 
                        r1=SCREW_HEAD_RAD * 1.1, 
                        r2= SCREW_RAD);
            }
            // thru hole
            translate([0,0,0.1]){
                cylinder(h=TOP_SCREW_MNT_HT, 
                        r=SCREW_RAD);
            }
        }
        difference(){
            translate([-HORIZ_FLAP_LN/2,0,TOP_SCREW_MNT_HT/2]){
                cube([HORIZ_FLAP_LN,STANCHION_RAD * 2, TOP_SCREW_MNT_HT],center=true);
            }
            translate([0,0,-0.1]){
                cylinder(h=TOP_SCREW_MNT_HT * 1.1, r=STANCHION_RAD * 0.9);
            }
        }
    }
}
// top_screw_mount(0);

// legs
module tet_legs(){
    union(){
        rotate(60,[0,0,1]){
            rotate(180,[1,0,0]){
                tet_leg();
            }
        }


        rotate(FACET_ANGLE, [1,0,0]){
            tet_leg();
        }

        rotate(120, [0,0,1]){
            rotate(FACET_ANGLE, [1,0,0]){
                tet_leg();
            }
        }

        rotate(-120, [0,0,1]){
            rotate(FACET_ANGLE, [1,0,0]){
                tet_leg();
            }
        }
    }
}
tet_legs();
//#############################################################
// battery pack
module batt_pack(){
    RAD = 15/2;
    MAIN_LEN = 147;
    TOT_WIDTH = 75;

    cyl_offset = (TOT_WIDTH - (2*RAD) )/2;
    hull(){
        translate([cyl_offset,0,0]){
            cylinder(MAIN_LEN,RAD,RAD,center=true);
        }
        translate([-cyl_offset,0,0]){
            cylinder(MAIN_LEN,RAD,RAD,center=true);
        }

    }
}



// ##############################################################################
//### BATTERIES and holder
//##############################################################################
rotate(90,[1,0,0]){
    translate([-side_dist/2,0,-BIG_RAD_LEN/2]){
        belkin_power_bank();
    }
}

// translate([0,0,10 + TRIANGLE_HT/2]){
//     // battery pack NOT PRINTED
//     color("darkslategray",1.0){
//         translate([0,0,(sin(90-FACET_ANGLE)*LEG_LEN)- 20 + TRIANGLE_HT]){
//             rotate(90,[1,0,0]){
//                 batt_pack();
//             }
//         }
//     }


//     //################################################################
//     // rings to hold batt pack
//     // one along central leg
//     translate([0,-60,13 + TRIANGLE_HT]){
//         rotate(90,[1,0,0]){
//             color("blue",1.0){
//                 batt_ring_assy(14);
//             }
//         }
//     }

//     // one across triangle span
//     translate([0,42,13 + TRIANGLE_HT]){
//         rotate(90,[1,0,0]){
//             color("blue",1.0){
//                 batt_ring_assy(14);
//             }
//         }
//     }
// }

//##################################################################################
//########################################################################################



// base triangle
triangle_rad = cos(angle_from_flat)*LEG_LEN*0.92;
TRIANGLE_SIDE_TN = 10;
TRIANGLE_HT = 10;
//triangle_rad = LEG_LEN/rt3;
triangle_z_place = sin(angle_from_flat)*LEG_LEN +TRIANGLE_HT * 3/2;
rotate(30,[0,0,1]){
    translate([0,0, triangle_z_place]){
        difference(){
            cylinder(h=TRIANGLE_HT, r=triangle_rad, $fn=3);
            translate([0,0,-0.1]){
                cylinder(h=TRIANGLE_HT*1.2, r=triangle_rad-(TRIANGLE_SIDE_TN * 2), $fn=3);
            }
        }
    }
}


// OLD PCB HOLDER stuff
union (){
    // //######################################################################
    // // struts to hold PCB mount
    // translate([0,0,TRIANGLE_HT]){
    //     difference(){
    //         union(){
    //             // parallel with triangle side
    //             translate([TOT_WIDTH/2 + 20*cos(30) - TRIANGLE_HT * 2/3, 
    //                         triangle_rad * sin(30) - TRIANGLE_HT/2, 
    //                         10]){
    //                 rotate(30,[0,1,0]){
    //                     cube([TRIANGLE_HT,TRIANGLE_HT,50],center=true);
    //                 }
    //             }

    //             translate([-1 * (TOT_WIDTH/2 + 20*cos(30) - TRIANGLE_HT * 2/3), 
    //                         triangle_rad * sin(30) - TRIANGLE_HT/2, 
    //                         10]){
    //                 rotate(-30,[0,1,0]){
    //                     cube([TRIANGLE_HT,TRIANGLE_HT,50],center=true);
    //                 }
    //             }

    //             // struts at apex end
    //             translate([-TOT_WIDTH/2 -7,
    //                         -triangle_rad/2 +20,
    //                         13]){
    //                 rotate(-40,[1,0,0]){
    //                     rotate(-15,[0,1,0]){
    //                         cube([TRIANGLE_HT,TRIANGLE_HT,65],center=true);
    //                     }
    //                 }
    //             }
    //             translate([TOT_WIDTH/2 + 7,
    //                         -triangle_rad/2 +20,
    //                         13]){
    //                 rotate(-40,[1,0,0]){
    //                     rotate(15,[0,1,0]){
    //                         cube([TRIANGLE_HT,TRIANGLE_HT,65],center=true);
    //                     }
    //                 }
    //             }
    //             // extra material for strength at the base
    //             translate([-TOT_WIDTH/2 -7 - (sin(30)*15),
    //                         -triangle_rad/2 +20 + (cos(30)*15),
    //                         triangle_z_place - TRIANGLE_HT/2]){
    //                 rotate(-60,[0,0,1]){
    //                     cube([30, TRIANGLE_HT, TRIANGLE_HT],center=true);
    //                 }
    //             }

    //             translate([TOT_WIDTH/2 + 7 + (sin(30)*15),
    //                         -triangle_rad/2 +20 + (cos(30)*15),
    //                         triangle_z_place - TRIANGLE_HT/2]){
    //                 rotate(60,[0,0,1]){
    //                     cube([30, TRIANGLE_HT, TRIANGLE_HT],center=true);
    //                 }
    //             }
    //         }
    //         // shave the tops off the struts
    //         translate([0,0,-17]){
    //             cube([200,200,20],center=true);
    //         }
    //         // and shave the bottoms too
    //         translate([0,0,triangle_z_place+ TRIANGLE_HT*0.99]){
    //             cube([200,200,20],center=true);
    //         }

    //     }
    // }

    // Top PCB frame


    // top_coords = [
    //     [screw_x, screw_y,90],
    //     [-screw_x, screw_y,90],
    //     [-screw_x, -screw_y,225],
    //     [screw_x, -screw_y,315],
    // ];

    // //screwholes with horizontal flaps
    // top_frame_z = triangle_z_place - TRIANGLE_HT - 52;
    // for(this_coord = top_coords){
    //     translate([this_coord[0], this_coord[1], top_frame_z]){
    //         top_screw_mount(this_coord[2]);
    //     }
    // }


    // diagonal braces
    // TOP_DIAG_LN = 50;
    // brace_angles = [
    //     38, -38, 110,-110
    // ];
    // for(ang = brace_angles){
    //     rotate(ang,[0,0,1]){
    //         translate([-STANCHION_RAD,0,-70]){
    //             rotate(40,[1,0,0]){
    //                 cube([STANCHION_RAD * 2, TOP_SCREW_MNT_HT,TOP_DIAG_LN]);
    //             }
    //         }
    //     }
    // }

    // translate([0,STANCHION_RAD * 2.5, top_frame_z + TOP_SCREW_MNT_HT/2]){
    //     cube([screw_x*2 + STANCHION_RAD * 2, STANCHION_RAD * 2, TOP_SCREW_MNT_HT], center=true);
    // }
}

//######################################################################################
// PCB PCB PCB
//########################################################################################
translate([0,0,0]){
    rotate(0,[0,0,1]){
        translate([0 ,0,0]){
            rotate(0,[0,1,0]){
                translate([0,-20,55]){
                    //###############################################################################
                    // PCB assembly NOT PRINTED
                    translate([0,-8,-29+TRIANGLE_HT]){
                        rotate(-90,[0,0,1]){
                            color("green",1.0){
                                import("old_expts/PWM_array_assy02.1.stl");
                            }
                        }
                    }

                    //#################################################################
                    // PCB mounting
                    color("yellow",1.0){
                        translate([0,0,TRIANGLE_HT - 8]){
                            rotate(180,[0,1,0]){
                                PCB_mount(STANCHION_HT, sh_coords);
                            }
                        }
                    }
                }
            }
        }
    }
}    

//#####################################################################################
//#########################################################################################


translate([0,0,75]){
    rotate(180,[1,0,0]){
        hex_frame();
    }
}