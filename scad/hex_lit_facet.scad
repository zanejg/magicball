include <Round-Anything/polyround.scad>

RADIUS = 85;
PLATE_TN = 4;

cylinder(h=PLATE_TN,r=RADIUS,$fn=6);

difference(){
    translate([0,0,RADIUS/5]){
        sphere(r=RADIUS/3);
    }
    translate([0,0,RADIUS/2 + PLATE_TN]){
        cube([RADIUS,RADIUS,RADIUS],center=true);
    }
}