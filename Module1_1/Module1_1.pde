import ddf.minim.*;
import java.util.Random;
import java.util.*;

public class ButtonGame{
  

    public ButtonGame(LedService ledService, ButtonsService buttonService){
      this._ledService = ledService;
      this._buttonService = buttonService;
      this.numberOfButtons = 9;
      this.Buttons = new int[numberOfButtons];
      this.LEDs = new int[numberOfButtons];
      this.soundEffects = new AudioSnippet[numberOfButtons];
      this.currentCount =  millis();
      this.generated = new LinkedHashSet<Integer>();
      this.minim = new Minim(this);
      
      this.InitializeSounds();
   
      this.buzz = minim.loadSnippet("timeup.mp3");
      this.currentMillis = millis();
      this.soundFound = false;
    }
   
   private LedService _ledService;
   private ButtonsService _buttonService; 
   private int[] Buttons;
   private int[] LEDs;
   private AudioSnippet[] soundEffects;
   private int currentNumber;
   private int currentCount;
   private Set<Integer> generated;
   private boolean soundFound = false;
   private Minim minim;
   private AudioSnippet buzz;
   private int currentMillis;
   private int numberOfButtons;
   
   private void InitializeSounds(){
     for(int i=0; i<soundEffects.length; i++)
     {
        this.soundEffects[i] = minim.loadSnippet("SoundEffect"+(i+1)+".mp3");
     }
   }
   private void PlayRandomSound()
   {
  int randomNumber = GetRandomNumber();
  this.currentNumber = randomNumber;  
  PlaySound(soundEffects[randomNumber-1]);
   }
  
   private void PlaySound(AudioSnippet soundEffect)
   {
  soundEffect.rewind();
  soundEffect.play();
  this.currentMillis = millis();
  this.currentCount = millis();
  this.soundFound = false;
  for(int i=0; i<this.LEDs.length; i++)
  {
     this._ledService.off(i+1);
    }
   }
  
  private int GetRandomNumber()
  {
    Random rng = new Random();   
    int size = generated.size();
    int generatedNumber = 0;
    if(generated.size()>=numberOfButtons)
    {
      size = 0;
      generated = new LinkedHashSet<Integer>();
    }
    while (generated.size() == size)
    {
      generatedNumber = rng.nextInt(numberOfButtons) + 1;
      generated.add(generatedNumber);
    }
  
    return generatedNumber;
  }
  
  private void ListenToButtonClick(){
    String[] buttonsArray = this._buttonService.getStates();
    for(int i=0; i<buttonsArray.length; i++){
      if(buttonsArray[i]=="01")
      {
        if(this.currentNumber == i+1)
        {
          TurnOnLED(i, 000255000);
           
           if(!this.soundFound)
           {
             this.soundFound = true;
             this.currentMillis = millis();
            }
            
            if(millis() - this.currentMillis > 3000)
            {
              this._ledService.off(i+1);
            }
        }
        else
        {
          TurnOnLED(i, 255000000);
        }
      }
    }
  }
  private void TurnOnLED(int index, int rgb)
  {
    this._ledService.on(1,rgb);  
  }
  
  private void TurnOffAllLed()
  {
   for(int i=0; i<this.LEDs.length; i++)
   {
     this._ledService.off(i+1);
   }
  }

  public void Draw() 
  {
    TurnOffAllLed();
    ListenToButtonClick();
      
    if(this.soundFound)
    {
      if(millis() - this.currentMillis > 3000)
      {
        this.PlayRandomSound();
      }
    }
      
    if(millis() - this.currentCount > 5000 && !this.soundFound)
    {
       this.soundFound = true;
       this.currentMillis = millis();
       this.currentCount = millis();
       this.buzz.rewind();
       this.buzz.play();
       this.TurnOffAllLed();
    }
  }
}