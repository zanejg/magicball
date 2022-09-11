
TET_RAD = 102;
WID = 17;
//THK = 2;


include <PCB_assy_mnt.scad>
include <model_testing/belkin_power_bank.scad>
include <iris_holder_facet02.scad>
// include <../inner_electrical_frame.scad>

OUTER_WALL_TN = 2;




mount_ht = (WID/2 + OUTER_WALL_TN);

hex_inner_rad = (sqrt(3)/2) * TET_RAD;

FACET_ANGLE = 70.5288;



//#############################################################################################3
//###  Screw plates to hold the Hex frame together
//#################################################################################3
FRAME_PLATE_TN = 3;
FRAME_PLATE_LN = 80;

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
}
#translate([-FRAME_PLATE_LN/2,-90,WID*0.93]){
    rotate([FACET_ANGLE+90,0,0]){
        screw_plate();
    }
}

//#######################################################################################
//####   Hex frame to hold facets
//#######################################################################################

module mount_holes(){
    translate([0,hex_inner_rad+2,10 + OUTER_WALL_TN*1.6 ]){
    //translate([0,0,0]){
        rotate(90,[1,0,0]){
            translate([TET_RAD/4, 0, 0]){
                cylinder(h=15,r=4.2/2);
            }
            translate([-TET_RAD/4, 0, 0]){
                cylinder(h=15,r=4.2/2);
            }
        }
    }
}




module frame(){
    // hex frame
    difference(){
        translate([0,0,WID/2 + THK/2]){
            difference(){
                cylinder(h=WID ,r=TET_RAD + THK,$fn=6,center=true);
                translate([0,0,THK ]){
                    cylinder(h=WID ,r=TET_RAD-(2 * THK),$fn=6,center=true);
                }
                cylinder(h=WID*1.3,r=TET_RAD-(2 * THK)-WID,$fn=6,center=true);
            }
        }
        for(hole_ang = [0:60:360]){
            rotate([0,0,hole_ang]){
                mount_holes();
            }
        }

    }
    // // Al strip
    // translate([0,0,THK/2]){
    //     cube([AL_WID,hex_inner_rad *2,THK],center=true);
    // }
}
//###########################################################################################################
//############### the frame to print ##############################################
// difference(){
//     union(){
//         frame();
        
//         // translate([0,0,OUTER_WALL_TN*2]){
//         //     rotate([180,0,0]){
//         //         import("iris_holder_facet03.stl");
//         //     }
//         // }
//     }
//     // translate([0,0,-50]){
//     //     cube([150,220,100]);
//     // }
// }
//#######################################################################################################3

module side_frame(){
    translate([0,0,sin(FACET_ANGLE)*hex_inner_rad]){
        rotate(FACET_ANGLE,[1,0,0]){
            frame();
        }
    }
}


RND_FACET_RAD = 118;

module rounded_facet(){
    intersection(){
        translate([0,0,62]){
            sphere(r=RND_FACET_RAD,$fn=50);
        }
        translate([0,0,-TET_RAD/3]){
            cylinder(h= TET_RAD *2/3,r=TET_RAD-(2*THK),$fn=6,center=true);
        }
    }
}

module side_rounded_facet(){
    translate([0,0,sin(FACET_ANGLE)*hex_inner_rad]){
        rotate(FACET_ANGLE,[1,0,0]){
            rotate(180,[1,0,0]){
                rounded_facet();
            }
        }
    }
}

PCB_LATERAL_OFFSET = 21;
PCB_HOLDER_HT = 3;
PCB_ARM_TN = 4;
PCB_ARM_WD = 10;
PCB_ARM_YPOSI = -15;

SMPCB_LATERAL_OFFSET = 32;


// rotate(180,[1,0,0]){
//     frame();
// }




//####################################################################################
//##  PCB Mounting Frames

//#################################################################################
//###  Small PCB
module small_PCB_mount(){
    translate([0, SMPCB_LATERAL_OFFSET, PCB_HOLDER_HT]) {
        // PCB mount
        PCB_mount(STANCHION_HT, rpi_coords);    
        // diagonal connector along short side
        translate([-rpi_coords[0][0] - PCB_ARM_TN*1.5, 0, 0]) {
            rotate(25,[1,0,0]){
                cube([PCB_ARM_TN,40,PCB_ARM_WD]);    
            }
        }
        // flat connector on short side
        translate([-rpi_coords[0][0] - 5, 38, 18]) {
            difference(){
                cube([PCB_ARM_WD, 20, PCB_ARM_TN],center=true);
                translate([0,10-(PCB_ARM_WD/2),-4]){
                    cylinder(r=3/2,h=8);
                }
            }
        }

        // diagonal connector spar along long side
        translate([rpi_coords[0][0]*0.5,rpi_coords[0][1] + PCB_ARM_TN*0.4, 0]) {
            rotate(-25,[0,1,0]){
                cube([40,PCB_ARM_TN,PCB_ARM_WD]);    
            }
        }
        // flat connector on long side
        translate([rpi_coords[0][0]+25, 14, 18]) {
            difference(){
                cube([20,PCB_ARM_WD,PCB_ARM_TN],center=true);
                translate([10-(PCB_ARM_WD/2),0,-4]){
                    cylinder(r=3/2,h=8);
                }
            }
        }
    }
}



