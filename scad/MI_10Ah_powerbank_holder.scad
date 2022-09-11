
$fn=60;

RAD = 15/2;
MAIN_LEN = 115;
TOT_WIDTH = 74.5;
RING_HT=15;
RING_TN = 2;
SCREW_BLOCK_WD = 8;

ARM_THICKNESS = 5;
cyl_offset = (TOT_WIDTH - (2*RAD) )/2;

module holding_ring(ring_ht){

    difference(){
        hull(){
            translate([cyl_offset,0,0]){
                cylinder(ring_ht,RAD+RING_TN,RAD+RING_TN,center=true);
            }
            translate([-cyl_offset,0,0]){
                cylinder(ring_ht,RAD+RING_TN,RAD+RING_TN,center=true);
            }

        }

        hull(){
            translate([cyl_offset,0,0]){
                cylinder(MAIN_LEN,RAD,RAD,center=true);
            }
            translate([-cyl_offset,0,0]){
                cylinder(MAIN_LEN,RAD,RAD,center=true);
            }

        }
        
    }
}

module batt_ring_assy(ht){
    difference(){
        union(){
            holding_ring(ht);
            translate([cyl_offset-RAD,RAD+(SCREW_BLOCK_WD/2),0]){
                cube([SCREW_BLOCK_WD,SCREW_BLOCK_WD-2,ht],center=true);
            }
        }
        #translate([cyl_offset-RAD,RAD+(SCREW_BLOCK_WD/2),3]){
            rotate(90,[1,0,0]){
                cylinder(h=8,r=4.2/2,center=true);
            }
        }
    }
}

