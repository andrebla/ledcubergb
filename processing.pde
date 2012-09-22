import processing.serial.*;

Serial port;

color currentcolor;

RectButton rect2, rect4, rect5, rect8;

boolean locked = false;

void desligado() {
  int output = 0;
  byte [] matrix = new byte[50+1];
  matrix[0] = (byte) 0x55;
  for (int j=0; j < 50; j++) {
    matrix[j+1] = (byte) output;
  }
  port.write(matrix);
  println(matrix);
}

void verde() {
  byte [] matrix = new byte[50+1];
  matrix[0] = (byte) 0x55;
  for (int j=0; j < 50; j = j + 2) {
    matrix[j+1] = (byte) 36;
  }
  for (int j=1; j < 50; j = j + 2) {
    matrix[j+1] = (byte) 73;
  }
  port.write(matrix);
  println(matrix);
}

void vermelho() {
  byte [] matrix = new byte[50+1];
  matrix[0] = (byte) 0x55;
  for (int j=0; j < 50; j = j + 2) {
    matrix[j+1] = (byte) 73;
  }
  for (int j=1; j < 50; j = j + 2) {
    matrix[j+1] = (byte) 146;
  }
  port.write(matrix);
  println(matrix);
}

void azul() {
  byte [] matrix = new byte[50+1];
  matrix[0] = (byte) 0x55;
  for (int j=0; j < 50; j = j + 2) {
    matrix[j+1] = (byte) 146;
  }
  for (int j=1; j < 50; j = j + 2) {
    matrix[j+1] = (byte) 36;
  }
  port.write(matrix);
  println(matrix);
}

void setup()
{
  port = new Serial(this,"COM3",9600);
  size(220, 70);
  smooth();

  color baseColor = color(102);
  currentcolor = baseColor;

  // Define and create circle button
  color buttoncolor = color(204);
  color highlight = color(153);
  ellipseMode(CENTER);

  // Define and create rectangle button
  buttoncolor = color(206,0,0);
  highlight = color(51); 
  rect2 = new RectButton(10, 10, 50, buttoncolor, highlight);
  
  // Define and create rectangle button
  buttoncolor = color(13,219,0);
  highlight = color(51); 
  rect4 = new RectButton(60, 10, 50, buttoncolor, highlight);
  
  // Define and create rectangle button
  buttoncolor = color(0,104,237);
  highlight = color(51); 
  rect5 = new RectButton(110, 10, 50, buttoncolor, highlight);
  
  // Define and create rectangle button
  buttoncolor = color(0,0,0);
  highlight = color(51); 
  rect8 = new RectButton(160, 10, 50, buttoncolor, highlight);
}

void draw()
{
  background(currentcolor);
  stroke(255);
  update(mouseX, mouseY);
  rect2.display();
  rect4.display();
  rect5.display();
  rect8.display();
}

void update(int x, int y)
{
  if(locked == false) {
    rect2.update();
    rect4.update();
    rect5.update();
    rect8.update();
  } 
  else {
    locked = false;
  }

  if(mousePressed) {
    if(rect2.pressed()) {
      currentcolor = rect2.basecolor;
      vermelho();
    }
    else if(rect4.pressed()) {
      currentcolor = rect4.basecolor;
      verde();
    }
    else if(rect5.pressed()) {
      currentcolor = rect5.basecolor;
      azul();
    }
    else if(rect8.pressed()) {
      currentcolor = rect8.basecolor;
      desligado();
    }
  }
}


class Button
{
  int x, y;
  int size;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;   

  void update() 
  {
    if(over()) {
      currentcolor = highlightcolor;
    } 
    else {
      currentcolor = basecolor;
    }
  }

  boolean pressed() 
  {
    if(over) {
      locked = true;
      return true;
    } 
    else {
      locked = false;
      return false;
    }    
  }

  boolean over() 
  { 
    return true; 
  }

  boolean overRect(int x, int y, int width, int height) 
  {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } 
    else {
      return false;
    }
  }

}



class RectButton extends Button
{
  RectButton(int ix, int iy, int isize, color icolor, color ihighlight) 
  {
    x = ix;
    y = iy;
    size = isize;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
  }

  boolean over() 
  {
    if( overRect(x, y, size, size) ) {
      over = true;
      return true;
    } 
    else {
      over = false;
      return false;
    }
  }

  void display() 
  {
    stroke(255);
    fill(currentcolor);
    rect(x, y, size, size);
  }
}

