module rgb(r, g, b, a = 1) {
    color([r/255, g/255, b/255], a) children();
}

module silver() { rgb(250, 250, 250) children(); }
module aluminum() { rgb(205, 205, 205) children(); }
module white() { rgb(255, 255, 255) children(); }
module black() { rgb(0, 0, 0) children(); }
module yellow() { rgb(255, 255, 0) children(); }
module blue() { rgb(0, 0, 255) children(); }
module red() { rgb(255, 0, 0) children(); }
module green() { rgb(0, 255, 0) children(); }
module wood() { rgb(240, 200, 150) children(); }
module plexi_frost() { rgb(255,255,255, 0.3) children(); }
module plexi_blue() { rgb(135,206,250, 0.7) children(); }
