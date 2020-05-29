import ketai.sensors.*; 

KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;

int totalSteps;
int stepsDetected;

float amountLiquid = MAX_AMOUNT;
float drainAmount = 0.3;

float balance=7;

float amountPixels;

static float MAX_AMOUNT = 100;

void setup() {
  //size(540, 860);
  fullScreen();
  orientation(PORTRAIT);

  sensor = new KetaiSensor(this);
  sensor.start();
}

void draw() {
  background(255);
  //fill(#FFB4FB);
  noStroke();
  fill(#FFB4FB);

  if (accelerometerY > 13) {
    refill();
  }


  if (accelerometerX > balance || accelerometerX < -balance || accelerometerY > balance || accelerometerY < -balance) {
    // liquid is being poured
    amountLiquid -= drainAmount;
    //soundPouring.play();
  }

  amountLiquid = constrain(amountLiquid, 0, MAX_AMOUNT);
amountPixels = map(amountLiquid, 0, MAX_AMOUNT, 0, height);
  rect(0, height -amountPixels, width, amountPixels);
  textSize(30 * displayDensity);
  //textAlign(CENTER, CENTER);

  fill(0);
  text(stepsDetected + "\n" + totalSteps, width/2, height/2);


  fill(0);
  textSize(30 * displayDensity);
  textAlign(CENTER, BOTTOM);
  text("Accelerometer: \n" +
    "x: " + nfp(accelerometerX, 1, 3) + "\n" +
    "y: " + nfp(accelerometerY, 1, 3) + "\n" +
    "z: " + nfp(accelerometerZ, 1, 3), 0, 0, width, height);
    

}

void onStepDetectorEvent() { // called on every step detected
  stepsDetected++;
  println("step " + stepsDetected);
   println(amountPixels);
}

void onStepCounterEvent(float s) { // s is the step count since device reboot, is called on new step
  totalSteps = (int)s;
}
void refill() {
  amountLiquid = MAX_AMOUNT;
}

void onAccelerometerEvent(float x, float y, float z) {
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

