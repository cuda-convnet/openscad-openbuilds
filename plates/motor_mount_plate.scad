include <MCAD/units.scad>;
include <MCAD/shapes.scad>;
use <../utils/colors.scad>;

module motor_mount_plate_body(w, h, r=5, thingness=3) {
  difference() {
    translate([w/2, h/2, thingness/2]) roundedBox(w, h, thingness, r);
    translate([w/2, 8.2]) union() {
      for(x=[-1:1], y=[0:1])
        translate([x*10, y*20, -0.5]) cylinder(r=M5/2, h=thingness+1);
    }
  }
}

module motor_mount_plate_nema17(material=color_black) {
  w=39.50;
  h=82.00;
  thingness=3;
  color(material) difference() {
    motor_mount_plate_body(w, h, thingness=thingness);
    translate([w/2, h-21.25, -0.5]) union() {
      cylinder(r=12.5, h=thingness+1);
      for(angle=[0:90:270]) {
        rotate([0, 0, angle]) hull() {
          translate([13, 13]) cylinder(r=1.55, h=thingness+1);
          translate([15.5, 15.5]) cylinder(r=1.55, h=thingness+1);
        }
      }
    }
  }
}

module idler_pulley_plate(material=color_black) {
  w=39.50;
  h=67.00;
  thingness=3;
  color(material) difference() {
    motor_mount_plate_body(w, h, thingness=thingness);
    translate([w/2, h-7.10, -0.5]) cylinder(r=M5/2, h=thingness+1);
  }
}

module motor_mount_plate_nema23(material=color_black) {
  w=60.50;
  h=96.50;
  r=5;
  thingness=3;
  color(material) difference() {
    translate([w/2, h/2, thingness/2]) roundedBox(w, h, thingness, r);
    translate([w/2, 8.2]) union() {
      for(x=[-2:2])
        hull() {
          translate([x*10, 0, -0.5]) cylinder(r=M5/2, h=thingness+1);
          translate([x*10, 20, -0.5]) cylinder(r=M5/2, h=thingness+1);
        }
    }
    translate([w/2, h-27.7, -0.5]) union() {
      cylinder(r=20, h=thingness+1);
      for(angle=[0:90:270]) {
        rotate([0, 0, angle]) union() {
          hull() {
            translate([13, 13]) cylinder(r=1.55, h=thingness+1);
            translate([15.5, 15.5]) cylinder(r=1.55, h=thingness+1);
          }
          translate([23.5, 23.5]) cylinder(r=M5/2, h=thingness+1);
        }
      }
    }
  }
}

module motor_mount_plate_test() {
  motor_mount_plate_nema17();
  translate([60, 0, 0]) motor_mount_plate_nema23();
  translate([140, 0, 0]) idler_pulley_plate();
}