include <binary_tree.scad>
include <iris_cap01.scad>
include <model_testing/LED.scad>

$fn=30;

// facet stuff
RND_FACET_RAD = 118;
RAD = 100;
//WID = 10;
THK = 2;
CENTER_HT= 60;
OUTER_WALL_TN = 2;


hex_inner_rad = (sqrt(3)/2) * RAD;

HEX_WID = 15;

TREE_INNER_RAD = 68;
TREE_BASE_TN = 3;
TREE_TOP_TN = 10;
TREE_HT = 34;
TREE_BASE = 8;
TREE_LEVELS = 4;
tree_outer_rad = TREE_INNER_RAD+TREE_BASE_TN;
tree_top_outer_rad = TREE_INNER_RAD+TREE_TOP_TN;

SUPPORT_HT = -35;
SUPPORT_RING_HT = 5;
tree_ht=(SUPPORT_HT+(SUPPORT_RING_HT*1.45))*-1;

AL_WID = 25;
AL_LEN = 160;
AL_TN = 3;
HOLE_NUM = 12;
hole_len = AL_LEN * 0.8;
hole_sep = hole_len/HOLE_NUM;
HOLE_SZ = 5;

BOLL_HT = 9;
BOLL_RD = 8/2;
BUSH_RD = 4.2/2;

mount_ht = (HEX_WID/2 + OUTER_WALL_TN);


bollard_positions1 = [for(i=[(hole_len/2)-(hole_sep*1.5):-(hole_len-(hole_sep*1.5)*2):-((hole_len/2)-(hole_sep*1.5))]) 
                        let (x=-(AL_WID/2)-(BOLL_RD*1.2),y=i)
                        [x,y] ]; 
bollard_positions2 = [for(i=[(hole_len/2)-(hole_sep*1.5):-(hole_len-(hole_sep*1.5)*2):-((hole_len/2)-(hole_sep*1.5))]) 
                        let (x=(AL_WID/2)+(BOLL_RD*1.2),y=i)
                        [x,y] ];
hole_dist_from_center = AL_WID*(11/12);

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

module bush_bollard(){
    difference(){
        cylinder(h=9,r=8.5/2);
        cylinder(h=9.1,r=4.2/2);
    }
}

module mount_holes(){
    translate([0,hex_inner_rad,-mount_ht ]){
        rotate(90,[1,0,0]){
            translate([RAD/4, 0, 0]){
                cylinder(h=15,r=4.2/2);
            }
            translate([-RAD/4, 0, 0]){
                cylinder(h=15,r=4.2/2);
            }
        }
    }
}

module mount_stanchion(){
    st_ht = mount_ht+5+OUTER_WALL_TN;
    translate([RAD/4,hex_inner_rad-8,-st_ht/2]){
        cube([10,12,st_ht],center=true);
    }
    translate([-RAD/4,hex_inner_rad-8,-st_ht/2]){
        cube([10,12,st_ht],center=true);
    }
}

module ring(ht,rad,tn){
    difference(){
        cylinder(h=ht,r=rad);
        translate([0,0,-0.1]){
            cylinder(h=ht*1.2,r=rad-tn);
        }
    }
}

//##########################################################################
//###########################################################################
TREE_OFFSET = 5;

