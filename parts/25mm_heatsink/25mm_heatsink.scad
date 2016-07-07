/*
    25mmx25mm Finned Heatsink
*/

use <../../lib/geometric.scad>

W = 25.0;
D = 25.0;
H_BASE = 1.8;
H_PINS = 2.0;
H_TOTAL = 9.4;

PIN_BASE_W = 1.6;
PIN_TIP_W = 1.1;
PIN_D = 1.5;
PIN_STEP = 2.4;
PINS_X = 7;
PINS_Y = 7;

module row(){
    cube([PIN_D,W,H_PINS]);
    for (i=[0:(D-PIN_BASE_W)/(PINS_Y-1):D-PIN_BASE_W]){
        translate([0,i,H_PINS])
          fwedge(PIN_D, PIN_BASE_W, H_TOTAL-H_PINS, PIN_TIP_W);
    }
}
render(){
    translate([-W/2, -D/2, 0]){
        for (i=[0:PIN_D+PIN_STEP:W]){
            translate([i,0,0])
              row();
        }
        cube([W,D,H_BASE]);
    }
}
