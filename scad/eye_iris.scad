
COEFF = 0.18;

intersection(){
    !scale([COEFF, COEFF, 0.2]){
        surface(file = "eye_iris01.png", center = true, invert = true);
    }
    translate([0,0,0]){
        cylinder(h=80, r=75,center=true);
    }
}
