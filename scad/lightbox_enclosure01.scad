

OUTER_WIDTH = 40;
WALL_THICKNESS = 2;

inner_width = OUTER_WIDTH -(WALL_THICKNESS*2);
difference(){
    difference(){
        cube([OUTER_WIDTH,OUTER_WIDTH,OUTER_WIDTH/2],center=true);
        translate([0,0,WALL_THICKNESS]){
            cube([inner_width,inner_width,inner_width/2],center=true);
        }
    }
    translate([0,OUTER_WIDTH/2,(OUTER_WIDTH/2)-10]){
        cube([12,5,20],center=true);
    }
}


