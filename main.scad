$fn = 50;

include <extra_parts.scad>;
include <helpers.scad>;

panel_thickness = 3;

// inner box size
box_depth = 360;
box_height = 400;
box_width = 450;

// amount of horizontal corner brackets per panel
// thse connect the top of each side panel with the top panel
horizontal_mounts = 2;

// amount of vertical corner brackets per panel, these connect the side panels with their neighbour side panel
vertical_mounts = 3;

// how wide are the "tabs" that allow the panels to slot into each other
castelation_size = 50;

// -----------------------
// ----- HELPER FUNCTIONS
// -----------------------

function total_width() = box_width + (2 * panel_thickness);
function total_depth() = box_depth + (2 * panel_thickness);
function total_height() = box_height + panel_thickness;

// --------------------
// ----- PANELS
// --------------------

module panel_front()
{
    side_panel_screw_holes_horizontal_connectors(total_width()){
        panel_horizontal_castelation_protrusions(total_width()){
            panel_screw_holes_vertical_connectors(bracket_hole_offset + panel_thickness, box_width - bracket_hole_offset + panel_thickness)
            {
                panel_vertical_castelation_slots() {
                    cube([box_width + (2 * panel_thickness), box_height, panel_thickness]);
                }
            }
        }
    }
}

module panel_back()
{
    panel_front();
}

module panel_left()
{
    side_panel_screw_holes_horizontal_connectors(total_depth()){
        panel_horizontal_castelation_protrusions(total_depth()){
            translate([panel_thickness, 0, 0]) {// compensate for added castelation protrusions
                panel_screw_holes_vertical_connectors(bracket_hole_offset, box_depth - bracket_hole_offset){
                    panel_vertical_castelation_protrusions(){
                        cube([box_depth, box_height, panel_thickness]);
                    }
                }
            }
        }
    }
}

module panel_right()
{
    panel_left();
}

module panel_top()
{
    top_panel_screw_holes_horizontal_connectors(){
        panel_horizontal_castelation_slots(){
            cube([total_width(), total_depth(), panel_thickness]);
        }
    }
}

// --------------------
// ----- SCREW HOLES
// --------------------

module screw_hole() {
    #cylinder(d = bracket_screw_size, h = 10, center = true);
}

module panel_screw_holes_vertical_connectors(offset_left, offset_right)
{
    difference() {
        children();
        for (i = [1:vertical_mounts]) {
            // left side
            translate([offset_left, i * (box_height / (vertical_mounts + 1)), 0]) screw_hole();
            // right side
            translate([offset_right, i * (box_height / (vertical_mounts + 1)), 0]) screw_hole();
        }
    }
}

module top_panel_screw_holes_horizontal_connectors()
{
    difference() {
        children();
        for (i = [1:horizontal_mounts]) {

            y_pos = (i * total_depth()) / (horizontal_mounts + 1);
            x_pos = (i * total_width()) / (horizontal_mounts + 1);

            // left
            translate([bracket_hole_offset + panel_thickness, y_pos, 0]) screw_hole();

            // right
            translate([box_width - bracket_hole_offset + panel_thickness, y_pos, 0]) screw_hole();

            // back
            translate([x_pos, box_depth + panel_thickness - bracket_hole_offset, 0]) screw_hole();

            // front
            translate([x_pos, bracket_hole_offset + panel_thickness, 0]) screw_hole();

        }
    }
}

module side_panel_screw_holes_horizontal_connectors(panel_w)
{
    difference() {
        children();
        for (i = [1:horizontal_mounts]) {
            x_pos = (i * (panel_w / (horizontal_mounts + 1)));
            translate([x_pos, box_height - bracket_hole_offset, 0]) screw_hole();
        }
    }
}

// ----------------------------
// ----- CASTELATION / TABS
// ----------------------------

module panel_vertical_castelation_slots()
{
    difference() {
        children();
        for (i = [1:vertical_mounts]) {
            // left side
            translate([0, i * (box_height / (vertical_mounts + 1)), (panel_thickness + 1) / 2]) {
                cube([2 * panel_thickness, castelation_size, panel_thickness + 2], center = true);
            }
            // right side
            translate([total_width(), i * (box_height / (vertical_mounts + 1)), (panel_thickness + 1) / 2]) {
                cube([2 * panel_thickness, castelation_size, panel_thickness + 2], center = true);
            }
        }
    }
}

module panel_vertical_castelation_protrusions()
{
    union() {
        children();
        for (i = [1:vertical_mounts]) {
            // left
            translate([0, i * (box_height / (vertical_mounts + 1)), panel_thickness / 2]) {
                cube([2 * panel_thickness, castelation_size, panel_thickness], center = true);
            }
            // right
            translate([box_depth, i * (box_height / (vertical_mounts + 1)), panel_thickness / 2]) {
                cube([2 * panel_thickness, castelation_size, panel_thickness], center = true);
            }
        }
    }
}

