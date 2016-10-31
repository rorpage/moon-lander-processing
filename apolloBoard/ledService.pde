class LedService{
	I2CMasterService i2cService;
	Utility utility;

	LedService(I2CMasterService i2cService, Utility utility){
		this.i2cService = i2cService;
		this.utility = utility;
	}

	//Turn led number on through i2c line
	void on(int ledNumber, String rgbColor){
	  println("Turning LED "+ledNumber+":"+rgbColor+" on"); //<>// //<>//
	  String message = "LED"+"01"+ utility.padTwoDigits(ledNumber)+rgbColor;
	  //Form must be LED0101RD (LED)(State)(Position)(Color)
	  i2cService.sendMessageToSlave(slaveOneAddress,message);

	  String stringMessage = i2cService.readMessageFromSlave(5);
	  print("Received message: ");
	  println(stringMessage);
	}

	//Turn led number on through i2c line
	void off(int ledNumber){
	  println("Turning LED "+ledNumber+" off");
	  String message = "LED"+"00"+ utility.padTwoDigits(ledNumber)+"000000000";
	  //Form must be LED0101RD (LED)(State)(Position)(Black)
	  i2cService.sendMessageToSlave(slaveOneAddress,message);
	  String stringMessage = i2cService.readMessageFromSlave(6);
	  print("Received message: ");
	  println(stringMessage);
	}
}