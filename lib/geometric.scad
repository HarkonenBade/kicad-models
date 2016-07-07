/*
    ~Geometric Lib
    
    Variety of geometric parts
*/

/*
    On plane cube
    
    Cube that is centered in X and Y and rests on the XY plane
    
    size - as cube
*/
module tcube(size){
    translate([0,0,size[2]/2]) cube(size, true);
}

/*
    Square based frustrated pyramid

    Centered on X and Y, rests on the XY plane

    w - Width in X
    d - Depth in Y
    h - Height in Z
    ratio - Ratio of size of the tip face to the base face
*/
module sq_pyr(w, d, h, ratio){
    resize([w,d,h]) rotate([0,0,45]){
        cylinder(h, d1=1, d2=ratio, $fn=4);
    }
}

/*
    Rounded cornered box

    Centered on X and Y, rests on the XY plane

    w - Width in X
    d - Depth in Y
    h - Height in Z
    cr - Corner ratio
*/
module rounded_box(w,d,h,cr){
    translate([0,0,h/2]) {
        minkowski() {
            cube([w-2*cr, d-2*cr, h/2], true);
            cylinder(h/2, cr, cr, true, $fn=12);
        }
    }
}

module wedge(w,d,h){
    resize([w,d,h])
      translate([1,0,0])
        rotate([0,-90,0])
          linear_extrude(1)
            polygon([[0,0],[0,1],[1,0]]);
}


module fwedge(w,d,h,td){
    wedge_d = (d-td)/2;
    translate([0,wedge_d,0]){
        translate([0,td,0])
          wedge(w,wedge_d,h);
        cube([w,td,h]);
        mirror([0,1,0])
          wedge(w,wedge_d,h);
    }
}