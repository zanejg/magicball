//######################################################################
//  BATTERY holder   
include <model_testing/belkin_power_bank.scad>


PCB_ARM_TN = 4;
PCB_ARM_WD = 10;
PCB_ARM_YPOSI = -15;







NEG_CAV_SCALE = 1.0;

module top_battery_cup_vent(){
    points = [
        [-3, 15],
        [3, 15],
        [0,0]
    ];
    translate([0,BIG_RAD*1.2,0]){
        rotate([90,0,0]){
            linear_extrude(height= 30){
                polygon(points);
            }
        }
    }
}

//TOP_BATT_HOLDER_LIP = 4.5;







TOP_BATT_HOLDER_LIP = 4.5;
module top_battery_cup(){
    difference(){
        union(){
            // define the outer surface
            // rotate([0,90,0]){
            //     scale([1.1,1.1,1.05]){
            //         belkin_power_bank();
            //     }
            // }
            batt_fins();
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
        translate([-40,-BIG_RAD * 1.2,-95]){
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
                    cube([6,square_side,square_side * 0.8]);
                }
            }
        }
        // for(i=[0:15:BIG_RAD_LEN]){
        //     translate([i,0,0]){
        //         top_battery_cup_vent();
        //     }
        // }
        
        
        
        // // for a chopped out cross section
        // translate([-BIG_RAD * 3.2,-BIG_RAD * 1.2, -30]){
        //     cube([PACK_WIDTH*1.2,BIG_RAD*2.4,belkin_whole_len]);
        // }
        
    }
    // Connector tab
    TAB_LEN = 55;
    translate([41.5,18,TAB_LEN - 65]){
        translate([0,0,-7]){
            difference(){
                cube([PCB_ARM_TN,PCB_ARM_WD,TAB_LEN]);
            
                translate([-2,PCB_ARM_WD/2,TAB_LEN-PCB_ARM_WD/2-1]){
                    rotate(90,[0,1,0]){
                        cylinder(h=8,r=3/2);
                    }
                }
            }
        }
        // translate([-15,-PCB_ARM_TN -0.3 ,-7.0]){
        //     cube([30,PCB_ARM_TN * 1.1,PCB_ARM_WD]);
        // }
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



module batt_fins(){
    angles = [
        60,
        40,
        20,
        0,
        -20,
        -40,
        -60
    ];
    difference(){
        union(){
            translate([belkin_whole_len/2-5,18,-17]){ 
                rotate([0,0,180]){
                    for(ang=angles){
                        rotate([0,0,ang]){
                            translate([0,0,0]){
                                cube([3,70,55],center=false);
                            }
                        } 
                    }
                }
            }
            translate([-14,-14,-17]){ 
                cube([110,3,40],center=false);
            }
            translate([-14,-14,-17]){ 
                cube([110,3,40],center=false);
            }
        }
        translate([30,-38,0]){
            cube([150,40,80],center=true);
        }
        translate([-30,-20,5]){
            rotate([45,0,0]){
                cube([150,60,40]);
            } 
        }
    }
    
    

    // translate([39,17,-17]){ 
    //     cube([3,10,40],center=false);
    // }

}








top_battery_cup();
