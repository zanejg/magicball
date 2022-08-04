include <Round-Anything/polyround.scad>

BOBBIN_RAD = 20;
BASE_RAD = 5;
POINT_HT = 30;
CONCAV = 1.5;
CONCAV_RAD = 20;

bobbin_pts = [
    [0,0,0],
    [BASE_RAD,0,0],
    [BOBBIN_RAD,POINT_HT/2,0],
    [(BOBBIN_RAD/2)-CONCAV,(POINT_HT*(3/4))-CONCAV,CONCAV_RAD],
    [0,POINT_HT,0],
];

rotate_extrude(){
    polygon(polyRound(bobbin_pts,50));
}
cylinder(h=2,r=85,$fn=6);

difference(){
    translate([0,0,-50]){
        cylinder(h=50,r=4,$fn=50);
    }
    translate([0,0,-51]){
        cylinder(h=51,r=2,$fn=50);
    }
}


