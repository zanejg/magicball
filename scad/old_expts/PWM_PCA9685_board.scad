include <Round-Anything/polyround.scad>
include <strip_connector_male.scad>


$fn=20;
WIDTH = 25.1;
LENGTH = 62.2;
DEPTH = 1.5;
HOLE_RAD = 2.7/2;
PWR_HOLE_RAD = 0.9/2;


brd_points =[
    [WIDTH/2, LENGTH/2, 2.5],
    [WIDTH/2, -LENGTH/2, 2.5],
    [-WIDTH/2, -LENGTH/2, 2.5],
    [-WIDTH/2, LENGTH/2, 2.5],
];

hole_points=[
    [brd_points[0][0]-3,brd_points[0][1]-3],
    [brd_points[1][0]-3,brd_points[1][1]+3],
    [brd_points[2][0]+3,brd_points[2][1]+3],
    [brd_points[3][0]+3,brd_points[3][1]-3],
]; 


// PCB
difference(){
    // actual board
    linear_extrude(height=DEPTH){
        polygon(polyRound(brd_points));
    }
    // mounting holes
    for(hp=hole_points){
        translate([hp[0],hp[1],-1]){
            cylinder(r=HOLE_RAD,h=3);
        }
    }

    // power connection holes
    translate([-(WIDTH/2)+3.5,(LENGTH/2)-29,-1]){
        cylinder(r=PWR_HOLE_RAD,h=3);
    }
    translate([-(WIDTH/2)+3.5,(LENGTH/2)-32.5,-1]){
        cylinder(r=PWR_HOLE_RAD,h=3);
    }
    



}

// PWM output connectors
translate([(WIDTH/2)-6,-((LENGTH/2)-7.5),DEPTH]){
    matrix_male_connector(3,4);
}

translate([(WIDTH/2)-6,-((LENGTH/2)-19.5),DEPTH]){
    matrix_male_connector(3,4);
}

translate([(WIDTH/2)-6,((LENGTH/2)-14.5),DEPTH]){
    matrix_male_connector(3,4);
}
translate([(WIDTH/2)-6,((LENGTH/2)-27),DEPTH]){
    matrix_male_connector(3,4);
}

// comms connectors
translate([(WIDTH/2)-6,-(LENGTH/2)+1.5,-DEPTH]){
    rotate(180,[0,0,1]){
        bent_multi_male_connector(6);
        //multi_male_connector(6);
    }
}
