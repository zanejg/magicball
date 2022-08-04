include <../LED_reflector_diffusor.scad>

RAD = 100;
WID = 10;
AL_WID = 21;
THK = 2.5;
LED_HOLE_RAD = 11/2;

hex_inner_rad = (sqrt(3)/2) * RAD;

FACET_ANGLE = 70.5288;

module frame(){
    difference(){
        cylinder(h=WID,r=RAD,$fn=6,center=true);
        translate([0,0,THK]){
            cylinder(h=WID,r=RAD-(2*THK),$fn=6,center=true);
        }
        translate([0,0,-2*THK]){
            cube([AL_WID,hex_inner_rad *2.1,THK],center=true);
        }
        cylinder(h=THK*5,r=LED_HOLE_RAD,$fn=40,center=true);
    }
    translate([0,0,-1*THK]){
        diffuser();
    }
    //cube([WID,hex_inner_rad *2,THK],center=true);
}

module side_frame(){
    translate([0,0,sin(FACET_ANGLE)*hex_inner_rad]){
        rotate(FACET_ANGLE,[1,0,0]){
            frame();
        }
    }
}

!frame();

facet_xy_move = hex_inner_rad - (cos(FACET_ANGLE)*hex_inner_rad);

translate([0,-facet_xy_move,0]){
    side_frame();
}

translate([facet_xy_move * sin(120),-facet_xy_move * cos(120),0]){
    rotate(120,[0,0,1]){
        side_frame();
    }
}

translate([-facet_xy_move * sin(120),-facet_xy_move * cos(120),0]){
    rotate(-120,[0,0,1]){
        side_frame();
    }
}


// RND_FACET_RAD = 118;

// #intersection(){
//     translate([0,0,62]){
//         sphere(r=RND_FACET_RAD,$fn=50);
//     }
//     translate([0,0,-30]){
//         cylinder(h= RAD *2/3,r=RAD-(2*THK),$fn=6,center=true);
//     }
// }

