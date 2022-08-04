
RAD = 100;
WID = 15;
THK = 1.5;
AL_WID = 25;


hex_inner_rad = (sqrt(3)/2) * RAD;

FACET_ANGLE = 70.5288;

module frame(){
    // hex frame
    translate([0,0,WID/2]){
        difference(){
            cylinder(h=WID,r=RAD,$fn=6,center=true);
            cylinder(h=WID*1.1,r=RAD-(2*THK),$fn=6,center=true);
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

frame();

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


RND_FACET_RAD = 118;

module rounded_facet(){
    intersection(){
        translate([0,0,62]){
            sphere(r=RND_FACET_RAD,$fn=50);
        }
        translate([0,0,-RAD/3]){
            cylinder(h= RAD *2/3,r=RAD-(2*THK),$fn=6,center=true);
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

//###############################################################################
// make the rounded facets
// translate([0,0,WID]){
//     rounded_facet();
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