// reaction tester. also tests GPIO pins on raspberry pi
// first of 2 switches to press once the LED lights, after a random time, wins. 
// 3v3 -> switch -> GPIO pins, could use a 10K pulldown resistor from switch
// GPIO pin 4 -> LED -> 220R resistor -> ground

import processing.io.*;

int LED_PIN = 4;
int UP_BUTTON = 20;
int DOWN_BUTTON = 16;
long upDebounceStart = millis();
long downDebounceStart =millis();
int debounceTime = 200;
String winner = "nil";
boolean buttonPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int leftScore = 0;
int rightScore = 0;

void setup() {
  size(400, 300);
  background(204);
  GPIO.pinMode(UP_BUTTON, GPIO.INPUT);
  GPIO.attachInterrupt(UP_BUTTON, this, "upEvent", GPIO.RISING);
  GPIO.pinMode(DOWN_BUTTON, GPIO.INPUT);
  GPIO.attachInterrupt(DOWN_BUTTON, this, "downEvent", GPIO.RISING);
  GPIO.pinMode(LED_PIN, GPIO.OUTPUT);
  GPIO.digitalWrite(LED_PIN, GPIO.LOW);
  stroke(255);
  textSize(20);
  frameRate(1);
}

void draw(){
  delay(1000);
  delay((int)random(5000));
  GPIO.digitalWrite(LED_PIN, GPIO.HIGH);
  buttonPressed = false;
  leftPressed = false;
  rightPressed = false;
  while (!buttonPressed) {
    delay(1);
  }
  println("the winner was " + winner);
  background(204);
  text("The winner was " + winner, 10, 30);
  GPIO.digitalWrite(LED_PIN, GPIO.LOW);
  if (winner == "left") {
    leftScore ++;
  } else if (winner == "right") {
    rightScore ++;
  }
  text("Scores:", 10, 50);
  text("Left: " + leftScore, 10, 70);
  text("Right: " + rightScore, 10, 90);  
  
  while (leftPressed == false || rightPressed == false) {
    delay(1);
  }
  text(winner + " won by " + (abs(upDebounceStart - downDebounceStart)) + " milliseconds", 10, 120);
  
//  delay(2000);
//  println(winner + " won by " + (abs(upDebounceStart - downDebounceStart)));
//  delay(500);
//  println("new game");
}

void upEvent(int UP_BUTTON){
  if (millis() > (upDebounceStart + debounceTime)) {
    if (buttonPressed == false) {
      winner = "left";
    }
    buttonPressed = true;
    rightPressed = true;
    upDebounceStart = millis();
  }

}
void downEvent(int DOWN_BUTTON){
  if (millis() > (downDebounceStart + debounceTime)) {
    if (buttonPressed == false) {
      winner = "right";
    }
    buttonPressed = true;
    leftPressed = true;
    downDebounceStart = millis();
  }
}