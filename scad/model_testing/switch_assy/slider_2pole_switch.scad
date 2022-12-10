// to model the 2-pole slider switch I have used as the 
// power switch in the magicball

$fn=60;

WHOLE_WD = 7.6;
WHOLE_LN = 23.4;
REC_HT = 7.8;
TAB_LN = 3.5;
TAB_TN = 0.3;
LEVER_RAD = 4.9/2;


module slider_2pole_switch(){
    // Main body
    color("black",1.0){
        difference(){
            cube([WHOLE_LN,WHOLE_WD,REC_HT], center=true);

            // chop away ends leaving tabs
            translate([(WHOLE_LN/2) - (TAB_LN/2), 0, -TAB_TN]){
                cube([(TAB_LN * 1.01), (WHOLE_WD * 1.1), REC_HT], center=true);
            }
            translate([-(WHOLE_LN/2) + (TAB_LN/2), 0, -TAB_TN]){
                cube([(TAB_LN * 1.2), (WHOLE_WD * 1.2), REC_HT], center=true);
            }

            // slider cavity 4.4X9.2
            translate([0,0,REC_HT/2-0.5]){
                cube([9.2, 4.4, 1.1], center=true);
            }

            // screwholes in tabs
            translate([WHOLE_LN/2 - 2.2, 0, REC_HT/2-1]){
                cylinder(h = 2, r = 1);
            }
            translate([-WHOLE_LN/2 + 2.2, 0, REC_HT/2-1]){
                cylinder(h = 2, r = 1);
            }

        }
    }


    // sliding lever
    translate([0, 0, REC_HT/2]){
        cylinder(h = 6.7, r = LEVER_RAD);
    }

    // tabs
    translate([0, 1.5, -(REC_HT/2 + 2.25)]){
        cube([2.0, 0.5, 4.5], center=true);
    }
    translate([0, -1.5, -(REC_HT/2 + 2.25)]){
        cube([2.0, 0.5, 4.5], center=true);
    }

    translate([4, 1.5, -(REC_HT/2 + 2.25)]){
        cube([2.0, 0.5, 4.5], center=true);
    }
    translate([4, -1.5, -(REC_HT/2 + 2.25)]){
        cube([2.0, 0.5, 4.5], center=true);
    }

    translate([-4, 1.5, -(REC_HT/2 + 2.25)]){
        cube([2.0, 0.5, 4.5], center=true);
    }
    translate([-4, -1.5, -(REC_HT/2 + 2.25)]){
        cube([2.0, 0.5, 4.5], center=true);
    }


    // simulate cables + heatshrink
    translate([0, 1.5,-(14 + REC_HT/2)]) {
        cylinder(h = 14, r = 2.5/2);
    }
    translate([0, -1.5,-(14 + REC_HT/2)]) {
        cylinder(h = 14, r = 2.5/2);
    }
    translate([4, 1.5,-(14 + REC_HT/2)]) {
        cylinder(h = 14, r = 2.5/2);
    }
    translate([4, -1.5,-(14 + REC_HT/2)]) {
        cylinder(h = 14, r = 2.5/2);
    }
}