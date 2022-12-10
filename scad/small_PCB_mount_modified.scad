
include <PCB_assy_mnt.scad>


PCB_LATERAL_OFFSET = 21;
PCB_HOLDER_HT = 3;
PCB_ARM_TN = 4;
PCB_ARM_WD = 10;
PCB_ARM_YPOSI = -15;

SMPCB_LATERAL_OFFSET = 32;



module small_PCB_mount(){
    translate([0, SMPCB_LATERAL_OFFSET, PCB_HOLDER_HT]) {
        // PCB mount
        PCB_mount(STANCHION_HT, rpi_coords);    
        // diagonal connector along short side
        translate([-rpi_coords[0][0] - PCB_ARM_TN*1.1, 15, 0]) {
            rotate(45,[1,0,0]){
                cube([PCB_ARM_TN,25,PCB_ARM_WD]);    
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
        translate([rpi_coords[0][0],(rpi_coords[0][1] + PCB_ARM_TN*0.4) - 19 , 0]) {
            rotate(-48,[0,1,0]){
                cube([23,PCB_ARM_WD,PCB_ARM_TN]);    
            }
        }
        // flat connector on long side
        translate([rpi_coords[0][0]+19, -1, 18]) {
            difference(){
                cube([20,PCB_ARM_WD,PCB_ARM_TN],center=true);
                translate([10-(PCB_ARM_WD/2),0,-4]){
                    cylinder(r=3/2,h=8);
                }
            }
        }
    }
}


small_PCB_mount();