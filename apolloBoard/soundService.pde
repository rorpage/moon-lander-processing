import ddf.minim.*;

class SoundService {
  PApplet parent;
  
  final String SOUND_EFFECTS_FOLDER = "sound_effects";
  final String LAUNCH_FOLDER = SOUND_EFFECTS_FOLDER + "/launch";
  
  final String[] launchEffects = new String[15];
  
  SoundService(PApplet parent) {
    this.parent = parent;
    
    setupArrays();
  }
  
  void setupArrays() {
    launchEffects[0] = "booster.mp3";
    launchEffects[1] = "capcom.mp3";
    launchEffects[2] = "control.mp3";
    launchEffects[3] = "eecom.mp3";
    launchEffects[4] = "fao.mp3";
    launchEffects[5] = "fido.mp3";
    launchEffects[6] = "gnc.mp3";
    launchEffects[7] = "guidance.mp3";
    launchEffects[8] = "inco.mp3";
    launchEffects[9] = "network.mp3";
    launchEffects[10] = "procedures.mp3";
    launchEffects[11] = "recovery.mp3";
    launchEffects[12] = "retro.mp3";
    launchEffects[13] = "surgeon.mp3";
    launchEffects[14] = "telmu.mp3";
  }
  
  // Launch
  void playBooster() {
    playLaunchEffect(0);
  }
  
  void playCapcom() {
    playLaunchEffect(1);
  }
  
  void playControl() {
    playLaunchEffect(2);
  }
  
  void playEecom() {
    playLaunchEffect(3);
  }
  
  void playFao() {
    playLaunchEffect(4);
  }
  
  void playFido() {
    playLaunchEffect(5);
  }
  
  void playGnc() {
    playLaunchEffect(6);
  }
  
  void playGuidance() {
    playLaunchEffect(7);
  }
  
  void playInco() {
    playLaunchEffect(8);
  }
  
  void playNetwork() {
    playLaunchEffect(9);
  }
  
  void playProcedures() {
    playLaunchEffect(10);
  }
  
  void playRecovery() {
    playLaunchEffect(11);
  }
  
  void playRetro() {
    playLaunchEffect(12);
  }
  
  void playSurgeon() {
    playLaunchEffect(13);
  }
  
  void playTelmu() {
    playLaunchEffect(14);
  }
  
  private void playLaunchEffect(int index) {
    Minim minim = new Minim(parent);
    AudioPlayer ap = minim.loadFile(LAUNCH_FOLDER + "/" + launchEffects[index]);
    ap.play();
  }
  
  // Sound Effects
  void playBatteryCharge() {
    playSoundEffect("battery charge.mp3");
  }
  
  void playCabinPressure() {
    playSoundEffect("cabin pressure.mp3");
  }
  
  void playDeployChutes() {
    playSoundEffect("deploy chutes.mp3");
  }
  
  void playHeatShield() {
    playSoundEffect("heat shield.mp3");
  }
  
  void playOxygenSupply() {
    playSoundEffect("oxygen supply.mp3");
  }
  
  void playReleaseCommandModule() {
    playSoundEffect("release command module.mp3");
  }
  
  void playWasteManagement() {
    playSoundEffect("waste management.mp3");
  }
  
  private void playSoundEffect(String filename) {
    Minim minim = new Minim(parent);
    AudioPlayer ap = minim.loadFile(SOUND_EFFECTS_FOLDER + "/" + filename);
    ap.play();
  }
}