module iris_holder_facet(){
    intersection(){
        difference(){
            union(){
                difference(){   
                    union(){
                        difference(){
                            union(){
                                //  main shell
                                difference(){
                                    union(){
                                        //inner_cavity();
                                        
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
                                                translate([0,0,OUTER_WALL_TN]){
                                                        cylinder(h= 5,r=RAD-(2*THK) +  OUTER_WALL_TN*1.1,$fn=6,center=true);
                                                }
                                            }
                                            inner_cavity();
                                            // translate([-100,0,-80]){
                                            //     cube([200,200,200]);
                                            // }
                                        }
                                        // base plate
                                        translate([0,0,0]){
                                            cylinder(h= OUTER_WALL_TN*1,r=RAD-(2*THK) +  OUTER_WALL_TN,$fn=6,center=true);
                                        }
                                        // mount stanchions
                                        for(dg = [0:60:360]){
                                            rotate(dg,[0,0,1]){
                                                mount_stanchion();
                                            }
                                        }
                                        
                                    }
                                    // chop the top off for the iris
                                    translate([0,0,-60]){
                                        cube([250,250,50],center=true);
                                    }
                                    

                                }

                                // the support trees
                                for(i = [0:5]){
                                    rotate((60* i)+30,[0,0,1]){
                                        intersection(){
                                            difference(){
                                                // A fat tree to be trimmed back
                                                translate([0,-(TREE_INNER_RAD+TREE_BASE_TN/2),TREE_OFFSET]){
                                                    rotate(180,[1,0,0]){
                                                        make_tree(tree_ht+TREE_OFFSET,TREE_LEVELS,TREE_BASE,22);
                                                    }
                                                }
                                                // remove to a curved concave surface
                                                translate([0,0,-tree_ht*1.1]){
                                                    cylinder(h=tree_ht*1.2,r=TREE_INNER_RAD,$fn=40);
                                                }
                                            }
                                            // trim the convex side of the tree
                                            translate([0,0,-tree_ht*1.1]){
                                                cylinder(h=tree_ht*1.2,
                                                        r1=tree_top_outer_rad,
                                                        r2=tree_outer_rad,$fn=40);
                                            }

                                        }
                                    }
                                }
                            }
                            // chop out the base to support the iris
                            translate([0,0,SUPPORT_HT-2]){
                                cylinder(h=5,r=70.5);
                            }
                        }
                        // add support ring on top of the trees
                        support_ring_bot_ht = SUPPORT_HT+SUPPORT_RING_HT/2;
                        FORCE_RADIAL_HT = 2;
                        
                        intersection(){
                            union(){
                                translate([0,0,support_ring_bot_ht]){
                                    difference(){
                                        cylinder(h=SUPPORT_RING_HT - FORCE_RADIAL_HT, r=tree_top_outer_rad);
                                        translate([0,0,-0.5 ]){
                                            cylinder(h=SUPPORT_RING_HT*1.2,r=TREE_INNER_RAD);
                                        }
                                    }
                                }
                                translate([0,0,support_ring_bot_ht+FORCE_RADIAL_HT*1.5]){
                                    ring(FORCE_RADIAL_HT,TREE_INNER_RAD+2,2);
                                    ring(FORCE_RADIAL_HT,TREE_INNER_RAD+4.1,2);
                                    ring(FORCE_RADIAL_HT,TREE_INNER_RAD+6.2,2);
                                    ring(FORCE_RADIAL_HT,TREE_INNER_RAD+8.3,2);
                                }

                            }

                            // shave the outer corner off so it won't protrude
                            translate([0,0,-TREE_HT*0.95]){
                                cylinder(h=SUPPORT_RING_HT,
                                        r1=tree_top_outer_rad - TREE_TOP_TN/2,
                                        r2=tree_top_outer_rad
                                        );
                            }

                        }
                        // we need to force the slicer to only lay filament radially
                        // so we will make the bottom layers an array of thin rings separated by < 1mm


                        
                    }

                    // to create hole for aluminium LED support strip
                    cube([AL_WID+ 0.5, AL_LEN + 1, THK * 1.2],center=true);

                    // to provide a series of holes along the sides of the AL slot
                    // for ventilation and hook holes
                    for(i=[0:HOLE_NUM]){
                        translate([hole_dist_from_center,-(hole_len/2) + (i * (hole_len/HOLE_NUM)),0]){
                            cube([HOLE_SZ, HOLE_SZ, THK * 1.2],center=true);
                        }
                    }
                    for(i=[0:HOLE_NUM]){
                        translate([-hole_dist_from_center,-(hole_len/2) + (i * (hole_len/HOLE_NUM)),0]){
                            cube([HOLE_SZ, HOLE_SZ, THK * 1.2],center=true);
                        }
                    }

                    // mount holes
                    for(dg = [0:60:360]){
                        rotate(dg,[0,0,1]){
                            mount_holes();
                        }
                    }

                    // shave off the bottoms of the trees
                    translate([0,0,TREE_OFFSET+OUTER_WALL_TN/2]){
                        cube([200,200,TREE_OFFSET*2],center=true);
                    }


                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    // to provide a chopped away view
                    // translate([30,-100,-60]){
                    //     cube([150,200,100]);
                    // }
                    //##########################################################
                }
                // support bollards for bushes
                for(i=[0:len(bollard_positions1)-1]){
                    translate([bollard_positions1[i][0],bollard_positions1[i][1],-BOLL_HT + OUTER_WALL_TN/2]){
                        cylinder(h=BOLL_HT,r=BOLL_RD);
                    }
                }

                for(i=[0:len(bollard_positions2)-1]){
                    translate([bollard_positions2[i][0],bollard_positions2[i][1],-BOLL_HT + OUTER_WALL_TN/2]){
                        cylinder(h=BOLL_HT,r=BOLL_RD);
                    }
                }
            }
            // bushing holes for bollards
            for(i=[0:len(bollard_positions1)-1]){
                translate([bollard_positions1[i][0],bollard_positions1[i][1],-BOLL_HT*1.1]){
                    cylinder(h=BOLL_HT*1.4,r=BUSH_RD);
                }
            }
            for(i=[0:len(bollard_positions2)-1]){
                translate([bollard_positions2[i][0],bollard_positions2[i][1],-BOLL_HT*1.1]){
                    cylinder(h=BOLL_HT*1.4,r=BUSH_RD);
                }
            }

        }

    // #translate([0,hex_inner_rad,5]){
    //     cube([35,25,20],center=true);
    // }
    }
}

