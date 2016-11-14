
class ButtonService{
	I2CMasterService i2cService;
	Utility utility;
  int[] buttonStates;

	ButtonService(I2CMasterService i2cService, Utility utility){
		this.i2cService = i2cService;
		this.utility = utility;
    this.buttonStates = new int[numberButtons];
	}

	//This gets all of states of the buttons
	//Expect a string of 2 digit bytes that will correlate to the state
	//Example for 3 max buttons (6bytes) 010001 is (01)(00)(01) for buttons (but1)(but2)(but3)
	String getStatesFromI2C()
	{
	  //send a message to the slave to request button state
	  String message = "BUT";
	  i2cService.sendMessageToSlave(slaveOneAddress, message);
	  String stringMessage = i2cService.readMessageFromSlave(numberButtons*2);

	  print("Received message: ");
	  println(stringMessage);
	  
	  return stringMessage;
	}

	int[] convertStringToButtonStatesArray(String buttonByteString){
		for(int i = 0; i < numberButtons; i++){
			buttonStates[i] = int(buttonByteString.substring(i * 2, (i * 2) + 2));
		}
		println("ButtonStateArray");
		printArray(buttonStates);
		return buttonStates;

	}

	int getButtonState(int buttonNumber){
		return buttonStates[buttonNumber-1];
	}
}