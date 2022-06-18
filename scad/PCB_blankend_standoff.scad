
$fn=60;
RAD=7.5/2;
HOLE_RAD=4.2/2;

module standoff(leng){
    difference(){
        cylinder(h=leng,r=RAD,center=true);
        cylinder(h=leng*1.1,r=HOLE_RAD,center=true);
    }
}

standoff(11.0);

