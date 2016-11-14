import processing.io.*; //<>// //<>//

I2C i2c;
I2CMasterService i2cMasterService;
Utility utility;
LedService ledService;
ButtonService buttonService;
SevenSegmentDisplayService sevenSegmentDisplayService;
SoundService soundService;

final int ledDelay = 1000;
final int soundDelay = 10000;

//Defining LED Colors
String green = "GR";
int slaveOneAddress = 0x04;
int numberLeds = 14;
final int numberButtons = 9;
int numberDisplays = 2;
//Test Variables
int startVar = 1;
int display1 = 5000;
int display2 = 5001;

// Re-entry
int tenState = 0;
int nineState = 0;
int elevenState = 0;

int fiveState = 0;
int twentysixState = 0;
int thirteenState = 0;
int twentyState = 0;

boolean[] buttonStates = new boolean[numberButtons];

void setup(){
  i2c = new I2C(I2C.list()[0]);
  printArray(I2C.list());
  i2cMasterService = new I2CMasterService(i2c);
  utility = new Utility();
  ledService = new LedService(i2cMasterService, utility);
  buttonService = new ButtonService(i2cMasterService, utility);
  sevenSegmentDisplayService = new SevenSegmentDisplayService(i2cMasterService, utility);
  
    GPIO.pinMode(11, GPIO.INPUT);
    GPIO.pinMode(10, GPIO.INPUT);
    GPIO.pinMode(9, GPIO.INPUT);

    GPIO.pinMode(5, GPIO.INPUT);
    GPIO.pinMode(13, GPIO.INPUT);
    GPIO.pinMode(26, GPIO.INPUT);
    GPIO.pinMode(20, GPIO.INPUT);
    
  soundService = new SoundService(this);
  //soundService.playBooster();
  //soundService.playDeployChutes();
  //soundService.playTelmu();
  //soundService.playWasteManagement();
  turnOnLeds();
}

void draw(){
  //int[] buttonStates = buttonService.convertStringToButtonStatesArray(buttonService.getStatesFromI2C());
  //turnOnLeds();
  //for (int i = 0; i < buttonStates.length; i++) {
  //  if (buttonStates[i] == 1) {
  //    soundService.playBooster();
  //  } else {
      
  //  }
    
  //  delay(500);
  //}
  println(GPIO.digitalRead(10));
   if(GPIO.digitalRead(10) == GPIO.LOW) {
     println("10 Pressed");
    if (tenState == GPIO.LOW) {
      tenState = GPIO.HIGH;
      soundService.playHeatShield();
      delay(soundDelay);
    } else {
      tenState = GPIO.LOW;
    }
   }
    
    if(GPIO.digitalRead(9) == GPIO.LOW) {
     println("9 Pressed");
    if (nineState == GPIO.LOW) {
      nineState = GPIO.HIGH;
      soundService.playReleaseCommandModule();
      delay(soundDelay);
    } else {
      nineState = GPIO.LOW;
    }
      
  }//
  
  if(GPIO.digitalRead(11) == GPIO.LOW) {
     println("11 Pressed");
    if (elevenState == GPIO.LOW) {
      elevenState = GPIO.HIGH;
      soundService.playDeployChutes();
      delay(soundDelay);
    } else {
      elevenState = GPIO.LOW;
    }
      
  }//
  
  if(GPIO.digitalRead(5) == GPIO.LOW) {
     println("5 Pressed");
    if (fiveState == GPIO.LOW) {
      fiveState = GPIO.HIGH;
      soundService.playWasteManagement();
      delay(soundDelay);
    } else {
      fiveState = GPIO.LOW;
    }
      
  }//
  
    if(GPIO.digitalRead(13) == GPIO.LOW) {
     println("13 Pressed");
    if (thirteenState == GPIO.LOW) {
      thirteenState = GPIO.HIGH;
      soundService.playBatteryCharge();
      delay(soundDelay);
    } else {
      thirteenState = GPIO.LOW;
    }
      
  }//
  
  if(GPIO.digitalRead(26) == GPIO.LOW) {
     println("26 Pressed");
    if (twentysixState == GPIO.LOW) {
      twentysixState = GPIO.HIGH;
      soundService.playCabinPressure();
      delay(soundDelay);
    } else {
      twentysixState = GPIO.LOW;
    }
      
  }//
  
   if(GPIO.digitalRead(20) == GPIO.LOW) {
     println("20 Pressed");
    if (twentyState == GPIO.LOW) {
      twentyState = GPIO.HIGH;
      soundService.playOxygenSupply();
      delay(soundDelay);
    } else {
      twentyState = GPIO.LOW;
    }
      
  }//
}

void testFunction(){
  if(startVar ==1){
      turnOffLeds();
      startVar = 0;
  }
}

void turnOffLeds(){
  for(int i = 1; i<=numberLeds; i++){
    ledService.off(i);
  }
}

void turnOnLeds(){
  //ledService.on(1,str(int(random(255255255))));
  //delay(ledDelay);
  for (int i = 2; i < 11; i++) {
    ledService.on(i, str(000128000));
  }
  //ledService.on(2,str(int(random(255255255))));
  //delay(ledDelay);
  //ledService.on(3,str(int(random(255255255))));
  //delay(ledDelay);
  //ledService.on(4,str(int(random(255255255))));  
  //delay(ledDelay);
  //ledService.on(5,str(int(random(255255255))));
  //delay(ledDelay);
  //  ledService.on(6,str(int(random(255255255))));
  //  delay(ledDelay);
  //  ledService.on(7,str(int(random(255255255))));
  //  delay(ledDelay);
  //  ledService.on(8,str(int(random(255255255))));
  //  delay(ledDelay);
  //  ledService.on(9,str(int(random(255255255))));
  //  delay(ledDelay);
  //  ledService.on(10,str(int(random(255255255))));
  //  delay(ledDelay);
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      turnOnLeds();
    } else if (keyCode == DOWN) {
      turnOffLeds();
    } else if (keyCode == LEFT){
      String buttonByteString = buttonService.getStatesFromI2C();
      int[] buttonArray = buttonService.convertStringToButtonStatesArray(buttonByteString);
      printArray(buttonArray);
    } else if (keyCode == RIGHT){
      sevenSegmentDisplayService.setDisplay(1,display1++);
      sevenSegmentDisplayService.setDisplay(2,display2++);

    }
  } else {
    println("randomButton");
  }
}