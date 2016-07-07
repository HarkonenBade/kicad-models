use <../../lib/geometric.scad>
use <../../lib/pins.scad>

module JST_XHP_xx(N, A, B, C){
    HEIGHT = 7.75;
    INNER_DEPTH = 4.1;
    OUTER_DEPTH = 5.7;
    
    WALL = (OUTER_DEPTH-INNER_DEPTH)/2;
    
    SIDE = (C-A)/2;
    
    HOLE_DIAM = 1.8;
    HOLE_DROP = 2.35;
    
    difference(){
        union(){
            translate([WALL,WALL,0])
              cube([B,INNER_DEPTH,HEIGHT]);
            translate([0,0,HEIGHT-WALL])
              cube([C,INNER_DEPTH+WALL,WALL]);
            translate([SIDE,INNER_DEPTH+WALL,HEIGHT-WALL])
              cube([A,WALL,WALL]);
        }
        for (i=[0:A/(N-1):A]){
            translate([SIDE+i-(HOLE_DIAM/2),
                       OUTER_DEPTH-HOLE_DROP-(HOLE_DIAM/2),
                       0]){
                cube([HOLE_DIAM,HOLE_DIAM,HEIGHT]);
            }
        }
    }
    corner = sqrt(2*HOLE_DIAM*HOLE_DIAM)/2;
    for (i=[0:A/(N-1):A]){
        translate([SIDE+i,
                   OUTER_DEPTH-HOLE_DROP,
                   HEIGHT]){
            cylinder(20,corner,corner,$fn=12);
        }
    }
}

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
    translate([9.9-2.45,1.45+0.8,0.4])
    rotate([-90,0,0])
    rotate([0,0,180])
      JST_XHP_xx(3, 5.0, 8.2, 9.8);
}