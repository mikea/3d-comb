// ---- Dimensions
height = 32;
thickness = 2.8;
width = 100;

// ---- Parameters

toothWidth = 1;
numberOfTeeth = 30;

toothCutAngle = 40;
handleHeight = height * 0.3;
side = width * .035;

// ---- Calculations

workingWidth = width - 2 * side;
// workingWidth = numberOfTeeth * toothWidth + (numberOfTeeth + 1) * toothGap
toothGap = (workingWidth - numberOfTeeth * toothWidth) / (numberOfTeeth + 1);
toothStep = toothGap + toothWidth;

echo("workingWidth=", workingWidth, "toothWidth=", toothWidth, "toothGap=", toothGap, "toothStep=", toothStep);

// ---- Assemble

$fs = toothWidth / 10;

module base() {
  // cube with rounded corners
  hull() {
    translate([thickness / 2, 0, thickness / 2])
    cube(size = [height - thickness, thickness, width - thickness]);

    translate([thickness / 2, thickness / 2, thickness / 2])
    sphere(r = thickness / 2);

    translate([thickness / 2, thickness / 2, width - thickness / 2])
    sphere(r = thickness / 2);

    translate([height - thickness / 2, thickness / 2, width - thickness / 2])
    sphere(r = thickness / 2);

    translate([height - thickness / 2, thickness / 2, thickness / 2])
    sphere(r = thickness / 2);
  }
}

difference() {
  base();

  // cut teeth out
  for (i = [0 : numberOfTeeth]) {
    translate([-1, -100, side + i * toothStep])
    cube(size = [1 + height - handleHeight, 200, toothGap]);
  }

  // "sharpen" teeth
  translate([0, thickness / 2, -1])
  rotate(a=90-toothCutAngle / 2 + 180, v=[0, 0, 1])
  cube(size = [1000, 1000, width + 2]);

  translate([0, thickness / 2, -1])
  rotate(a=toothCutAngle / 2, v=[0, 0, 1])
  cube(size = [1000, 1000, width + 2]);
}
