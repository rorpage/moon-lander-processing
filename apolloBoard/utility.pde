class Utility{
	int activated = 1;
	Utility(){
	}

	String padTwoDigits(int numberToConvert)
	{
	  String returnNumber ="";
	  if(numberToConvert < 10) //<>// //<>// //<>//
	  {
	    returnNumber = "0"+str(numberToConvert);
	  }
	  else{
	    returnNumber = str(numberToConvert);
	  }
	  return returnNumber;
	}

	String padFourDigits(int numberToConvert)
	{
		String returnNumber = "";
		if(numberToConvert < 10) //<>// //<>//
		{
		  returnNumber = "000"+str(numberToConvert);
		}
		else if(numberToConvert < 100){
		  returnNumber = "00"+str(numberToConvert);
		}
		else if(numberToConvert < 1000){
		  returnNumber = "0"+str(numberToConvert);
		}
		else{
			returnNumber = str(numberToConvert);
		}
  return returnNumber;
	}
}