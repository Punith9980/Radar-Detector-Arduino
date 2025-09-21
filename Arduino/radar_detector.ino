/**
 * Arduino Radar Detector
 * ---------------------
 * Uses an HC-SR04 ultrasonic sensor and a servo motor
 * to detect object distance at different angles.
 * Sends data to Processing over Serial for visualization.
 */

#include <Servo.h>

// Servo and Ultrasonic pins
const int servoPin = 11;   // SG90 Servo signal pin
const int trigPin = 9;     // HC-SR04 Trig pin
const int echoPin = 10;    // HC-SR04 Echo pin

Servo radarServo;

void setup() {
  // Initialize pins
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Attach servo
  radarServo.attach(servoPin);

  // Initialize Serial communication
  Serial.begin(9600);
}

/**
 * Measure distance using HC-SR04
 * Returns distance in cm
 */
long measureDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH);  // Time for echo
  long distance = (duration / 2) / 29.1;   // Convert to cm
  return distance;
}

/**
 * Sweep the servo from startAngle to endAngle
 * Step can be +1 (forward) or -1 (backward)
 */
void sweep(int startAngle, int endAngle, int step) {
  for (int angle = startAngle; angle != endAngle; angle += step) {
    radarServo.write(angle);
    delay(30);  // Wait for servo to reach position

    long distance = measureDistance();

    // Send data to Processing in format: angle,distance.
    Serial.print(angle);
    Serial.print(",");
    Serial.print(distance);
    Serial.println(".");
  }
}

void loop() {
  // Sweep forward from 15° to 165°
  sweep(15, 165, 1);

  // Sweep backward from 165° to 15°
  sweep(165, 15, -1);
}
