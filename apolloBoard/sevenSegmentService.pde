//Service for the Seven Segment Displays

class SevenSegmentDisplayService{
  I2CMasterService i2cService;
  Utility utility;
  int arduino2Address = 0x05;
  int display1Value = 0001;
  int display2Value = 0002;
	//Constructor
	SevenSegmentDisplayService(I2CMasterService i2cService, Utility utility){
		this.i2cService = i2cService;
		this.utility = utility;
	}
  
  void setDisplay(int displayNum, int value){
  	//Message in the form of (CODE)(DisplayNumber)(Value)
  	//SEG011234

  	String message = "SEG";
  	message += utility.padTwoDigits(displayNum);
  	message += utility.padFourDigits(value);
	println("Sending Message: "+message+" Address: "+arduino2Address+" on"); //<>//

  	i2cService.sendMessageToSlave(arduino2Address,message);
  	String recievedMessage = i2cService.readMessageFromSlave(9);
  	print("recievedMessage");

  }



}