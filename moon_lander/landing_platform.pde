class LandingPlatform {

  final int LANDING_PLATFORM_HEIGHT = 60;
  final int LANDING_PLATFORM_WIDTH = 100;

  float left = 0;
  int selfHeight = 0;
  
  LandingPlatform(int moonHeight) {
    left = random(0, width - LANDING_PLATFORM_WIDTH);
    selfHeight = height - (2 * moonHeight) + 10;
  }
  
  void draw() {
    stroke(128);
    fill(128);
    rect(left, selfHeight, LANDING_PLATFORM_WIDTH, LANDING_PLATFORM_HEIGHT);
  }
}