
include <Round-Anything/polyround.scad>

$fn=20;
shldr_cube = 2.5;
arm_ht = 7.5;
bot_2_cube_top = 5.6;
spike_wd = 0.64;
bend_rad = 1.2;

size_mod = 0.05; // to ensure the shapes actually overlap not 
                // exactly touch

spike_points = [
    [-(spike_wd/2),0,0],
    [-(spike_wd/2),arm_ht,bend_rad],
    [arm_ht-(spike_wd/2),arm_ht+(spike_wd/2),0],
    [arm_ht-(spike_wd/2),arm_ht-(spike_wd/2),0],
    [(spike_wd/2),arm_ht-spike_wd,bend_rad-spike_wd],
    [(spike_wd/2),0,0],
];


// create one spike of the connector
module bent_conn_spike(){
    
    translate([-spike_wd/2,0,0]){
        rotate(90,[0,0,1]){
            rotate(90,[1,0,0]){
                linear_extrude(height=spike_wd){
                    polygon(polyRound(spike_points));
                }
            }
        }
    }
    
    cbhf = (shldr_cube + size_mod)/2;
    cb_rad = 0.35;
    cbxy = [
        [cbhf,cbhf,cb_rad],
        [cbhf,-cbhf,cb_rad],
        [-cbhf,-cbhf,cb_rad],
        [-cbhf,cbhf,cb_rad],
    ];
    
    translate([0,0,bot_2_cube_top-(shldr_cube)]){
        linear_extrude(height=shldr_cube){
            polygon(polyRound(cbxy,$fn=20));
        }
    }

    // cube(shldr_cube,center=true);
}


bent_conn_spike();
