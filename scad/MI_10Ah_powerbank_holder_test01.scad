

RAD = 15/2;
MAIN_LEN = 115;
TOT_WIDTH = 75;

cyl_offset = (TOT_WIDTH - (2*RAD) )/2;

difference(){
    hull(){
        translate([cyl_offset,0,0]){
            cylinder(3,RAD+2,RAD+2,center=true);
        }
        translate([-cyl_offset,0,0]){
            cylinder(3,RAD+2,RAD+2,center=true);
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
