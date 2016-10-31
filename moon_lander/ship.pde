class Ship {
  
  final float PROP = 0.05;
  final float GRAVITY = 0.016;
  final float AIR = 0.99;

  PVector pos;   // position
  float rot;     // rotation angle
  PVector dis;   // displacement
  float speed;
  float fuel;
  
  int siz;       // size
  PVector[] pt;  // shape
  
  int platformHeight;
  float platformLeft;
  int platformWidth;
  int moonHeight;
  
  boolean isFrozen = false;
  int status = 0;
  
  Ship(PVector pos, int siz, int platformHeight, float platformLeft, int platformWidth, int moonHeight) {
    this.pos = pos;
    this.siz = siz;
    this.fuel = 100;
    
    this.platformHeight = platformHeight;
    this.platformLeft = platformLeft;
    this.platformWidth = platformWidth;
    
    this.moonHeight = moonHeight;
    
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
      status = 1;
      fuel = 0;
      freeze();
    } else if (didLand()) {
      status = 2;
      freeze();
    } else if (didCrash()) {
      status = 3;
      freeze();
    } else {
      status = 0;
      strokeWeight(1); stroke(255); fill(0);
      triangle(pt[0].x, pt[0].y, pt[1].x, pt[1].y, pt[2].x, pt[2].y);
    }
  }

  void move(boolean[] keys) {
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
    return (pt[1].y >= platformHeight || pt[2].y >= platformHeight) && isWithinLandingPlatformXCoords();
  }

  boolean didCrash() {
    if (didLand() && speed > 0.5) {
      return true;
    }
    
    return pt[1].y >= (height - moonHeight) || pt[2].y >= (height - moonHeight) && !isWithinLandingPlatformXCoords();
  }
  
  boolean isWithinLandingPlatformXCoords() {
    return pt[1].x >= platformLeft && pt[2].x <= platformLeft + platformWidth;
  }
  
  void freeze() {
    pt[0].x = -100;
    pt[0].y = -100;
    pt[1].x = -100;
    pt[1].y = -100;
    pt[2].x = -100;
    pt[2].y = -100;
    
    isFrozen = true;
  }
}