$fn=60;
ROTARY_SHAFT_HOLE_RD = 8/2;
SELF_TAP_HOLE_RD = 2.2/2;
POW_SW_HOLE_RD = 3.2/2;
PUSH_BUTTON_HOLE_RD = 13.2/2;

TN = 4;
zof = -TN+1.5;

difference(){
    cube([50,30, TN], center=true);

    // button hole
    translate([0,0,zof]){
        cylinder(h = TN + 1, r = PUSH_BUTTON_HOLE_RD);
    }
    // self tapper hole
    translate([20,10,zof]){
        cylinder(h = TN + 1, r = SELF_TAP_HOLE_RD);
    }
    // rotary shaft hole
    translate([15,-7,zof]){
        cylinder(h = TN + 1, r = ROTARY_SHAFT_HOLE_RD);
    }

    // test m2.5 bush holes
    translate([-20,10,zof]){
        cylinder(h = TN + 1, r = POW_SW_HOLE_RD - 0.2);
    }
    translate([-20,0,zof]){
        cylinder(h = TN + 1, r = POW_SW_HOLE_RD);
    }
    translate([-20,-10,zof]){
        cylinder(h = TN + 1, r = POW_SW_HOLE_RD + 0.2);
    }


}