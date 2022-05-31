$fn=20;


module one_watt_resistor(){
    BODY_RAD = 4.5/2;
    WIRE_RAD = 0.75/2;
    TIP2TIP=13;

    hull(){
        translate([-(TIP2TIP/2-BODY_RAD),0,0]){
            sphere(r=BODY_RAD);
        }
        translate([(TIP2TIP/2-BODY_RAD),0,0]){
            sphere(r=BODY_RAD);
        }

    }
    rotate(90,[0,1,0]){
        cylinder(r=WIRE_RAD,h=25.6,center=true);
    }
}

module quarter_watt_resistor(){
    BODY_RAD = 2.25/2;
    WIRE_RAD = 0.5/2;
    TIP2TIP=6.3;
    INCH = 25.6;

    hull(){
        translate([-(TIP2TIP/2-BODY_RAD),0,0]){
            sphere(r=BODY_RAD);
        }
        translate([(TIP2TIP/2-BODY_RAD),0,0]){
            sphere(r=BODY_RAD);
        }

    }
    rotate(90,[0,1,0]){
        cylinder(r=WIRE_RAD,h=INCH/2,center=true);
    }
}

quarter_watt_resistor();

