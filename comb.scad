height = 32;
thickness = 2.8;
width = 100;
numberOfTeeth = 30;
toothWidth = 1.7;

handleHeight = height * 0.3;
side = width * .035;

workingWidth = width - 2 * side;

// workingWidth = numberOfTeeth * toothWidth + (numberOfTeeth + 1) * toothGap
toothGap = (workingWidth - numberOfTeeth * toothWidth) / (numberOfTeeth + 1);
toothStep = toothGap + toothWidth;

echo("workingWidth=", workingWidth, "toothWidth=", toothWidth, "toothGap=", toothGap, "toothStep=", toothStep);

$fs = toothWidth / 10;

difference() {
  linear_extrude(height = width) {
    polygon(points=[
      [0, 0],
      [height, thickness / 2],
      [height, -thickness / 2]
      ], paths=[[0, 1, 2]]);
  }

  for (i = [0 : numberOfTeeth]) {
    translate([0, -100, side + i * toothStep])
    cube(size = [height - handleHeight, 200, toothGap]);
  }
}
