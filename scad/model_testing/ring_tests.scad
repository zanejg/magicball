
$fn=60;

cube([100,100,2],center=true);

module ring(ht,rad,tn){
    difference(){
        cylinder(h=ht,r=rad);
        cylinder(h=ht,r=rad-tn);
    }
}

ring(5,40,2);
ring(5,42.1,2);
ring(5,44.2,2);
ring(5,46.3,2);
ring(5,48.4,2);
