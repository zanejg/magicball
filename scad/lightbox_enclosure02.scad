

OUTER_WIDTH = 45;
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


module catch(){
    rotate(45,[1,0,0]){
        cube([30,3,3],center=true);
    }
}

translate([0,(OUTER_WIDTH/2)-1.5,-3]){
    catch();
}
translate([0,(-OUTER_WIDTH/2)+1.5,-3]){
    catch();
}