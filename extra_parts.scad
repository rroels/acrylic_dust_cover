bracket_hole_offset=18; // offset from corner to hole
bracket_width=10;
bracket_height=25;
bracket_thickness=4;
bracket_screw_size=4;

screw_height = 8;
screw_head_height = 1.6;
screw_head_diameter = 7.4;

module bracket()
{
    silver() difference() {
        // L-bracket
        union(){
            cube([bracket_width, bracket_height, bracket_thickness]);
            cube([bracket_width, bracket_thickness, bracket_height]);
        }

        // screw holes
        black() translate([bracket_width/2, bracket_hole_offset, bracket_thickness/2]) cylinder(8, d=4, center=true);
        black() translate([bracket_width/2, bracket_thickness/2, bracket_hole_offset]) rotate([90,0,0]) cylinder(8, d=4, center=true);
    }
}

module bracket_with_screws(spacing=0)
{
    union(){
        bracket();
        translate([bracket_width/2, bracket_hole_offset, -screw_head_height - spacing]) screw();
        translate([bracket_width/2, -screw_head_height - spacing, bracket_hole_offset]) rotate([-90,0,0]) screw();
    }
}

// simple 8mm M4 screw
module screw() {
    black() union(){
        cylinder(d=screw_head_diameter, h=screw_head_height);
        translate([0, 0, screw_head_height]) cylinder(d=4, h=screw_height);
    }
}

module corner_brace(glass_thickness, wall_thickness) {
    brace_height = 15;
    brace_size = 25;
    difference(){
        union(){
            cube([brace_size, glass_thickness + (2 * wall_thickness), brace_height]);
            cube([glass_thickness + (2 * wall_thickness), brace_size, brace_height]);
        }
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            cube([brace_size, glass_thickness, brace_height]);
        }
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            cube([glass_thickness, brace_size, brace_height]);
        }
    }

}
