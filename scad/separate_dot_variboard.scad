

HOLE_RAD = 1.2/2;
BRD_THICKNESS = 1.5;
DUAL_PAD_THICKNESS = 0.1;
PAD_RAD=2.2/2;
HOLE_DIST = 2.54;

$fn=10;

module pads(x,y){
    translate([x,y,0]){
        cylinder(r=PAD_RAD,h=BRD_THICKNESS+DUAL_PAD_THICKNESS,center=true);
    }
}
module thru_hole(x,y){
    translate([x,y,0]){
        cylinder(r=HOLE_RAD,h=BRD_THICKNESS*1.2,center=true);
    }
}

module board(wid,len){
    cube([wid,len,BRD_THICKNESS],center=true);
}



module dual_variboard(wid,len,wborder,lborder){
    iwid = wid-(2*wborder);
    ihf_wid = iwid/2;
    ilen=len-(2*lborder);
    ihf_len = ilen/2;
    echo(str("cols = ", len(  [for(i = [-ihf_wid:HOLE_DIST:ihf_wid])i] )));
    echo(str("lines = ", len(  [for(i = [-ihf_len:HOLE_DIST:ihf_len])i] )));

    difference(){
        union(){
            board(wid,len);

            // for(thisx = [-ihf_wid:HOLE_DIST:ihf_wid]){
            //     for(thisy = [-ihf_len:HOLE_DIST:ihf_len]){
            //         pads(thisx,thisy);
            //     }
            // }
        }
        
        for(thisx = [-ihf_wid:HOLE_DIST:ihf_wid]){
            
            for(thisy = [-ihf_len:HOLE_DIST:ihf_len]){
                thru_hole(thisx,thisy);
            }
        }
    }
}


//dual_variboard(150,90,7.5,4);

dual_variboard(25,25,0,0);
