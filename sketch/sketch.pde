PImage img1, img2, img3; // Images for the two balls and the collision

Ball ball1;
Ball ball2;
color[] rainbowColors;
int colorIndex = 0;
float lerpFactor = 0;

class Ball {
  float r;   // radius
  float x, y; // location
  float xspeed, yspeed; // speed
  PImage img; // Image for the ball
  PImage originalImg; // Store the original image

  Ball(float tempR, PImage tempImg) {
    r = tempR;
    x = random(width);
    y = random(height);
    xspeed = random(-7, 7);
    while (xspeed >= -3 && 3 >= xspeed)
      xspeed = random(-7, 7);
    
    yspeed = random(-7, 7);
    while (yspeed >= -3 && 3 >= yspeed)
      yspeed = random(-7, 7);
    img = tempImg; // Assign the image
    originalImg = tempImg; // Store the original image
  }

  void move() {
    x += xspeed;
    y += yspeed;
    if (x > width || x < 0) {
      xspeed *= -1;
    }
    if (y > height || y < 0) {
      yspeed *= -1;
    }
  }

  void display() {
    image(img, x - r, y - r, r*2, r*2); // Display the image at the ball's location
    //image(img, x - r, y - r, r*width / 4, r*height / 4);
  }

  void changeImage(PImage newImg) {
    img = newImg; // Method to change the ball's image
  }

  void resetImage() {
    img = originalImg; // Reset to the original image
  }
}

void setup() {
  fullScreen();
  //size(1280, 720);
  img1 = loadImage("image01.png");
  img2 = loadImage("image02.png");
  img3 = loadImage("image03.png");
  ball1 = new Ball(128, img1);
  ball2 = new Ball(128, img2);
  
  // Initialize the rainbow colors
  rainbowColors = new color[7];
  rainbowColors[0] = color(255, 0, 0);    // Red
  rainbowColors[1] = color(255, 127, 0); // Orange
  rainbowColors[2] = color(255, 255, 0); // Yellow
  rainbowColors[3] = color(0, 255, 0);   // Green
  rainbowColors[4] = color(0, 0, 255);   // Blue
  rainbowColors[5] = color(75, 0, 130);  // Indigo
  rainbowColors[6] = color(148, 0, 211); // Violet
}


void draw() {
  // Update the lerp factor for a smooth transition
  lerpFactor += 0.01; // Adjust this value for speed of color change
  if (lerpFactor > 1) {
    lerpFactor = 0;
    colorIndex++;
  }

  color currentColor = lerpColor(rainbowColors[colorIndex % 7], rainbowColors[(colorIndex + 1) % 7], lerpFactor);
  background(currentColor);
 
  ball1.move();
  ball2.move();
  ball1.display();
  ball2.display();

  // Check for collision
  if (dist(ball1.x, ball1.y, ball2.x, ball2.y) < ball1.r + ball2.r) {
    ball1.changeImage(img3);
    ball2.changeImage(img3);
  } else {
    // Reset images if they are not colliding
    ball1.resetImage();
    ball2.resetImage();
  }
}
