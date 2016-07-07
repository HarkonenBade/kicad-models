/*
    Pins Lib
    
    Variety of pins for connectors
*/

use <geometric.scad>

/*
    Bend
    
    Right angle bend in a cuboid.
    Centered on (0,0)
    Open sides face +Y and +Z
    
    x - Size in X
    yz - Size in Y and Z
*/
module bend(x, yz){
    rotate([180,0,0])
      rotate([0,-90,0])
        translate([-yz/2,-yz/2,-x/2]){
            intersection(){
                rotate_extrude(angle=90, $fn=48)
                  square([yz, x]);
                cube([yz,yz,x]);
            }
        }
}

/*
    Straight Pin

    Standard straight pin with chiseled tip
    Centered on (0,0), base rests on XY plane, tip points upwards

    l - Length of pin
    wx - Width in X
    wy - Width in Y
*/
module pin(l, wx, wy){
    apex_h = (wx+wy)/2;
    rem_h = l-apex_h;
    translate([0,0,rem_h/2]) cube([wx,wy,rem_h], true);
    translate([0,0,rem_h]) sq_pyr(wx, wy, apex_h, 0.25);
}

/*
    Right angled pin

    Right angled pin with chiseled tips
    Right angle bend centered on (0,0,0) pin extends along +Y and -Z.

    l - Length of pin along +Y
    h - Height of pin along -Z
    wx - Pin Width in X
    wy - Pin Width in Y (Z for horizontal part)
*/
module r_pin(l, h, wx, wy){
    l_t = l-wy/2;
    h_t = h-wy/2;
    rotate([-90,0,0]){
        translate([0,0,wy/2]) pin(l_t,wx,wy);
        bend(wx,wy);
    }
    translate([0,0,-wy/2]) rotate([180,0,0]) pin(h_t,wx,wy);
}