module panel_horizontal_castelation_protrusions(panel_w)
{
    union() {
        children();
        for (i = [1:horizontal_mounts]) {
            // top side
            translate([i * (panel_w / (horizontal_mounts + 1)), box_height, panel_thickness / 2]) {
                cube([castelation_size, panel_thickness * 2, panel_thickness], center = true);
            }
        }
    }
}

// only for top panel
module panel_horizontal_castelation_slots()
{
    difference() {
        children();
        for (i = [1:horizontal_mounts]) {
            // left side
            translate([0, i * (total_depth() / (horizontal_mounts + 1)), (panel_thickness + 1) / 2]) {
                cube([2 * panel_thickness, castelation_size, panel_thickness + 2], center = true);
            }
            // right side
            translate([total_width(), i * (total_depth() / (horizontal_mounts + 1)), (panel_thickness + 1) / 2]) {
                cube([2 * panel_thickness, castelation_size, panel_thickness + 2], center = true);
            }
            // back
            translate([i * (total_width() / (horizontal_mounts + 1)), total_depth(), (panel_thickness + 1) / 2]) {
                cube([castelation_size, 2 * panel_thickness, panel_thickness + 2], center = true);
            }
            // front
            translate([i * (total_width() / (horizontal_mounts + 1)), 0, (panel_thickness + 1) / 2]) {
                cube([castelation_size, 2 * panel_thickness, panel_thickness + 2], center = true);
            }
        }
    }
}

// --------------------
// ----- RENDERING
// --------------------

// 3D rendering for full preview of the box
module assemble()
{
    //translate([0, panel_thickness-0.02, 0]) rotate([90, 0, 0]) plexi_frost() panel_front();
    translate([total_width(), total_depth() - panel_thickness + 0.02, 0]) rotate([90, 0, 180]) red() panel_back();
    translate([panel_thickness - 0.02, total_depth() - 0.02, 0]) rotate([90, 0, -90]) blue() panel_left();
    translate([total_width() - panel_thickness + 0.02, 0, 0]) rotate([90, 0, 90]) green() panel_right();
    translate([0, 0, box_height - 0.02]) rotate([0, 0, 0]) yellow() panel_top();


    // vertical connector brackets
    angles = [-90, 0, 90, 180];
    x_offsets = [panel_thickness, box_width + panel_thickness, box_width + panel_thickness, panel_thickness];
    y_offsets = [panel_thickness, panel_thickness, box_depth + panel_thickness, box_depth + panel_thickness];
    for (side = [0:3]) {
        for (i = [1:vertical_mounts]) {
            translate([x_offsets[side], y_offsets[side], (i * (box_height / (vertical_mounts + 1))) - (bracket_width / 2
            )]) rotate([0, -90, angles[side]]) bracket_with_screws(panel_thickness);
        }
    }

    // horizontal connectors, front and back
    for (i = [1:horizontal_mounts]) {
        translate([(i * (total_width() / (horizontal_mounts + 1))) - (bracket_width / 2), panel_thickness, box_height])
            rotate([270, 0, 0]) bracket_with_screws(panel_thickness);
    }
    for (i = [1:horizontal_mounts]) {
        translate([(i * (total_width() / (horizontal_mounts + 1))) + (bracket_width / 2), box_depth + panel_thickness,
            box_height]) rotate([270, 0, 180]) bracket_with_screws(panel_thickness);
    }

    // horizontal connectors, left and right
    for (i = [1:horizontal_mounts]) {
        translate([panel_thickness, (i * (total_depth() / (horizontal_mounts + 1))) + (bracket_width / 2), box_height])
            rotate([270, 0, -90]) bracket_with_screws(panel_thickness);
    }
    for (i = [1:horizontal_mounts]) {
        translate([box_width + panel_thickness, (i * (total_depth() / (horizontal_mounts + 1))) - (bracket_width / 2),
            box_height]) rotate([270, 0, 90]) bracket_with_screws(panel_thickness);
    }

    // corner braces
    translate([-2, -2, -2]) rotate([0, 0, 0]) black() corner_brace(3, 2);
    translate([total_width() + 2, -2, -2]) rotate([0, 0, 90]) black() corner_brace(3, 2);
    translate([-2, total_depth() + 2, -2]) rotate([0, 0, -90]) black() corner_brace(3, 2);
    translate([total_width() + 2, total_depth() + 2, -2]) rotate([0, 0, 180]) black() corner_brace(3, 2);
    // highlight inner volume for debugging
    //#translate([panel_thickness, panel_thickness, 0]) cube([box_width, box_depth, box_height]);
}

// 2D layout of the panels, for converting to for instance a lasercut format
module render_2d()
{
    projection()
        {
            translate([0, 0, 0]) panel_front();
            translate([500, 0, 0]) panel_back();
            translate([0, 440, 0]) panel_left();
            translate([390, 440, 0]) panel_right();
            translate([1150, 440, 0]) rotate([0, 0, 90]) panel_top();
        }
}

assemble();
//render_2d();



