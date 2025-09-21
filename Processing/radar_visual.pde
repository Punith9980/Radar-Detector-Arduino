/**
 * Arduino Radar Detector - Processing Frontend
 * --------------------------------------------
 * Visualizes radar sweep and object detection using Arduino data.
 * 
 * Reads serial data in format: angle,distance.
 */

import processing.serial.*;

Serial myPort; 

// Radar data
int iAngle = 0;
int iDistance = 0;

// Display constants
float centerX, centerY;
float radarRadius;

void setup() {
  size(1200, 800);
  smooth();
  centerX = width / 2;
  centerY = height * 0.9;
  radarRadius = height * 0.7;

  // Connect to Arduino (change COM port if needed)
  myPort = new Serial(this, "COM6", 9600);
  myPort.bufferUntil('.');
}

void draw() {
  background(0);
  drawRadarGrid();
  drawSweepLine(iAngle);
  drawObject(iAngle, iDistance);
  drawHUD(iAngle, iDistance);
}

/**
 * Serial Event: read angle,distance from Arduino
 */
void serialEvent(Serial port) {
  String data = port.readStringUntil('.');
  if (data != null) {
    data = trim(data.substring(0, data.length() - 1));
    String[] values = split(data, ',');
    if (values.length == 2) {
      iAngle = int(values[0]);
      iDistance = int(values[1]);
    }
  }
}

/**
 * Draw radar arcs and angle lines
 */
void drawRadarGrid() {
  pushMatrix();
  translate(centerX, centerY);
  stroke(0, 255, 50);
  noFill();
  strokeWeight(2);

  // Draw concentric arcs
  for (int r = 100; r <= radarRadius; r += 100) {
    ellipse(0, 0, r*2, r*2);
  }

  // Draw radial lines every 30 degrees
  for (int a = 0; a <= 180; a += 30) {
    line(0, 0, cos(radians(a)) * radarRadius, -sin(radians(a)) * radarRadius);
  }

  popMatrix();
}

/**
 * Draw the sweeping radar line
 */
void drawSweepLine(int angle) {
  pushMatrix();
  translate(centerX, centerY);
  stroke(30, 250, 60);
  strokeWeight(3);
  line(0, 0, cos(radians(angle)) * radarRadius, -sin(radians(angle)) * radarRadius);
  popMatrix();
}

/**
 * Draw detected object as red dot if in range
 */
void drawObject(int angle, int distance) {
  if (distance > 0 && distance <= 100) {
    pushMatrix();
    translate(centerX, centerY);
    stroke(255, 50, 50);
    strokeWeight(8);
    float px = cos(radians(angle)) * map(distance, 0, 100, 0, radarRadius);
    float py = -sin(radians(angle)) * map(distance, 0, 100, 0, radarRadius);
    point(px, py);
    popMatrix();
  }
}

/**
 * Display angle, distance, and direction info
 */
void drawHUD(int angle, int distance) {
  fill(0);
  noStroke();
  rect(0, height-50, width, 50);

  fill(0, 255, 50);
  textSize(20);
  textAlign(CENTER);

  String direction = "Out of Range";
  if (distance <= 100) {
    if (angle < 60) direction = "EAST";
    else if (angle > 120) direction = "WEST";
    else direction = "NORTH";
  }

  text("Angle: " + angle + "°   Distance: " + distance + " cm   Direction: " + direction, width/2, height-20);
}