//iris_holder_facet();

//#############################################################################
// strap

// AL_STRAP_COLOUR = [];
// STRAP_ANGLE=11;
// STRAP_CLIP_ANGLE=55;
// STRAP_TN = 2.5;
// strap_span_len = AL_WID*1.9;
// hook_end_len = OUTER_WALL_TN *2.2;
// hook_sz = HOLE_SZ-0.5 ;//* (4/5);
// hook_rad = hook_sz/4 + OUTER_WALL_TN/4;

// module curling_hook(){
//     rotate(-90,[1,0,0]){
//         union(){
//             difference(){
//                 rotate_extrude(angle=180){
//                     translate([hook_rad,0,0]){
//                         square(hook_sz);
//                     }
//                 }
//                 translate([hook_rad* 2/10,-0.2 ,-0.1]){
//                     cube([HOLE_SZ*1.3, OUTER_WALL_TN * 1, HOLE_SZ*1.1]);
//                 }
//             }
//             translate([-(hook_sz + hook_rad),-hook_end_len,0]){
//                 cube([hook_sz, hook_end_len, hook_sz]);
//             }
//         }
//     }
// }

// module al_strap(){
//     difference(){
//         // the two angled spanning flat lengths
//         union(){
//             translate([2,3,0]){
//                 rotate(STRAP_ANGLE,[0,0,1]){
//                     cube([strap_span_len,8,3],center=true);
//                 }
//             }
//             translate([2,-3,0]){
//                 rotate(-STRAP_ANGLE,[0,0,1]){
//                     cube([strap_span_len,8,3],center=true);
//                 }
//             }
//         }
//         // the screw hole
//         translate([-(AL_WID*(69/100)),0,-2]){
//             cylinder(h=4,r=3.1/2);
//         }
//     }
    



//     // curling hook for strap
    
//     translate([hole_dist_from_center+hook_rad+hook_sz/2, HOLE_SZ/1.6 ,-OUTER_WALL_TN*1.5]){
//         curling_hook();
//     }
//     translate([hole_dist_from_center+hook_rad+hook_sz/2, -HOLE_SZ/1.6 -hook_sz ,-OUTER_WALL_TN*1.5]){
//         curling_hook();
//     }


//     // // two kinked bits that go thru the hole
//     // translate([AL_WID * 85/100+1.5,5.5,-2.49]){
//     //     rotate(STRAP_CLIP_ANGLE,[0,1,0]){
//     //         cube([THK * 3.5, HOLE_SZ * 4/5, STRAP_TN],center=true);
//     //     }
//     // }
//     // translate([AL_WID * 85/100+1.5,-5.5,-2.49]){
//     //     rotate(STRAP_CLIP_ANGLE,[0,1,0]){
//     //         cube([THK * 3.5, HOLE_SZ * 4/5, STRAP_TN],center=true);
//     //     }
//     // }

//     // // hook/flat parts on the other side
//     // translate([AL_WID * 85/100+5,5.5,-AL_TN - STRAP_TN]){
//     //     cube([THK * 3, HOLE_SZ * 4/5, STRAP_TN],center=true);
//     // }
//     // translate([AL_WID * 85/100+5, -5.5, -AL_TN - STRAP_TN]){
//     //     cube([THK * 3, HOLE_SZ * 4/5, STRAP_TN],center=true);
//     // }
// }
// //#################################################################################


// translate([0,1.5 * hole_sep,STRAP_TN + (AL_TN-OUTER_WALL_TN)]){
//     color("Wheat",1.0){al_strap();}
// }


// color("Lavender",1.0){
//     translate([0,0,(AL_TN - OUTER_WALL_TN)/2]){
//         cube([AL_WID,AL_LEN,AL_TN],center=true);
//     }
// }


// rotate(0,[0,0,1]){
//     translate([0,0,-AL_TN/2]){
//         rotate(180,[1,0,0]){
//             LED_module();
//         }
//     }
// }



// // place the iris in the holder
// difference(){
//     translate([0,0,2]){
//         iris();
//     }
//     // chop out a bit for a better view
//     translate([75,0,-30]){
//         cube([150,200,80],center=true);
//     }
// }




// // put a wee base under the chopped off bit
// #translate([0,0,-35.5]){
//     cylinder(h=2,r=70);
// }

