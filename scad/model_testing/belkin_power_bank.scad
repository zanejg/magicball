



BIG_RAD = 25.3/2;
SMALL_RAD=21/2;

BIG_RAD_LEN = 75;
TAPER_LEN=12.5;

belkin_whole_len = BIG_RAD_LEN + 2 * TAPER_LEN;

PACK_WIDTH = 65;
side_dist = PACK_WIDTH - (BIG_RAD * 2);



module pack_side(){
    cylinder(h=BIG_RAD_LEN, r=BIG_RAD);
    translate([0,0,BIG_RAD_LEN]){
        cylinder(h=TAPER_LEN, r1=BIG_RAD, r2=SMALL_RAD);
    }
    translate([0,0,-TAPER_LEN]){
        cylinder(h=TAPER_LEN, r2=BIG_RAD, r1=SMALL_RAD);
    }
}

module belkin_power_bank(){
    hull(){
        pack_side();
        translate([side_dist,0,0]){
            pack_side();
        }
    }
}