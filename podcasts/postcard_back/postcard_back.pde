/*

FIVETHIRTYEIGHT POSTCARD BAck

bdharva
Started: 03-11-2016
Last Edited: 03-26-2016

*/

// Drawing size

int width = 900;
int height = 600;
int margin = 20;
int padding = 12;

// Canvas sizing

int canvas1StartX = 4*margin;
int canvas1EndX = width/2-2*margin;
int canvas1StartY = 3*margin;
int canvas1EndY = height/2-margin-padding;


// Palette colors

color white = color(255,255,255);
color gray05 = color(243,243,243);
color gray10 = color(230,230,230);
color gray15 = color(217,217,217);
color gray20 = color(204,204,204);
color gray30 = color(179,179,179);
color gray40 = color(153,153,153);
color gray50 = color(128,128,128);
color gray60 = color(102,102,102);
color gray80 = color(50,50,50);

// Podcast colors

int opacity = 255;
color carolla = color(200,40,0,opacity);
color traction = color(210,80,10,opacity);
color replyall = color(220,120,20,opacity);
color serial = color(230,160,30,opacity);
color radiolab = color(240,200,40,opacity);
color freak = color(180,175,27,opacity);
color wtp = color(120,150,13,opacity);
color nnpi = color(60,125,0,opacity);
color money = color(0,100,200,opacity);
color hottake = color(50,85,150,opacity);
color ferriss = color(100,70,100,opacity);

// Fonts

PFont titleFont;
PFont subtitleFont;
PFont bodyFont;

void setup() {
  
  size(width, height);
  colorMode(RGB, 255);
  
  // Fonts
  
  titleFont = createFont("Roboto-Regular", 24);
  subtitleFont = createFont("Roboto-Regular", 16);
  bodyFont = createFont("Roboto-Regular", 12);
  
  // Make & save graphic
  
  reportData();
  save("podcasts.png");

}

void draw() {}

