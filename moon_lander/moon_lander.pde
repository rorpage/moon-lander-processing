final float GRAVITY = 0.016;
final float AIR = 0.99;
final float TURN_VALUE = PI/40;
final float PROP = 0.05;

final int MOON_HEIGHT = 30;

final int LANDING_PLATFORM_HEIGHT = 60;
final int LANDING_PLATFORM_WIDTH = 100;

float platformLeft = 0;
int platformHeight = 0;

Ship ship;

boolean[] keys = new boolean[4];

void setup() {
  size(1000, 800);
  
  ship = new Ship(new PVector(width / 2, -20), 10);
  
  platformLeft = random(0, width - LANDING_PLATFORM_WIDTH);
  platformHeight = height - (2 * MOON_HEIGHT) + 10;
}

void draw() {
  model();
  view();
}

// physics stuff
void model() {
  handleKeys();
  ship.move();
}

void updateStats() {
  stroke(255);
  fill(0);
  rect(15, 5, 100, 40);
  fill(255);
  text("Speed: " + ship.speed, 20, 20);
  text("Fuel: " + ship.fuel, 20, 40);
}

// drawing stuff
void view() {
  background(0);
  
  stroke(128);
  fill(128);
  rect(platformLeft, platformHeight, LANDING_PLATFORM_WIDTH, LANDING_PLATFORM_HEIGHT);
  
  fill(255);
  arc(width / 2, height, width, MOON_HEIGHT, PI, PI * 2, OPEN);
  
  ship.draw();

  updateStats();
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
      case 'r':
        keys[3] = false; break;
    }
  } else {
    switch (key) {
      case 'r':
        keys[3] = false; break;
    }
  }
}

void handleKeys() {
  if (keys[0]) ship.thrust();            // THRUST
  if (keys[1]) ship.turns(-TURN_VALUE);  // LEFT
  if (keys[2]) ship.turns(TURN_VALUE);   // RIGHT
  if (keys[3]) setup();                  // r
}

class Ship {

  PVector pos;   // position
  float rot;     // rotation angle
  PVector dis;   // displacement
  float speed;
  float fuel;
  
  int siz;       // size
  PVector[] pt;  // shape
  
  Ship(PVector pos, int siz) {
    this.pos = pos;
    this.siz = siz;
    this.fuel = 100;
    dis = new PVector(0, 0);
    // the ship has its nose upwards
    rot = -PI/2;
    pt = new PVector[3];
    updatePoints();
  }
  
  /**
   * calculate the coordinates of the shape
   */
  void updatePoints() {
    // nose
    pt[0] = new PVector(pos.x+siz*cos(rot), pos.y+siz*sin(rot));
    // bottom left
    pt[1] = new PVector(pos.x+1.7*siz*cos(rot+(PI+0.7)), pos.y+1.7*siz*sin(rot+(PI+0.7)));
    // bottom right
    pt[2] = new PVector(pos.x+1.7*siz*cos(rot+(PI-0.7)), pos.y+1.7*siz*sin(rot+(PI-0.7)));
  }
  
  /**
   * display the ship on screen
   */
  void draw() {
    if (outOfFuel()) {
      fuel = 0;
      fill(255);
      text("You ran out of fuel.", width / 2, height / 2);
    } else if (didLand()) {
      fill(255);
      text("That's one small step for man, and one giant leap for mankind...", width / 2, height / 2);
    } else if (didCrash()) {
      fill(255);
      text("Oops! You crashed!", width / 2, height / 2);
    } else {
      strokeWeight(1); stroke(255); fill(0);
      triangle(pt[0].x, pt[0].y, pt[1].x, pt[1].y, pt[2].x, pt[2].y);
    }
  }

  void move() {
    // friction
    dis.mult(AIR);

    // gravity
    dis.y += GRAVITY;

    // propulsion
    if (keys[0]) {
      dis.add(new PVector(PROP*cos(rot), PROP*sin(rot)));
      fuel -= 0.1;
    }

    // deplacement
    pos.add(dis);
    updatePoints();
  }
  
  void turns(float angle) {
    rot += angle;
  }
  
  void thrust() {
    if (speed < 1) speed += 0.1;
  }

  boolean outOfFuel() {
    return fuel <= 0;
  }

  boolean didLand() {
    return (pt[1].y >= platformHeight || pt[2].y >= platformHeight) &&
      (pt[1].x >= platformLeft && pt[2].x <= platformLeft + LANDING_PLATFORM_WIDTH);
  }

  boolean didCrash() {
    if (didLand() && speed > 0.5) {
      return true;
    }

    return false;
  }
}