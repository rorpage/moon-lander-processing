class I2CMasterService{
  I2C i2c;
	//Constructor
	I2CMasterService(I2C i2c){
		this.i2c = i2c;
	}


	//Functions
	String convertByteArrayToString(byte[] inByte){
	  String message = "";
	  for(int i = 0; i < inByte.length; i++)
	  {
	    message += (char)inByte[i];
	  }
	  return message;
	}

	void sendMessageToSlave(int slaveId, String message)
	{
	  println("Sending \""+message+"\" to slave "+slaveId);
	  i2c.beginTransmission(slaveId);
	  i2c.write(message);
	}

	//Reads in byte and converts to string
	String readMessageFromSlave(int numberOfBytes){
	  byte[] in = i2c.read(numberOfBytes);	  
	  String stringMessage = this.convertByteArrayToString(in);
	  println("Read \""+stringMessage+"\" from slave");

	  return stringMessage;
	}




}