void reportData(){

  background(gray05);
  stroke(gray10);
  strokeWeight(2);
  line(width/2, 3*margin, width/2, height-3*margin);
  
  // Time grid
  
  for (int i = 0; i <= 24; i++) {
    
    float x = map(i, 0, 24, canvas1StartX, canvas1EndX);
    stroke(gray10);
    strokeWeight(1);
    line(x, canvas1StartY, x, canvas1EndY);
    
  }
  
  // Day grid
  
  for (int i = 1; i <= 7; i++) {
    
    float y = map(i, 1, 7, canvas1StartY, canvas1EndY);
    stroke(gray10);
    strokeWeight(1);
    line(canvas1StartX, y, canvas1EndX, y);
    
  }
  
  // Outline
  
  stroke(gray40);
  line(canvas1StartX, canvas1StartY, canvas1StartX, canvas1EndY);
  line(canvas1EndX, canvas1StartY, canvas1EndX, canvas1EndY);
  line(canvas1StartX, canvas1StartY, canvas1EndX, canvas1StartY);
  line(canvas1StartX, canvas1EndY, canvas1EndX, canvas1EndY);
  
  // Time labels
  
  for (int i = 0; i <= 24; i+=4) {
    
    float x = map(i, 0, 24, canvas1StartX, canvas1EndX);
    fill(gray40);
    noStroke();
    textAlign(CENTER, TOP);
    textFont(bodyFont);
    fill(gray50);
    text(i + ":00", x, canvas1EndY+padding);
    
  }
  
  // Day labels
  
  for (int i = 11; i <= 17; i++) {
    
    float y = map(i, 11, 17, canvas1StartY, canvas1EndY);
    noStroke();
    textAlign(LEFT, CENTER);
    textFont(bodyFont);
    fill(gray60);
    text("3/" + i, canvas1StartX-2*margin, y);
    
  }
  
  // Activity labels
  
  noStroke();
  textFont(bodyFont);
  fill(gray60);
  
  textAlign(LEFT, TOP);
  text("Working", canvas1StartX+padding/2, canvas1StartY+padding/2-3);
  
  textAlign(RIGHT, TOP);
  text("Local Driving", canvas1EndX-padding/2, canvas1StartY+padding/2-3);
  
  textAlign(LEFT, BOTTOM);
  text("Working Out", canvas1StartX+padding/2, canvas1EndY-padding/2+3);
  
  textAlign(RIGHT, BOTTOM);
  text("Highway Driving", canvas1EndX-padding/2, canvas1EndY-padding/2+3);
  
  // Title
  
  textFont(subtitleFont);
  textAlign(CENTER, CENTER);
  text("FiveThirtyEight x Dear Data", (canvas1StartX+canvas1EndX)/2, (canvas1StartY+canvas1EndY)/2-padding);
  text("A Week of Podcasts", (canvas1StartX+canvas1EndX)/2, (canvas1StartY+canvas1EndY)/2+padding);
  
  // Bubble key
  
  stroke(gray20);
  line(width/4-2*margin, height/2+margin*6, width/4-2*margin, height/2+margin*4);
  line(width/4+2*margin, height/2+margin*6, width/4+2*margin, height/2+margin*4);
  stroke(gray40);
  line(canvas1StartX-2*margin, height/2+margin*4, canvas1EndX, height/2+margin*4);
  line(width/4, height/2+margin*4, width/4+4*margin, height/2+margin);
  fill(gray05);
  ellipse(width/4, height/2+margin*4, 4*margin, 4*margin);
  
  // Bubble key labels
  
  noStroke();
  textFont(bodyFont);
  fill(gray60);
  textAlign(LEFT, BOTTOM);
  text("Day", canvas1StartX-2*margin, height/2+margin*4-padding/2);
  textAlign(LEFT, TOP);
  text("End Time", width/4+2*margin+padding/2, height/2+margin*4+padding);
  textAlign(RIGHT, TOP);
  text("Start Time", width/4-2*margin-padding/2, height/2+margin*4+padding);
  textAlign(LEFT, CENTER);
  text("Activity Line", width/4+4*margin+padding/2, height/2+margin-3);
  textAlign(CENTER, CENTER);
  text("Podcast", width/4, height/2+margin*4-3);
  
  // Color key
  
  float x0 = 2*margin;
  float y0 = 3*height/4+padding;
  float xStart = 0;
  float xEnd = 0;
  float yStart = 0;
  float yEnd = 0;
  float x9 = width/2-2*margin;
  
  textAlign(LEFT, BOTTOM);
  text("Podcast Color Codes", x0, y0-padding);
  
  String[] casts = {"Adam Carolla Show", "Traction", "Reply All", "Serial", "Radiolab", "Freakonomics", "What's the Point", "99% Invisible", "Planet Money", "Hot Takedown", "Tim Ferriss Show"};
  
  for (int i = 0; i < casts.length; i++) {
    textFont(bodyFont);
    String name = casts[i];
    float nameWidth = textWidth(name);
    float nameHeight = textAscent() + textDescent();
    float padding = 4;
    if (x0 + xStart + 3*padding + nameWidth > x9) {
      yStart += 30;
      xStart = 0;
    }
    if(casts[i].equals("Adam Carolla Show") == true) {
      fill(carolla);
    }else if(casts[i].equals("Traction") == true) {
      fill(traction);
    }else if(casts[i].equals("Reply All") == true) {
      fill(replyall);
    }else if(casts[i].equals("Serial") == true) {
      fill(serial);
    }else if(casts[i].equals("Radiolab") == true) {
      fill(radiolab);
    }else if(casts[i].equals("Freakonomics") == true) {
      fill(freak);
    }else if(casts[i].equals("What's the Point") == true) {
      fill(wtp);
    }else if(casts[i].equals("99% Invisible") == true) {
      fill(nnpi);
    }else if(casts[i].equals("Planet Money") == true) {
      fill(money);
    }else if(casts[i].equals("Hot Takedown") == true) {
      fill(hottake);
    }else if(casts[i].equals("Tim Ferriss Show") == true) {
      fill(ferriss);
    }
    
    rectMode(CORNER);
    noStroke();
    rect(x0+xStart, y0+yStart, nameWidth+2*padding, (nameHeight+2*padding));
    
    fill(255,255,255);
    textAlign(LEFT, TOP);
    text(casts[i], x0+xStart+padding, y0+yStart+padding);
    
    xStart = xStart + nameWidth + 3*padding;
  }
  
  // From Fields
  
  stroke(gray20);
  line(width/2+2*margin, height/4+30, 3*width/4, height/4+30);
  line(width/2+2*margin, height/4+60, 3*width/4, height/4+60);
  line(width/2+2*margin, height/4+90, 3*width/4, height/4+90);
  
  noStroke();
  fill(gray60);
  textFont(subtitleFont);
  textAlign(LEFT, BOTTOM);
  text("FROM:", width/2+2*margin, height/4);
  text("Benjamin Harvatine", width/2+2*margin, height/4+30);
  text("810 Lee Avenue", width/2+2*margin, height/4+60);
  text("Sykesville, MD 21784", width/2+2*margin, height/4+90);
  
  // To Fields
  
  stroke(gray20);
  line(width/2+2*margin, height/2+40, width-2*margin, height/2+40);
  line(width/2+2*margin, height/2+80, width-2*margin, height/2+80);
  line(width/2+2*margin, height/2+120, width-2*margin, height/2+120);
  line(width/2+2*margin, height/2+160, width-2*margin, height/2+160);
  
  noStroke();
  fill(gray60);
  textFont(subtitleFont);
  textAlign(LEFT, BOTTOM);
  text("TO:", width/2+2*margin, height/2);
  textFont(titleFont);
  text("Jody Avirgan", width/2+2*margin, height/2+40);
  text("FiveThirtyEight", width/2+2*margin, height/2+80);
  text("147 Columbus Ave, 4th Floor", width/2+2*margin, height/2+120);
  text("New York, NY 10023", width/2+2*margin, height/2+160);
  
  // Stamp
  
  rectMode(CORNERS);
  stroke(gray20);
  noFill();
  rect(width-2*margin, 2*margin, width-2*margin-130, 2*margin+150);
  
}
