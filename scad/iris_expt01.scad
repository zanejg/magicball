
// facet stuff
RND_FACET_RAD = 118;
RAD = 100;
WID = 10;
THK = 1.5;

CENTER_HT= 60;

OUTER_WALL_TN = 2;

IRIS_INNER_RAD = 10;
IRIS_OUTER_RAD = 80;

third_rad = ((IRIS_INNER_RAD+IRIS_OUTER_RAD)/3);//*(2/3);
neg_outer_rad = IRIS_OUTER_RAD-3;
sm_outer_rad = neg_outer_rad - 3;


PETAL_NUMBER = 30;
GAP_RATIO = 0.3;

inter_petal_angle = 360/PETAL_NUMBER;


half_rad = ((IRIS_INNER_RAD+IRIS_OUTER_RAD)/2);

inner_ht = IRIS_INNER_RAD * sin((inter_petal_angle)/2 * (1-GAP_RATIO));
outer_ht = IRIS_OUTER_RAD * sin((inter_petal_angle)/2 * (1-GAP_RATIO));

neg_inner_ht = third_rad * sin((inter_petal_angle)/2 * (1-GAP_RATIO) * (2/3));
neg_outer_ht = neg_outer_rad * sin((inter_petal_angle)/2 * (1-GAP_RATIO) * (2/3));

// small inner petals
sm_inner_ht = half_rad * sin((inter_petal_angle)/2 * (1-GAP_RATIO) * (1/4)) ;
sm_outer_ht =  sm_outer_rad * sin((inter_petal_angle)/2 * (1-GAP_RATIO) * (1/4));


petal_cnrs = [
    [IRIS_INNER_RAD             , inner_ht],
    [IRIS_OUTER_RAD-(outer_ht/3), outer_ht],
    [IRIS_OUTER_RAD             , outer_ht*(2/3)],
    [IRIS_OUTER_RAD             , -outer_ht*(2/3)],
    [IRIS_OUTER_RAD-(outer_ht/3), -outer_ht],
    [IRIS_INNER_RAD             ,-inner_ht],
];
neg_petal_cnrs = [
    [third_rad, neg_inner_ht],
    [neg_outer_rad-(neg_outer_ht/3), neg_outer_ht],
    [neg_outer_rad,neg_outer_ht*(2/3)],
    [neg_outer_rad,-neg_outer_ht*(2/3)],
    [neg_outer_rad-(neg_outer_ht/3), -neg_outer_ht],
    [third_rad, -neg_inner_ht],
];

sm_petal_cnrs = [
    [half_rad, sm_inner_ht],
    [sm_outer_rad, sm_outer_ht],
    [sm_outer_rad, -sm_outer_ht],
    [half_rad, -sm_inner_ht],
];

module draw_petal(){
    polygon(petal_cnrs);
}


// polygon(petal_cnrs);
// rotate(inter_petal_angle,[0,0,1]){
//     polygon(petal_cnrs);
// }

module big_loop(){
    difference(){
        circle(r=third_rad);
        translate([third_rad/10,0,0]){
            circle(r=third_rad*21/20);
        }
    }
}
module little_loop(){
    lrad=third_rad/2;
    difference(){
        circle(r=lrad);
        translate([lrad/10,0,0]){
            circle(r=lrad*21/20);
        }
    }
}


module inner_cavity(){
    intersection(){
        translate([0,0,62]){
            sphere(r=RND_FACET_RAD,$fn=50);
        }
        translate([0,0,-30]){
            cylinder(h= RAD *2/3,r=RAD-(2*THK),$fn=6,center=true);
        }
    }
}
//##########################################################################
//###########################################################################
difference(){
    union(){
        intersection(){
            translate([0,0,-CENTER_HT]){
                //##############################################################
                // ALL THE PRETTY stuff!!
                linear_extrude(height=CENTER_HT){
                    difference(){
                        for(ang = [0:inter_petal_angle:360]){
                            rotate(ang,[0,0,1]){
                                polygon(petal_cnrs);
                            }
                        }
                        for(ang = [0:inter_petal_angle:360]){
                            rotate(ang,[0,0,1]){
                                polygon(neg_petal_cnrs);
                            }
                        }
                    }

                    for(ang = [0:inter_petal_angle:360]){
                        rotate(ang,[0,0,1]){
                            polygon(sm_petal_cnrs);
                        }
                    }
                    // some loops to make it more organic
                    lp_rad = third_rad *(5/4);
                    rotate(80,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            little_loop();
                        }
                    }

                    rotate(-40,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            little_loop();
                        }
                    }

                    rotate(40,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            little_loop();
                        }
                    }
                    rotate(-130,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            little_loop();
                        }
                    }
                    rotate(-150,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            little_loop();
                        }
                    }
                    rotate(150,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            little_loop();
                        }
                    }
                    
                    translate([-lp_rad,0,0]){
                        big_loop();
                    }

                    rotate(45,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            big_loop();
                        }
                    }

                    rotate(120,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            big_loop();
                        }
                    }
                    rotate(180,[0,0,1]){
                        translate([-lp_rad,0,0]){
                            big_loop();
                        }
                    }
                    rotate(-80,[0,0,1]){
                        translate([-lp_rad*(2/3),0,0]){
                            big_loop();
                        }
                    }
                }
                // Needs some support at the pupil
                translate([0,0,0]){
                    difference(){
                        cylinder(h=CENTER_HT,r=IRIS_INNER_RAD*(2/3));
                        cylinder(h=CENTER_HT*1.1,r=IRIS_INNER_RAD*(2/3)-1.5);
                    }
                }

                // around the pupil
                translate([0,0,0]){
                    difference(){
                        cylinder(h=CENTER_HT,r=IRIS_INNER_RAD);
                        cylinder(h=CENTER_HT*1.1,r=IRIS_INNER_RAD-1.5);
                    }
                }

                cylinder(h=CENTER_HT,r=IRIS_INNER_RAD*(1/6));

                //###############################################################
            }
            inner_cavity();
        }

        // outer walls
        difference(){
            difference(){
                intersection(){
                    translate([0,0,CENTER_HT+ 2]){
                        sphere(r=RND_FACET_RAD + OUTER_WALL_TN,$fn=50);
                    }
                    translate([0,0,-30]){
                        cylinder(h= RAD *2/3,r=RAD-(2*THK) +  OUTER_WALL_TN,$fn=6,center=true);
                    }

                }
                translate([0,0,2.5]){
                        cylinder(h= 5,r=RAD-(2*THK) +  OUTER_WALL_TN*1.1,$fn=6,center=true);
                }
            }
            inner_cavity();
            // translate([-100,0,-80]){
            //     cube([200,200,200]);
            // }
        }
        translate([0,0,0]){
            cylinder(h= OUTER_WALL_TN*1,r=RAD-(2*THK) +  OUTER_WALL_TN,$fn=6,center=true);
        }
    }

    

    // chop the bottom off cos it takes 6 days to print!!
    translate([0,0,-10]){
        cube([250,250,50],center=true);
    }
}
// put a wee base under the chopped off bit
#translate([0,0,-35.5]){
    cylinder(h=2,r=70);
}

