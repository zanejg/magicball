
$fn=30;

hole_rad = 3.2/2;
outer_rad = 5.4/2;

difference(){
    cylinder(8.0,outer_rad, outer_rad,center=true);
    cylinder(9,hole_rad, hole_rad,center=true);
}

