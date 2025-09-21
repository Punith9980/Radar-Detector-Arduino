Arduino Radar Detector

A radar-like distance detection project using **Arduino**, **HC-SR04 ultrasonic sensor**, **SG90 servo motor**, and a **Processing (Java-based) frontend** for real-time visualization. This project replicates a radar system, sweeping a sensor across angles, measuring distances, and displaying them in an animated radar interface.

---------------------------------------------------------------------------------------------------------------------------------------------

Features

- Real-time radar sweep visualization.
- Displays detected objects with **angle**, **distance**, and **direction** (EAST/NORTH/WEST).
- Modular and easy-to-understand code for both Arduino and Processing.
- Ideal for learning **hardware-software integration** and **2D graphics**.

---------------------------------------------------------------------------------------------------------------------------------------------

🛠 Tools & Technologies

 **Hardware:**
  - Arduino Uno (or compatible board)
  - HC-SR04 Ultrasonic Distance Sensor
  - SG90 Servo Motor
  - Breadboard, Jumper Wires, Power Supply

  **Software:**
  - Arduino IDE (for uploading `radar_detector.ino`)
  - Processing IDE (for running `radar_visual.pde`)
  - GitHub (for project version control)

  **Programming Languages:**
  - C++ (Arduino)
  - Java-based Processing

---------------------------------------------------------------------------------------------------------------------------------------------

📂 Repository Structure

```

Arduino-Radar-Detector/
├── Arduino/
│   └── radar\_detector.ino        # Arduino code for servo + ultrasonic sensor
├── Processing/
│   └── radar\_visual.pde          # Processing frontend visualization
└── README.md                     # Project documentation

```

---------------------------------------------------------------------------------------------------------------------------------------------

1️⃣ Hardware Connections

|--------------------|-------------|
| Component          | Arduino Pin |
|--------------------|-------------|
| HC-SR04 Trig       | D9          |
| HC-SR04 Echo       | D10         |
| SG90 Servo Signal  | D11         |
| 5V/GND             | Power Rails |
|--------------------|-------------|

Notes:

- Connect servo **signal** to D11, **VCC** to 5V, **GND** to GND.
- HC-SR04 **Trig → D9**, **Echo → D10**, **VCC → 5V**, **GND → GND**.
- Ensure the servo can safely run on 5V; for larger servos, use an external power source.

---------------------------------------------------------------------------------------------------------------------------------------------

2️⃣ How It Works

1. The **servo sweeps** from 15° to 165° and back continuously.
2. The **HC-SR04 sensor measures distance** at each angle (in cm).
3. Data is sent to the computer via **Serial** in the format:  
```

angle,distance.

```
Example: `45,30.` → angle 45°, distance 30 cm.
4. The **Processing frontend** receives the data and renders:
- **Radar arcs** for distance
- **Sweeping green line** for the current angle
- **Red markers** for detected objects
- Text info: angle, distance, and direction (EAST/NORTH/WEST)

---------------------------------------------------------------------------------------------------------------------------------------------

3️⃣ Processing Integration

- Open **Processing IDE** and run `radar_visual.pde`.
- Make sure the **COM port** matches your Arduino’s.
- The radar display updates in real-time as the servo sweeps and objects are detected.

---------------------------------------------------------------------------------------------------------------------------------------------

4️⃣ Tips & Notes

- Maximum reliable ultrasonic distance: ~100–400 cm.
- Keep the servo delay (~30 ms) to prevent jitter.
- You can adjust **radar sweep range**, **display colors**, and **scaling** in Processing.
- Use external power for high-torque servos to avoid overloading Arduino.

---------------------------------------------------------------------------------------------------------------------------------------------

5️⃣ How to Use

1. Connect the Arduino hardware according to the **hardware connections** table.
2. Open `Arduino/radar_detector.ino` in Arduino IDE → select board and port → **Upload**.
3. Open `Processing/radar_visual.pde` in Processing IDE → adjust COM port → **Run**.
4. Watch the radar sweep, and observe detected objects with distance, angle, and direction.

_____________________________________________________________________________________________________________________________________________


