include <binary_tree.scad>
include <iris_cap01.scad>

$fn=100;

// facet stuff
RND_FACET_RAD = 118;
RAD = 100;
WID = 10;
THK = 1.5;
CENTER_HT= 60;
OUTER_WALL_TN = 2;


TREE_INNER_RAD = 68;
TREE_TN = 3;
TREE_HT = 34;
TREE_BASE = 4;
TREE_LEVELS = 4;
tree_outer_rad = TREE_INNER_RAD+TREE_TN;
SUPPORT_HT = -35;
SUPPORT_RING_HT = 3;
tree_ht=(SUPPORT_HT+(SUPPORT_RING_HT*1.45))*-1;

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
                    
                    translate([0,0,-60]){
                        cube([250,250,50],center=true);
                    }
                    

                }

                // the support trees
                for(i = [0:5]){
                    rotate((60* i),[0,0,1]){
                        intersection(){
                            difference(){
                                translate([0,-(TREE_INNER_RAD+TREE_TN/2),0]){
                                    rotate(180,[1,0,0]){
                                        make_tree(tree_ht,TREE_LEVELS,TREE_BASE,22);
                                    }
                                }
                                translate([0,0,-tree_ht*1.1]){
                                    cylinder(h=tree_ht*1.2,r=TREE_INNER_RAD,$fn=40);
                                }
                            }
                            translate([0,0,-tree_ht*1.1]){
                                cylinder(h=tree_ht*1.2,r=tree_outer_rad,$fn=40);
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
        translate([0,0,SUPPORT_HT+SUPPORT_RING_HT/2]){
            difference(){
                cylinder(h=SUPPORT_RING_HT,r=tree_outer_rad);
                translate([0,0,-.5])
                cylinder(h=4,r=TREE_INNER_RAD);
            }
        }
    }

    // translate([0,-100,-60]){
    //     cube([150,200,100]);
    // }
}
// translate([0,0,0]){
//     iris();
// }

// // put a wee base under the chopped off bit
// #translate([0,0,-35.5]){
//     cylinder(h=2,r=70);
// }

