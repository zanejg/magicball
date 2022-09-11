
TET_RAD = 100;
WID = 15;
THK = 2;
AL_WID = 25;


// include <../inner_electrical_frame.scad>



hex_inner_rad = (sqrt(3)/2) * TET_RAD;

FACET_ANGLE = 70.5288;

module frame(){
    // hex frame
    translate([0,0,WID/2]){
        difference(){
            cylinder(h=WID,r=TET_RAD,$fn=6,center=true);
            translate([0,0,THK]){
                cylinder(h=WID,r=TET_RAD-(2*THK),$fn=6,center=true);
            }

            cylinder(h=WID*1.1,r=TET_RAD-(2*THK)-WID,$fn=6,center=true);

        }
    }
    // // Al strip
    // translate([0,0,THK/2]){
    //     cube([AL_WID,hex_inner_rad *2,THK],center=true);
    // }
}

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



    //###############################################################################
    // make the rounded facets
    #translate([0,0,WID-THK]){
        rounded_facet();
    }

}

// hex_frame();


//#############################################################
// // battery pack
// module batt_pack(){
//     TET_RAD = 15/2;
//     MAIN_LEN = 147;
//     TOT_WIDTH = 75;

//     cyl_offset = (TOT_WIDTH - (2*TET_RAD) )/2;
//     hull(){
//         translate([cyl_offset,0,0]){
//             cylinder(MAIN_LEN,TET_RAD,TET_RAD,center=true);
//         }
//         translate([-cyl_offset,0,0]){
//             cylinder(MAIN_LEN,TET_RAD,TET_RAD,center=true);
//         }

//     }
// }

// translate([0,0,30]){
//     rotate(90,[1,0,0]){
//         batt_pack();
//     }
// }




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