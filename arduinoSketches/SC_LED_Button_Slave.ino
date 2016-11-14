#include <Wire.h>
#include "FastLED.h"

#define NUM_LEDS 14
#define DATA_PIN 10
#define NUM_BUTTONS 9

// Define the array of leds
CRGB leds[NUM_LEDS];

//pin definitions
const int button1 = A1;
const int button2 = 2;
const int button3 = 3;
const int button4 = 4;
const int button5 = 5;
const int button6 = 6;
const int button7 = 7;
const int button8 = 8;
const int button9 = 9;

//global vars
String messageIn;
int buttons[] = {button1,button2,button3,button4,button5,button6,button7,button8,button9}; 
String requestState = "";
int buttonState = 0;
int currentButtonRead = 0;

void setup() { 
  Wire.begin(0x04); //Initialize arduino with address (1)
  Wire.onRequest(requestEvent); //When master asks for data
  Wire.onReceive(receiveEvent); //When master sends data
  
  //Serial for console debugging
  Serial.begin(9600);
  Serial.println("Starting up Arduino 1");
  //Setting up LEDS
  FastLED.addLeds<WS2811, DATA_PIN, RGB>(leds, NUM_LEDS);

  //Setting up button 
  pinMode(button1, INPUT_PULLUP);
  pinMode(button2, INPUT_PULLUP);
  pinMode(button3, INPUT_PULLUP);
  pinMode(button4, INPUT_PULLUP);
  pinMode(button5, INPUT_PULLUP);
  pinMode(button6, INPUT_PULLUP);
  pinMode(button7, INPUT_PULLUP);
  pinMode(button8, INPUT_PULLUP);
  pinMode(button9, INPUT_PULLUP);

}

void loop() { 
  delay(100);
  
  //Button Test
  /*for (int i = 0 ; i < NUM_BUTTONS; i++){ 
      int theInput = digitalRead(buttons[i]);
      if(theInput == 0){
        Serial.print("Button: ");
       Serial.println(i+1);
      }
  }*/

  //Led Test
  /*for (int i = 0 ; i < NUM_LEDS; i++)
  {       
    Serial.print("test ");
    Serial.println(i);

    delay(500);
    leds[i] = CRGB::Red; 
    FastLED.show();

    delay(500);
    leds[i] = CRGB::Black;
    FastLED.show();

  }*/
}


//Reads the button and set button state to be sent back to master
//Message in the form of BUT000001 (BUT)(00001)
//(Button Command)(Button number to read)
String buttonRead()
{
  String buttonArrayString="";
  for(int i=0 ; i < NUM_BUTTONS; i++){
    buttonArrayString += String(padTwoDigits(digitalRead(buttons[i])));
  }
  Serial.println(buttonArrayString);
  // read and set the state of the pushbutton value for master
  return buttonArrayString;
}

//Message in the form of LED0001RD (00)(01)(RD) 
//(LED or BUT)(LED state)(Led Position)(Led Color) 
void setLed(String message)
{
  int ledState = message.substring(3,5).toInt();
  int ledPosition = message.substring(5,7).toInt();
  int ledRed = message.substring(7,10).toInt();
  int ledGreen = message.substring(10,13).toInt();
  int ledBlue = message.substring(13).toInt();

  Serial.println(ledState);
  Serial.println(ledPosition);
  Serial.print("Red: ");
  Serial.println(ledRed);
  Serial.print("Green: ");
  Serial.println(ledGreen);
  Serial.print("Blue: ");
  Serial.println(ledBlue);
  leds[NUM_LEDS-ledPosition].r = ledRed;
  leds[NUM_LEDS-ledPosition].g = ledGreen;
  leds[NUM_LEDS-ledPosition].b = ledBlue;
  FastLED.show();

}

void offLed(int position){
    leds[NUM_LEDS-position] = CRGB::Black;
    FastLED.show();
}
//Add leading zeros to make numbers two digits
String padTwoDigits(int numberToConvert)
{
  String returnNumber = "";
  if (numberToConvert < 10)
  {
    returnNumber += "0" + (String)numberToConvert ;
  }
  else
  {
    returnNumber += (String)numberToConvert;
  }
  return returnNumber;
}

//Master requests a button state. buttonState has been set
//by master's Write Command
void requestEvent(){
  Serial.println("Message Requested");
  String constructedMessage="";
  if (requestState == "BUTTON"){
    constructedMessage = buttonRead();
  }
  else if (requestState = "LEDON"){
    constructedMessage = "LEDON";
  }
  else if (requestState = "LEDOFF"){
    constructedMessage = "LEDOFF";
  }
  for(int i = 0; i < constructedMessage.length(); i++){
    Wire.write(constructedMessage[i]);    
  }

}

void receiveEvent(int howMany) {
  //Verify Received
  String code = "";
  Serial.println("Message Received!");

  //Reading wire to Decode
  messageIn = "";
  while (0 < Wire.available()) { 
    messageIn += (char)Wire.read();
  }
  Serial.println(messageIn);

  code = messageIn.substring(0,3);
  Serial.print("CODE: ");
  Serial.println(code);
  //Read Button or Write LED?
  if (code == "BUT")
  {
    requestState = "BUTTON";
  }
  else if (code == "LED")
  {
    if(messageIn.substring(3,5)=="01"){
      requestState = "LEDON";
      setLed(messageIn); 
    }
    else if(messageIn.substring(3,5)=="00"){
      requestState = "LEDOFF";
      offLed(messageIn.substring(5,7).toInt());
    }
  }
  else
  {
    Serial.print("Unknown Command Received: ");
    Serial.println(code);
  }        

}





