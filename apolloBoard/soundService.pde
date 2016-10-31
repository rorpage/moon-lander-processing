import processing.sound.*;

class SoundService {
  PApplet parent;
  
  SoundService(PApplet parent) {
    this.parent = parent;
  }
  
  void playDeployChutes() {
    new SoundFile(this.parent, "/sound_effects/deploy chutes.mp3").play();
  }
}