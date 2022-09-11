$fn=30;

BRD_TN = 1.5;
PARALLEL_SIDES= 20;
HOLE_SEP = 16;
HOLE_RAD = 3.8/2;

base_rad = PARALLEL_SIDES/(cos(30) * 2);
hole_rad = HOLE_SEP/2 + HOLE_RAD;
module LED_module(){
    // HEX PCB
    rotate(30,[0,0,1]){
        difference(){
            cylinder(h=BRD_TN, r=base_rad, $fn=6);
            for(i=[0:60:300]){
                rotate(i,[0,0,1]){
                    translate([hole_rad,0,-0.1]){
                        cylinder(h=BRD_TN*1.2, r=HOLE_RAD);
                    }
                }
            }
        }
    }

    // center LED cylinder base
    difference(){
        cylinder(h=4, r=8/2);

        translate([7/2+1.5,0,2.01+BRD_TN]){
            cube([3,10,4],center=true);
        }
        translate([-7/2-1.5,0,2.01+BRD_TN]){
            cube([3,10,4],center=true);
        }
    }
    // LED hemisphere
    translate([0,0,4]){
        sphere(4.8/2);
    }

    // legs
    LEG_LEN=4.3;
    module leg(){
        difference(){
            cube([LEG_LEN, 1, 1.4],center=true);
            translate([-2.2+1.25, 0, 0.2]) {
                cube([2.5, 1.10, 1.4],center=true);    
            }
            translate([3.0-1.25, 0, -0.2]) {
                cube([2.5, 1.10, 1.4],center=true);    
            }
        }
    }

    translate([-7/2-LEG_LEN/2,0,1.5+0.7]){
        leg();
    }
    translate([-7/2-LEG_LEN/2,1.8,1.5+0.7]){
        leg();
    }
    translate([-7/2-LEG_LEN/2,-1.8,1.5+0.7]){
        leg();
    }


    rotate(180,[0,0,1]){
        translate([-7/2-LEG_LEN/2,0,1.5+0.7]){
            leg();
        }
        translate([-7/2-LEG_LEN/2,1.8,1.5+0.7]){
        leg();
        }
        translate([-7/2-LEG_LEN/2,-1.8,1.5+0.7]){
            leg();
        }
    }
}