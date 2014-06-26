// ---- Dimensions
height = 32;
thickness = 2.8;
width = 100;

// ---- Parameters

toothWidth = 1.7;
numberOfTeeth = 30;

toothCutAngle = 70;
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
  cube(size = [height, thickness, width]);

  /*
  linear_extrude(height = width) {
    polygon(points=[
      [0, 0],
      [height, thickness / 2],
      [height, -thickness / 2]
      ], paths=[[0, 1, 2]]);
  }
  */
}

difference() {
  base();

  for (i = [0 : numberOfTeeth]) {
    translate([-1, -100, side + i * toothStep])
    cube(size = [1 + height - handleHeight, 200, toothGap]);
  }

  translate([0, thickness / 2, -1])
  rotate(a=90-toothCutAngle / 2 + 180, v=[0, 0, 1])
  cube(size = [1000, 1000, width + 2]);

  translate([0, thickness / 2, -1])
  rotate(a=toothCutAngle / 2, v=[0, 0, 1])
  cube(size = [1000, 1000, width + 2]);
}
