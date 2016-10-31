import processing.io.*;
I2C i2c;
I2CMasterService i2cMasterService;
Utility utility;
LedService ledService;
ButtonService buttonService;
SevenSegmentDisplayService sevenSegmentDisplayService;
SoundService soundService;

//Defining LED Colors
String green = "GR";
int slaveOneAddress = 0x04;
int numberLeds = 3;
int numberButtons = 3;
int numberDisplays = 2;
//Test Variables
int startVar = 1;
int display1 = 5000;
int display2 = 5001;

void setup(){
  i2c = new I2C(I2C.list()[0]);
  printArray(I2C.list());
  i2cMasterService = new I2CMasterService(i2c);
  utility = new Utility();
  ledService = new LedService(i2cMasterService, utility);
  buttonService = new ButtonService(i2cMasterService, utility);
  sevenSegmentDisplayService = new SevenSegmentDisplayService(i2cMasterService, utility);

  //soundService = new SoundService(this);
  //soundService.playBooster();
  //soundService.playDeployChutes();
  //soundService.playTelmu();
  //soundService.playWasteManagement();
}

void draw(){  
}

void testFunction(){
  if(startVar ==1){ //<>//
      turnOffLeds(); //<>//
      startVar = 0;
  }
}

void turnOffLeds(){
  for(int i = 1; i<=numberLeds; i++){
    ledService.off(i);
  }
}

void turnOnLeds(){
  ledService.on(1,str(int(random(255255255))));
  ledService.on(2,str(int(random(255255255))));
  ledService.on(3,str(int(random(255255255))));
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