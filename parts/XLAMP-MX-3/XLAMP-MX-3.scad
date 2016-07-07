/*
    XLAMP-MX-3 LED Module
*/
use <../../lib/geometric.scad>

h = 1.35;
w = 5.0;
cr = 0.5;

lens_w = 4.65;
lens_rad = 0.875;
render(){
    difference(){
        rounded_box(w,w,h,cr);
        translate([0,0,h-0.05]){
            rounded_box(lens_w, lens_w, 0.1, lens_rad);
        }
        tcube([5,2,0.15], true);
        translate([0,0,1]) linear_extrude(height=0.4) polygon([[-2.5, -2.0], [-2.5, -2.5], [-2.0, -2.5]]);
    }
    tcube([3.7, 0.6, 0.15]);
    for (i = [-1, 1]){
        translate([0,i*2.5,0]) tcube([3.5, 1.5, 0.15]);
    }
}
