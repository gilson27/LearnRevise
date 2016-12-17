import grafica.*;

void setup() {
  size(500, 350);
  background(150);

  int nPoints = 100;
  GPointsArray points = new GPointsArray(nPoints);

  for (int i = 0; i < nPoints; i++) {
    points.add(i, 10*noise(0.1*i));
  }

  GPlot plot = new GPlot(this);
  plot.setPos(25, 25);

  plot.setTitleText("A very simple example");
  plot.getXAxis().setAxisLabelText("x axis");
  plot.getYAxis().setAxisLabelText("y axis");

  plot.setPoints(points);

  plot.defaultDraw();
}