BOLLARD_HT = 15;

module bollard_with_hole(){
    // the bollard that will have the screwhole
    // doin the screwhole
    difference(){
        cube([PCB_ARM_WD, PCB_ARM_WD, BOLLARD_HT],center=true);
        #translate([0,0,-4]){
            cylinder(r=3/4,h=12);
        }
    }

}

module short_side_mounting_bollard(){
    // short side mounting bollard with pad
    translate([-34,hex_inner_rad-11.5,11.5]){
        bollard_with_hole();
        // pad
        translate([3,3,-(BOLLARD_HT/2+ PCB_ARM_TN/2.1)]){
            rotate(0,[0,0,1]){
                cube([30,12,PCB_ARM_TN],center=true);
            }
        }
    }
}

module long_side_mounting_bollard(){
    // long side mounting bollard with pad
    translate([59,46,11.5]){
        bollard_with_hole();
        // pad
        translate([3,0,-(BOLLARD_HT/2+ PCB_ARM_TN/2.1)]){
            rotate(30,[0,0,1]){
                cube([12,30,PCB_ARM_TN],center=true);
            }
        }
    }
}


translate([-2,0,14]){
    small_PCB_mount();
    long_side_mounting_bollard();
    short_side_mounting_bollard();
}

//PCB_mount(STANCHION_HT, sh_coords);
//##############################################################################
// Large PCB
module large_PCB_mounting_frame(){
    translate([0, PCB_LATERAL_OFFSET,-PCB_HOLDER_HT]){
        rotate(180,[0,1,0]){
            PCB_mount(STANCHION_HT, sh_coords);
        }
        // #########################################
        // Mounting arms
        // one side
        translate([48,PCB_ARM_YPOSI,-5]){
            cube([20,PCB_ARM_WD,PCB_ARM_TN],center=true);
        }
        translate([60,PCB_ARM_YPOSI,-12]){
            cube([PCB_ARM_TN,PCB_ARM_WD,18],center=true);
        }
        translate([68,PCB_ARM_YPOSI,-19]){
            // doin the screwhole
            difference(){
                cube([20,PCB_ARM_WD,PCB_ARM_TN],center=true);
                translate([10 - PCB_ARM_WD/2,0,-3]){
                    cylinder(h=6,r=3/2);
                }
            }
        }
        // other side mounting arm
        translate([-48,PCB_ARM_YPOSI,-5]){
            cube([20,PCB_ARM_WD,PCB_ARM_TN],center=true);
        }
        translate([-60,PCB_ARM_YPOSI,-12]){
            cube([PCB_ARM_TN,PCB_ARM_WD,18],center=true);
        }
        translate([-68,PCB_ARM_YPOSI,-19]){
            // doin the screwhole
            difference(){
                cube([20,PCB_ARM_WD,PCB_ARM_TN],center=true);
                translate([-10 + PCB_ARM_WD/2,0,-3]){
                    cylinder(h=6,r=3/2);
                }
            }
        }
        // offset end arm
        translate([-27,48,-5]){
            cube([PCB_ARM_WD,8,PCB_ARM_TN],center=true);
        }
        translate([-27,50,-12]){
            cube([PCB_ARM_WD,PCB_ARM_TN,18],center=true);
        }
        translate([-27,55.5,-19]){
            // doin the screwhole
            difference(){
                cube([PCB_ARM_WD,15,PCB_ARM_TN],center=true);
                translate([0,7.5 - PCB_ARM_WD/2,-3]){
                    cylinder(h=6,r=3/2);
                }
            }
        }
    }



