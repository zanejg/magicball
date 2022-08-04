

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


module catch(){
    rotate(45,[1,0,0]){
        rotate(90,[0,1,0]){
            cube([3,3,5]);
        }
    }
}

translate([10,(OUTER_WIDTH/2)-3,(OUTER_WIDTH/4)-3]){
    catch();
}
translate([-10-2.5,(OUTER_WIDTH/2)-3,(OUTER_WIDTH/4)-3]){
    catch();
}

translate([10,(-OUTER_WIDTH/2)-1.5,(OUTER_WIDTH/4)-3]){
    catch();
}
translate([-10-2.5,(-OUTER_WIDTH/2)-1.5,(OUTER_WIDTH/4)-3]){
    catch();
}
