// Assembly file to design and check the switch assembly 
// triangular cap
// zjg 2022-11-30


include <slider_2pole_switch.scad>
include <micro_USB_skt_PCB.scad>
include <coloured_button_sw.scad>




RAD = 100;
TET_RAD = 102;
WID = 17;
FACET_ANGLE = 70.5288;
OUTER_WALL_TN = 2;

//####################################################################################
//###   triangular corner caps
//#########################################################################3
tri_small_rad = TET_RAD / sqrt(3);
sm_tri_side_len = TET_RAD;

edge_incid_angle = 90 - FACET_ANGLE;
tri_edge_angled_wid = sin(FACET_ANGLE) * WID;
tri_diff = tri_edge_angled_wid / sin(30);
tri_cap_big_rad = tri_small_rad + tri_diff;

cap_ht = WID * sin(edge_incid_angle);

vertex_angle = atan(sqrt(2));
//#######################################################################################
hole_ht_from_base = 10 + OUTER_WALL_TN*1.6;

module corner_chopper(){
    translate([tri_small_rad - 3, 0, 0]){
        rotate([0,0,-90]){
            rotate([vertex_angle,0,0]){
                rotate([0,90,0]){
                    hull(){
                        rotate([0,-(180-FACET_ANGLE)/2,0]){
                            translate([0,-4,0]){
                                cube([WID,40,0.1]);
                            }
                        }
                        rotate([0,(180-FACET_ANGLE)/2,0]){
                            translate([0,-4,0]){
                                cube([WID,40,0.1]);
                            }
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

screw_offset_to_side = -1 * sm_tri_side_len * (sqrt(3)/6) - 
                           hole_ht_from_base/2 - 0.7 ;
module tri_cap_screwholes(){
    
    translate([screw_offset_to_side, TET_RAD/4,-10]){
        rotate([0,-edge_incid_angle,0]){
            cylinder(h=20, r=3.1/2);
            translate([0,0,6]){
                cylinder(h=6, r2=3/2, r1=16/2);
            }
        }
    }

    translate([screw_offset_to_side, -TET_RAD/4,-10]){
        rotate([0,-edge_incid_angle,0]){
            cylinder(h=20, r=3.1/2);
            translate([0,0,6]){
                cylinder(h=6, r2=3/2, r1=16/2);
            }
        }
    }


}


module triangular_cap(){
    TOP_TRI_TN = 2;
    difference(){
        hull(){
            translate([0,0,-TOP_TRI_TN]){
                cylinder(h=TOP_TRI_TN,r=tri_cap_big_rad, $fn=3);
            }
            translate([0,0,cap_ht]){
                cylinder(h=0.1,r=tri_small_rad,$fn=3);
            }
        }
        corner_chopper();
        tri_cap_screwholes();

        rotate([0,0,120]){
            corner_chopper();
            tri_cap_screwholes();
        }
        rotate([0,0,240]){
            corner_chopper();
            tri_cap_screwholes();
        }
        
    }
    
}

module base_cap(){
    rotate([180,0,0]){
        triangular_cap();
    }
}

//#############################################################################
//############################################################################
//#### what we gonna print

// power switch
POW_SW_CAV_LN = 25;
POW_SW_CAV_WD = 9;
POW_SW_CAV_DP = 5;
POW_SW_HOLE_RD = 3.2/2;
POW_SW_HOLE_DP = 5;
POW_SW_HOLE_DIST = 19;

SELF_TAP_HOLE_RD = 2.2/2;

ROTARY_SHAFT_HOLE_RD = 8/2;
PUSH_BUTTON_HOLE_RD = 13.2/2;



difference(){
    union(){
        base_cap();

        //Power switch box around cavity 
        translate([27,-8,-8]){
            rotate([0,0,30]){
                cube([POW_SW_CAV_LN * 1.2, 
                    POW_SW_CAV_WD * 1.2, 
                    POW_SW_CAV_DP + 5], center=true);
            }
        }

        // USB PCB mounting stanchion
        translate([20,5.4,-10.5]){
            rotate([0,0,-30]){
                cube([15, 5, 12], center=true);
            } 
        }

        //########################################################
        // Rotary switch mounting
        translate([0,0,-4.5]){
            rotate([0,0,0]){
                cube([12, 12, 7], center=true);
            } 
        }
        translate([-2,9.7,-8.4]){
            rotate([0,0,0]){
                cube([24, 7, 8], center=true);
            } 
        }


    }

    // main triangular indentation to reduce thickness for switches
    translate([0,0,-4]){
        rotate([0,0,0]){
            cylinder(h = 10, r = tri_small_rad - 6, $fn=3);
        } 
    }
    
    //#################################################
    // Power switch cavity
    translate([27,-8,-6]){
        rotate([0,0,30]){
            cube([POW_SW_CAV_LN, POW_SW_CAV_WD, POW_SW_CAV_DP +1], center=true);
        } 
    }
    // mounting screwholes
    translate([18.8,-13,-13.5]){
        rotate([0,0,30]){
            power_switch_holes();
        } 
    }
    


    //#################################################
    // Micro USB socket PCB Assembly
    translate([21.2,10.7,-10]){
        rotate([0,0,-30]){
            microUSB_hole();
        } 
    }
    // 
    translate([22.8,9.6,-9.5]){
        rotate([0,0,-30]){
            cube([15, 5, 10], center=true);
        } 
    }
    translate([19.4,12,-13.9]){
        rotate([0,0,-30]){
            USB_PCB_mount_holes();
        } 
    }
    
    //########################################################
    // Rotary switch mounting holes
    translate([-9.3,8,-14]){
        rotary_mount_screwholes();
    }
    // rotary switch shaft hole
    translate([0,0,-15]){
        cylinder(h = 15, r = ROTARY_SHAFT_HOLE_RD);
    }

    //#################################################
    // PUSH BUTTON HOLES
    // RED
    translate([5,-18,-10]){
        cylinder(h = 10, r = PUSH_BUTTON_HOLE_RD);
    }
    // WHITE
    translate([-17,30,-10]){
        cylinder(h = 10, r = PUSH_BUTTON_HOLE_RD);
    }
    // YELLOW
    translate([-2,22,-10]){
        cylinder(h = 10, r = PUSH_BUTTON_HOLE_RD);
    }



    // to check cut aways
    // translate([0,0,0]){
    //         cube([50,120,50], center=true);
     
    // }

}


module power_switch_holes(){
    // it's important that the holes are exactly the right distance apart
    // so we will be doing them together
    cylinder(r=POW_SW_HOLE_RD, h=POW_SW_HOLE_DP);
    translate([POW_SW_HOLE_DIST,0,0]) {
        cylinder(r=POW_SW_HOLE_RD, h=POW_SW_HOLE_DP);
    }
    // body hole
    translate([POW_SW_HOLE_DIST/2,0,0]){
        cube([15.8,8.5, 10], center=true);
    }
}


module microUSB_hole(){
    // size of hole to allow microUSB connection =4X8
    USB_HOLE_WD = 4;
    USB_LN = 8;

    hull(){
        cylinder(h=10, r=USB_HOLE_WD/2);
        translate([USB_LN-USB_HOLE_WD,0,0]){
            cylinder(h=10, r=USB_HOLE_WD/2);
        } 

    }
}

module USB_PCB_mount_holes(){
    rotate([90,0,0]){
        cylinder(h=11, r=SELF_TAP_HOLE_RD);
        translate([8.5,0,0]){
            cylinder(h=11, r=SELF_TAP_HOLE_RD);
        }
    }
}

module rotary_mount_screwholes(){
    cylinder(h=12, r=SELF_TAP_HOLE_RD);
    translate([14.7, 0, 0]){
        cylinder(h=12, r=SELF_TAP_HOLE_RD);
    }
}



//#############################################################################
//############################################################################




BUTTON_Z = -22;
translate([-2,22,BUTTON_Z]){ 
    coloured_push_button(colour = "yellow", nut_posi = 4);
}

translate([-17,30,BUTTON_Z]){ 
    coloured_push_button(colour = "white", nut_posi = 4);
}


translate([5,-18,BUTTON_Z]){ 
    coloured_push_button(colour = "red", nut_posi = 4);
}

// translate([27,-8,-5]){
//     rotate([0,0,30]){
//         slider_2pole_switch();
//     }
// }

translate([0,0,-14]){
    rotate([0,0,0]){
        color("green",1.0){
            import("../HW040_rotary_sw.stl");
        }
    }
}



union(){
    translate([22,8,-12]) {
        rotate([0,0,-30]){
            rotate([-90,0,0]){
                color("green",1.0){
                    micro_USB_skt_PCB();
                }
            }
        }
    }
    // #translate([21.2,10.7,0]){
    //     rotate([0,0,-30]){
    //         microUSB_hole();
    //     } 
    // }
}