    //##################################################################
    // Glued on mounting bollards
    //########################################################################
    // the pad that provides gluing surface
    // the right side (with end arm on the bottom from the top/board side)
    translate([83,15,-2]){
        rotate(30,[0,0,1]){
            cube([12,35,PCB_ARM_TN],center=true);
        }
    }
    // the bollard that will have the screwhole
    translate([73,6,-12.5]){
        // doin the screwhole
        difference(){
            cube([PCB_ARM_WD, PCB_ARM_WD, 15],center=true);
            translate([0,0,-9]){
                cylinder(r=3/4,h=12);
            }
        }
    }
    // the connecting strut
    translate([78,6,-5]){
        rotate(30,[0,0,1]){
            cube([15,20,PCB_ARM_TN],center=true);
        }
    }
    // # # # # # # # # # # # # # # # # # # # #
    // and again on the left side
    // the pad that provides gluing surface
    translate([-83,15,-2]){
        rotate(-30,[0,0,1]){
            cube([12,35,PCB_ARM_TN],center=true);
        }
    }
    // the bollard that will have the screwhole
    translate([-73,6,-12.5]){
        // doin the screwhole
        difference(){
            cube([PCB_ARM_WD, PCB_ARM_WD, 15],center=true);
            translate([0,0,-9]){
                cylinder(r=3/4,h=10);
            }
        }
    }
    // the connecting strut
    translate([-78,6,-5]){
        rotate(-30,[0,0,1]){
            cube([15,20,PCB_ARM_TN],center=true);
        }
    }
    
    // # # # # # # # # # # # # # # # # # # # #
    // the bottom bollard

    // the bollard that will have the screwhole
    translate([-27,79,-11]){
        difference(){
            cube([PCB_ARM_WD, PCB_ARM_WD, 18],center=true);
            translate([0,0,-10]){
                cylinder(r=3/4,h=10);
            }
        }
    }
    // the pad that provides gluing surface
    translate([-27,79,-2]){
            cube([35,12,PCB_ARM_TN],center=true);
    }

}

// display the large PCB mounting frame and place it in the main frame assy
translate([0, -hex_inner_rad * 0.82,TET_RAD]){
    rotate(FACET_ANGLE+180,[1,0,0]){
        translate([0,-6,14]){
            rotate(180,[0,1,0]){
                large_PCB_mounting_frame();
            }
        }
    }
}
//##################################################################
// To put the frame together into the tetrahedron
module hex_frame(){
    translate([0,0,WID]){
        rotate(180,[0,1,0]){
            frame();
        }
    }

    facet_xy_move = hex_inner_rad - (cos(FACET_ANGLE)*hex_inner_rad);

    translate([0,-facet_xy_move,WID]){
        side_frame();
    }

    translate([facet_xy_move * sin(120),-facet_xy_move * cos(120),WID]){
        rotate(120,[0,0,1]){
            side_frame();
        }
    }

    translate([-facet_xy_move * sin(120),-facet_xy_move * cos(120),WID]){
        rotate(-120,[0,0,1]){
            side_frame();
        }
    }



    // ###############################################################################
    // make the rounded facets
    // #translate([0,0,WID-THK]){
    //     rounded_facet();
    // }
}
LEG_LEN = 100;
LEG_RD = 5;

module tet_leg(){
    cylinder(h=LEG_LEN,r=LEG_RD);
    translate([0,0,LEG_LEN]){
        rotate(30,[0,0,1]){
            cylinder(h=3,r=20,$fn=3);
        }
    }


}

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

hex_frame();
// translate([0, 0, hex_inner_rad - 10]){
//     rotate(180,[1,0,0]){
//         tet_legs();
//     }
// }


//######################################################################
//  BATTERY holder
NEG_CAV_SCALE = 1.0;
module bottom_battery_cup(){
    difference(){
        // define the outer surface
        rotate([0,90,0]){
            scale([1.1,1.15,1.05]){
                belkin_power_bank();
            }
        }
        // define the inner
        translate([2,0,0]){
            rotate([0,90,0]){
                scale([NEG_CAV_SCALE,NEG_CAV_SCALE,NEG_CAV_SCALE]){
                    belkin_power_bank();
                }
            }
        }
        // chop off what we don't want
        translate([-BIG_RAD * 1.6,-BIG_RAD * 1.2, -35]){
            cube([120 *1.2,BIG_RAD*2.4,belkin_whole_len]);
        }

        // chop out end for plugs
        translate([88,0,-39]){
            rotate([0,90,0]){
                cylinder(h=6,r=SMALL_RAD-(TOP_BATT_HOLDER_LIP/2));
            }
            square_side=SMALL_RAD*2-(TOP_BATT_HOLDER_LIP);
            translate([0,-square_side/2,0]){
                cube([6,square_side,square_side]);
            }
        }

        // for a chopped out cross section
        // translate([-BIG_RAD * 2.2,-BIG_RAD * 1.2, -20]){
        //     cube([PACK_WIDTH*1.2,BIG_RAD*2.4,belkin_whole_len]);
        // }
        
    }
}
//bottom_battery_cup();

