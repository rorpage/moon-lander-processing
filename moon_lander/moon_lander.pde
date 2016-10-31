boolean[] keys = new boolean[4];
MoonLander moonLander = new MoonLander();

void setup() {
  size(1000, 800);
  moonLander.setup();
}

void draw() {
  moonLander.draw();
}

void keyPressed() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        keys[0] = true; break;
      case LEFT:
        keys[1] = true;  break;
      case RIGHT:
        keys[2] = true; break;
    }
  } else {
    switch (key) {
      case 'r':
        keys[3] = true; break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        keys[0] = false; break;
      case LEFT:
        keys[1] = false; break;
      case RIGHT:
        keys[2] = false; break;
    }
  } else {
    switch (key) {
      case 'r':
        keys[3] = false; break;
    }
  }
}

class MoonLander {
  final int MOON_HEIGHT = 30;
  final float TURN_VALUE = PI/40;
  
  Ship ship;
  LandingPlatform landingPlatform;
  
  void setup() {
    landingPlatform = new LandingPlatform(MOON_HEIGHT);
    ship = new Ship(new PVector(width / 2, -20), 10, landingPlatform.selfHeight, 
        landingPlatform.left, landingPlatform.LANDING_PLATFORM_WIDTH, MOON_HEIGHT);
  }
  
  void draw() {
    handleKeys();
    
    if (!ship.isFrozen) {
      model();
    }

    view();
  }
  
  // physics stuff
  void model() {
    ship.move(keys);
  }
  
  void updateStats() {
    stroke(255);
    fill(0);
    rect(15, 5, 110, 40);
    fill(255);
    text("Speed: " + ship.speed, 20, 20);
    text("Fuel: " + ship.fuel, 20, 40);
  }
  
  // drawing stuff
  void view() {
    background(0);
    
    landingPlatform.draw();
    
    fill(255);
    arc(width / 2, height, width, MOON_HEIGHT, PI, PI * 2, OPEN);
    
    if (ship.status == 0) {
      ship.draw();
    } else {
      if (ship.status == 1) {
        fill(255);
        text("You ran out of fuel.", width / 2, height / 2);
      } else if (ship.status == 2) {
        fill(255);
        text("That's one small step for man, and one giant leap for mankind...", width / 2, height / 2);
      } else if (ship.status == 3) {
        fill(255);
        text("Oops! You crashed!", width / 2, height / 2);
      }
    }
  
    updateStats();
  }

  void handleKeys() {
    if (keys[0]) ship.thrust();            // THRUST
    if (keys[1]) ship.turns(-TURN_VALUE);  // LEFT
    if (keys[2]) ship.turns(TURN_VALUE);   // RIGHT
    if (keys[3]) setup();                  // r
  }
}