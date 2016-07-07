use <../../lib/geometric.scad>
use <../../lib/pins.scad>

module JST_SxxB_XH_A(N, A, B){
    HEIGHT = 6.1;
    DEPTH = 11.5;
    DEPTH_NO_TAG = 7.0;
    WALL = 0.8;
    
    PIN_DROP = 2.35;
    PIN_LEN = 9.2;
    PIN_DEPTH = 3.4;
    PIN_DIAM = 0.64;
    
    INNER_W = B-(WALL*2);
    INNER_D = DEPTH_NO_TAG-WALL;
    INNER_H = HEIGHT-(WALL*2);
    
    TAG_DEPTH = DEPTH-DEPTH_NO_TAG;
    
    PIN_SIDE = (B-A)/2;
    
    translate([-PIN_SIDE,PIN_LEN-DEPTH_NO_TAG,0]){
        difference(){
            cube([B,DEPTH_NO_TAG,HEIGHT]);
            translate([WALL,WALL,WALL])
              cube([INNER_W,INNER_D,INNER_H]);
        }
        for (i = [0, B-WALL]){
            translate([i,-TAG_DEPTH,0]){
                translate([0,TAG_DEPTH,HEIGHT*3/6])
                    mirror([0,1,0])
                        wedge(WALL,
                              TAG_DEPTH,
                              HEIGHT*2/6);
                cube([WALL,TAG_DEPTH,HEIGHT*3/6]);
            }
        }
    }
    translate([0,0,HEIGHT-PIN_DROP]){
        for (i = [0:A/(N-1):A]){
            translate([i,0,0])
                r_pin(PIN_LEN,
                      HEIGHT-PIN_DROP+PIN_DEPTH,
                      PIN_DIAM,
                      PIN_DIAM);
        }
    }
}

render(){
    JST_SxxB_XH_A(3,5.0,9.9);
}