TOP_BATT_HOLDER_LIP = 2.5;
module top_battery_cup(){
    difference(){
        // define the outer surface
        rotate([0,90,0]){
            scale([1.1,1.1,1.05]){
                belkin_power_bank();
            }
        }
        // define the inner
        translate([2,0,0]){
            rotate([0,90,0]){
                scale([NEG_CAV_SCALE,NEG_CAV_SCALE,NEG_CAV_SCALE]){
                    belkin_power_bank();
                }
            }
        }
        // chop off what we don't want
        translate([-40,-BIG_RAD * 1.2,-90]){
            cube([belkin_whole_len*1.5,BIG_RAD*2.4,PACK_WIDTH*1.2]);
        }
        
        // chop out end for plugs
        translate([88,0,-1]){
            rotate([180,0,0]){
                rotate([0,90,0]){
                    cylinder(h=6,r=SMALL_RAD-(TOP_BATT_HOLDER_LIP/2));
                }
                square_side=SMALL_RAD*2-(TOP_BATT_HOLDER_LIP);
                translate([0,-square_side/2,0]){
                    cube([6,square_side,square_side]);
                }
            }
        }

        
        // // for a chopped out cross section
        // translate([-BIG_RAD * 3.2,-BIG_RAD * 1.2, -30]){
        //     cube([PACK_WIDTH*1.2,BIG_RAD*2.4,belkin_whole_len]);
        // }
        
    }
    // Connector tab
    TAB_LEN = 47;
    translate([41.5,18,TAB_LEN - 57]){
        difference(){
            cube([PCB_ARM_TN,PCB_ARM_WD,TAB_LEN]);
            translate([-2,PCB_ARM_WD/2,TAB_LEN-PCB_ARM_WD/2]){
                rotate(90,[0,1,0]){
                    cylinder(h=8,r=3/2);
                }
            }
        }
        translate([-15,-PCB_ARM_TN ,0]){
            cube([30,PCB_ARM_TN * 1.1,PCB_ARM_WD]);
        }
    }
}

module top_batt_tab(){
    TAB_LEN = 19.5;
    cube([PCB_ARM_WD * 1.5, 30,PCB_ARM_TN]);
    difference(){
        translate([(PCB_ARM_WD * 1.5)/2,10,0]){
            cube([PCB_ARM_TN,PCB_ARM_WD,20]);
        }
        translate([5,15,TAB_LEN-(PCB_ARM_WD/2)]){
            rotate([0, 90, 0]) {
                cylinder(h=8,r=3/2);
            }
            
        }
    }
}

module tet_triangle(){
    //cylinder(h=LEG_LEN,r=LEG_RD);
    translate([0,0,LEG_LEN]){
        rotate(30,[0,0,1]){
            cylinder(h=3,r=20,$fn=3);
        }
    }
}

// legs
NEG_LEN_SCALE = 0.93;
module batt_holder_triangles(){
    difference(){
        hull(){
            rotate(60,[0,0,1]){
                rotate(180,[1,0,0]){
                    tet_triangle();
                }
            }
            rotate(FACET_ANGLE, [1,0,0]){
                tet_triangle();
            }
            
        }
        translate([-8,-6,-4]){
            hull(){
                rotate(60,[0,0,1]){
                    rotate(180,[1,0,0]){
                        scale([1,1,NEG_LEN_SCALE]){
                            tet_triangle();
                        }
                    }
                }
                rotate(FACET_ANGLE, [1,0,0]){
                    scale([1,1,NEG_LEN_SCALE]){
                        tet_triangle();
                    }
                }   
            }
        }

    }
}

module top_batt_holder(){
    
    translate([-43,0,75]){
        top_battery_cup();
    }


    // to capture the triangles we will use the tet_legs
    difference(){
        translate([0, 0, hex_inner_rad - 10]){
            rotate(180,[1,0,0]){
                batt_holder_triangles();
            }
        }
       
    }

    color("purple",1.0){
        translate([0,50,80]){
            rotate([125,0,0]){
                translate([-5,22.5,-8]){
                    top_batt_tab();
                }
            }
        }
    }

    //###########################################################################
    // BATTERY NOT PRINTED
    rotate(0,[0,1,0]){
        translate([-side_dist,0,BIG_RAD_LEN]){
            rotate(90,[0,1,0]){
                color("green",1.0){
                    belkin_power_bank();
                }
            }
        }
    }

    

}
top_batt_holder();

