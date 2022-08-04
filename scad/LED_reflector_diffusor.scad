include <Round-Anything/polyround.scad>

$fn=50;

OUTER_RAD = 62;
INNER_RAD = 12;

OUTER_PEAK = 10;
INNER_PEAK = 4;

TOOTH_HT = 2.5;
tooth_wd = (OUTER_RAD-INNER_RAD)/16;
CONCAVE_RAD = 40;


CONCAV = 1;

delta_tooth_ht = (OUTER_PEAK - INNER_PEAK) /  
                    ((OUTER_RAD-INNER_RAD)/(tooth_wd ));

fresnel_pts = [
    // base & ENDS
    [OUTER_RAD,OUTER_PEAK,0],
    [OUTER_RAD,0,0],
    [INNER_RAD,0,0],
    [INNER_RAD,INNER_PEAK-TOOTH_HT,0],
    // TEETH
    [INNER_RAD+(tooth_wd /2)+CONCAV,
        INNER_PEAK-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+tooth_wd ,INNER_PEAK,0],
    [INNER_RAD+(2*tooth_wd ),(INNER_PEAK+(delta_tooth_ht))-TOOTH_HT,0],

    [INNER_RAD+(2*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(3*tooth_wd ),(INNER_PEAK+(2*delta_tooth_ht)),0],
    [INNER_RAD+(4*tooth_wd ),(INNER_PEAK+(3*delta_tooth_ht))-TOOTH_HT,0],

    [INNER_RAD+(4*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(3*delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(5*tooth_wd ),(INNER_PEAK+(4*delta_tooth_ht)),0],
    [INNER_RAD+(6*tooth_wd ),(INNER_PEAK+(5*delta_tooth_ht))-TOOTH_HT,0],




    [INNER_RAD+(6*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(5*delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(7*tooth_wd ),(INNER_PEAK+(6*delta_tooth_ht)),0],
    [INNER_RAD+(8*tooth_wd ),(INNER_PEAK+(7*delta_tooth_ht))-TOOTH_HT,0],

    [INNER_RAD+(8*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(7*delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(9*tooth_wd ),(INNER_PEAK+(8*delta_tooth_ht)),0],
    [INNER_RAD+(10*tooth_wd ),(INNER_PEAK+(9*delta_tooth_ht))-TOOTH_HT,0],

    [INNER_RAD+(10*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(9*delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(11*tooth_wd ),(INNER_PEAK+(10*delta_tooth_ht)),0],
    [INNER_RAD+(12*tooth_wd ),(INNER_PEAK+(11*delta_tooth_ht))-TOOTH_HT,0],

    [INNER_RAD+(12*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(11*delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(13*tooth_wd ),(INNER_PEAK+(12*delta_tooth_ht)),0],
    [INNER_RAD+(14*tooth_wd ),(INNER_PEAK+(13*delta_tooth_ht))-TOOTH_HT,0],

    [INNER_RAD+(14*tooth_wd )+(tooth_wd /2)+CONCAV,
        (INNER_PEAK+(13*delta_tooth_ht))-(TOOTH_HT/2)-CONCAV,
        CONCAVE_RAD],
    [INNER_RAD+(15*tooth_wd ),(INNER_PEAK+(14*delta_tooth_ht)),0],
    [INNER_RAD+(16*tooth_wd ),(INNER_PEAK+(15*delta_tooth_ht))-TOOTH_HT,0],

];



LINE_RADIAL_PTS = [
    [tooth_wd,OUTER_PEAK/2],
    [tooth_wd,-OUTER_PEAK/2],
    [-tooth_wd,-OUTER_PEAK/2],
    [-tooth_wd,OUTER_PEAK/2],
    [-tooth_wd + (tooth_wd),OUTER_PEAK/2-TOOTH_HT],
    [-tooth_wd + (2*tooth_wd),OUTER_PEAK/2],
    // [-tooth_wd + (3*tooth_wd),OUTER_PEAK-TOOTH_HT],
    // [-tooth_wd + (4*tooth_wd),OUTER_PEAK],

];


module radial_shape(len){
    linear_extrude(height = len){
        polygon(LINE_RADIAL_PTS);
    }
}

module radial_reflector(){
    translate([0,OUTER_RAD,OUTER_PEAK/2]){
        rotate(100,[1,0,0]){
            radial_shape(OUTER_RAD-INNER_RAD);
        }
    }
}

module outer_radial_reflector(){
    translate([0,OUTER_RAD,OUTER_PEAK/2]){
        rotate(100,[1,0,0]){
            radial_shape(OUTER_RAD/3);
        }
    }
}
//radial_reflector(20);

ROT_STEP = 30;

module diffuser(){
    difference(){
        union(){
            difference(){
                rotate_extrude(){
                    polygon(polyRound(fresnel_pts,50));
                }
                for(deg=[0:ROT_STEP:360]){
                    rotate(deg,[0,0,1]){
                        cube([OUTER_RAD*2.5,tooth_wd*2,OUTER_PEAK*2.5],center=true);
                        rotate(ROT_STEP/2,[0,0,1]){
                            translate([OUTER_RAD * (5/6),0,0]){
                                cube([OUTER_RAD/3,tooth_wd*2,OUTER_PEAK*2.5],center=true);
                            }
                        }
                    }
                }
            }
            for(deg=[0:ROT_STEP:360]){
                rotate(deg,[0,0,1]){
                    radial_reflector();
                    rotate(ROT_STEP/2,[0,0,1]){
                        outer_radial_reflector();
                    }
                }
            }
        }

        translate([0,0,-OUTER_PEAK*2]){
            cylinder(h=OUTER_PEAK*2,r=OUTER_RAD*1.1);
        }

    }
}



//diffuser();