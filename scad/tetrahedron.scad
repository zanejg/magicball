
$fn =3;

inner_edge = 300;
clip_edge = inner_edge * (13/8);




module tetrahedron(edge){
    ht = sqrt(2/3)*edge;
    rad = edge/(sqrt(3));

    cylinder(h=ht,r1=rad,r2=0);
}

intersection(){
    tetrahedron(inner_edge);
    translate([0,0,clip_edge * (21/64)]){
        rotate(180,[0,1,0]){
            tetrahedron(clip_edge);
        }
    }
}