module bott_batt_holder(){
    translate([-42,0,75]){
        bottom_battery_cup();
    }
    // bottom braces to triangular corners

    
    PLATE_WD = 15;
    PLATE_LN = 70;
    rotate(60,[0,0,1]){
        // flat bottom plate
        // right side from side away from small PCB
        translate([0,-PLATE_LN * 0.6,18.25]){
            cube([PLATE_WD,PLATE_LN,PCB_ARM_TN],center=true);
        }
        // diagonal brace up to meet triangle and tet leg
        translate([0, -PLATE_LN - 5, 30]) {
            rotate(-45,[1,0,0]){
                cube([PCB_ARM_TN,42,PLATE_WD],center=true);
            }
        }
    }
    rotate(-60,[0,0,1]){
        // left side from side away from small PCB
        translate([0,-PLATE_LN * 0.6,18.25]){
            cube([PLATE_WD,PLATE_LN,PCB_ARM_TN],center=true);
        }
        // diagonal brace up to meet triangle and tet leg
        translate([0, -PLATE_LN - 5, 30]) {
            rotate(-45,[1,0,0]){
                cube([PCB_ARM_TN,42,PLATE_WD],center=true);
            }
        }
    }
    // to capture the triangles we will use the tet_legs
    difference(){
        translate([0, 0, hex_inner_rad - 10]){
            rotate(180,[1,0,0]){
                tet_legs();
            }
        }
        // chop off the other 2 legs 
        translate([0,50,100]){
            rotate(-45,[1,0,0]){
                cube([50,200,100],center=true);
            }
        }
        // now use a sphere to remove most of the remaining legs 
        // leaving the ends with the triangles
        translate([0,0,80]){
            sphere(87);
        }
    }
}

bott_batt_holder();



//####################################################################################
//###   triangular corner caps
//#########################################################################3
tri_small_rad = TET_RAD / sqrt(3);

edge_incid_angle = 90 - FACET_ANGLE;
tri_edge_angled_wid = sin(FACET_ANGLE) * WID;
tri_diff = tri_edge_angled_wid / sin(30);
tri_cap_big_rad = tri_small_rad + tri_diff;

cap_ht = WID * sin(edge_incid_angle);

vertex_angle = atan(sqrt(2));

module corner_chopper(){
    translate([tri_small_rad - 3, 0, 0]){
        rotate([0,0,-90]){
            rotate([vertex_angle,0,0]){
                rotate([0,90,0]){
                    hull(){
                        rotate([0,-(180-FACET_ANGLE)/2,0]){
                            cube([WID,40,0.1]);
                        }
                        rotate([0,(180-FACET_ANGLE)/2,0]){
                            cube([WID,40,0.1]);
                        }
                    }
                    translate([8,0,-20]){
                        cube([30,50,40]);
                    }
                }
            }
        }       
    }
}

module triangular_cap(){
    difference(){
        hull(){
            cylinder(h=0.1,r=tri_cap_big_rad, $fn=3);
            translate([0,0,cap_ht]){
                cylinder(h=0.1,r=tri_small_rad,$fn=3);
            }
        }
        corner_chopper();
        rotate([0,0,120]){
            corner_chopper();
        }
        rotate([0,0,240]){
            corner_chopper();
        }
    }
    
}


translate([0,0,192]){
    rotate([180,0,0]){
        rotate([0,0,30]){
            triangular_cap();
        }
    }
}






//###########################################################
//### PCBs NOT PRINTED
//###########################################################

// translate([12,29,50.5]){
//     rotate([0,0,-90]){
//         color("green",1.0){
//             import("model_testing/raspy_i2c_conn_assy.stl");
//         }
//     }
// }


// translate([0,-38,80]){
//     rotate([FACET_ANGLE,0,0]){
//         translate([0,-18,0]){
//             rotate([0,0,-90]){
//                 color("green",1.0){
//                     import("model_testing/PWM_array_assy02.stl");
//                 }
//             }
//         }
//     }
// }



// translate([12,-20,175]){
//     rotate([0,0,0]){
//         color("green",1.0){
//             import("model_testing/HW040_rotary_sw.stl");
//         }
//     }
// }

translate([0,0,WID - OUTER_WALL_TN*2]){
    import("iris_holder_facet03.stl");
}


// // facets but wrong
// translate([0,-facet_xy_move,WID]){
//         side_rounded_facet();   
// }

// translate([facet_xy_move * sin(120),-facet_xy_move * cos(120),WID]){
//     rotate(120,[0,0,1]){
//         side_rounded_facet();
//     }
// }
// translate([-facet_xy_move * sin(120),-facet_xy_move * cos(120),WID]){
//     rotate(-120,[0,0,1]){
//         side_rounded_facet();
//     }
// }