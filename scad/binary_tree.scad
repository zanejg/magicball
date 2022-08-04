
// make a tree of TN thick cubes of NUM LEVEL levels, HT high

sqrt2 = sqrt(2);


function get_half_width(num_levels,ht,level=1) = 
    num_levels < num_levels
        ? ((1/pow(2,level)) * ht) + get_half_width(num_levels,ht,level+1)
        : ((1/pow(2,level)) * ht);

module make_branch_fork(layer_ht,wid,tn){
    // makes a 45 deg tilted branch of length leng,
    // width wid and
    // with base at 0,0 and ends trimmed flat
    leng = layer_ht * sqrt2+ (wid /sqrt2);
    difference(){
        // the 2 branches
        thin_wd = wid/2;
        tapered_branch_pts = [
            [-thin_wd/2,leng/2],
            [thin_wd/2,leng/2],
            [wid/2,-leng/2],
            [-wid/2,-leng/2]
        ];
        union(){
            rotate(45,[0,1,0]){
                translate([0,tn/2,leng/2]){
                    //cube([wid,tn,leng],center=true);
                    rotate(90,[1,0,0]){
                        linear_extrude(height=tn){
                            polygon(tapered_branch_pts);
                        }
                    }
                }
            }
            rotate(-45,[0,1,0]){
                translate([0,tn/2,leng/2]){
                    //cube([wid,tn,leng],center=true);
                    rotate(90,[1,0,0]){
                        linear_extrude(height=tn){
                            polygon(tapered_branch_pts);
                        }
                    }
                }
            }
        }

        // trim the ends flat
        translate([0,0,((wid/2)*sqrt2*1.1)/-2]){
            cube([wid*sqrt2*1.1,tn*1.1,(wid/2)*sqrt2*1.1],center=true);
        }
        translate([layer_ht/sqrt2+wid*sqrt2*1.3-wid/sqrt2,
                    0,
                    ((wid/2)*sqrt2*1.5)/2 + layer_ht]){
            cube([wid*sqrt2*1.5,tn*1.1,(wid/2)*sqrt2*1.5],center=true);
        }
        translate([-layer_ht/sqrt2-wid*sqrt2*1.3+wid/sqrt2,
                    0,
                    ((wid/2)*sqrt2*1.5)/2 + layer_ht]){
            cube([wid*sqrt2*1.5,tn*1.1,(wid/2)*sqrt2*1.5],center=true);
        }
    }
}

//######################################################
// from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Add_all_values_in_a_list
function sum(v) = [for(p=v) 1]*v;

function fst_ht(ht,lnum) =
    pow(2,(lnum-1))/((pow(2,lnum) -1)) * ht;

function make_ht_seq(ht,lnum) = 
    lnum > 1 
    ? concat([fst_ht(ht,lnum)],make_ht_seq(ht-fst_ht(ht,lnum),lnum-1))
    :[ht];

echo("HTSEQQQ:",make_ht_seq(10,3));

function chop_off_end(the_list) = 
    len(the_list)>1
    ? [for(i = [0:len(the_list)-2] ) the_list[i]]
    : [];

//echo("CHOP:",chop_off_end([1,2,3,4]));

function make_posi_seq(htseq) = 
    len(htseq) > 1 
    ? concat(make_posi_seq(chop_off_end(htseq)),[sum(htseq)])
    :[0,htseq[0]];
//echo("POSI:",make_posi_seq([1,2,3,4]));
//###################################################################






// module make_whole_tree(ht,num_levels,wid,tn){

module make_tree(ht,num_levels,wid,tn){
    // need to calc the heights of each fork layer
    // assuming that each layer is half the height 
    // of the previous one

    
    whole_seq = make_ht_seq(ht,num_levels);
    whole_posi_seq = make_posi_seq(whole_seq);
    echo("WHOLE ht:",whole_seq);
    echo("WHOLE posi:",whole_posi_seq);

    echo("sum=",0.333333+ 0.166667+ 0.0833333);

    for(layer_num = [0:num_levels-1]){
        wid_coeff = 1/pow(2,layer_num);
        this_ht = whole_seq[layer_num];
        ht_posi = whole_posi_seq[layer_num];

        for(fork_num = [1:pow(2,layer_num)]){
            translate([ht_posi - (fork_num-1)*4*this_ht ,0,ht_posi]){
                make_branch_fork(this_ht,wid*wid_coeff,tn);
            }
        }
    }
}

// intersection(){
//     difference(){
//         make_tree(HT,NUM_LEVELS+1,BASE_WD,30);
//         translate([0,-75,-1]){
//             cylinder(h=120,r=80);
//         }
//     }
//     translate([0,-75,-1]){
//         cylinder(h=120,r=83);
//     }
// }
// cube([40,40,2],center=true);
