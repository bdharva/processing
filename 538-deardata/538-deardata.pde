/*

FIVETHIRTYEIGHT POSTCARD

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

int canvasStartX = 0;
int canvasEndX = width;
int canvasStartY = 0;
int canvasEndY = height-(36);
int dayStart = 0*60;
int sunStart = 7*60;
int sunEnd = 19*60;
int dayEnd = 24*60;

// Palette colors

color gray05 = color(243,243,243);
color gray10 = color(230,230,230);
color gray15 = color(217,217,217);
color gray20 = color(204,204,204);
color gray30 = color(179,179,179);
color gray40 = color(153,153,153);
color gray50 = color(128,128,128);
color gray60 = color(102,102,102);

// Podcast colors

color carolla = color(200,40,40,150);
color traction = color(0,40,200,150);
color replyall = color(40,140,200,150);
color serial = color(40,40,40,150);
color radiolab = color(255,100,0,150);
color freak = color(0,200,40,150);
color wtp = color(140,40,200,150);
color nnpi = color(255,188,0,150);
color money = color(40,200,140,150);
color allusionist = color(179,128,255,150);
color ferriss = color(255,80,160,150);
color hottake = color(200,0,140,150);

// Fonts

PFont titleFont;
PFont subtitleFont;
PFont bodyFont;

void setup() {
  
  size(width, height);
  colorMode(RGB, 255);
  
  // Fonts
  
  titleFont = createFont("Roboto-Bold", 28);
  subtitleFont = createFont("Roboto-Regular", 16);
  bodyFont = createFont("Roboto-Regular", 12);
  
  // Make & save graphic
  
  reportData();
  save("podcasts.png");

}

void draw() {}

void reportData(){
  
  // Load podcast listening data
  
  JSONObject json = loadJSONObject("data.json");
  JSONArray listens = json.getJSONArray("listens");
  
  // Create empty arrays for podcast listening data
  
  int[] dates = new int[listens.size()];
  String[] startTimes = new String[listens.size()];
  String[] endTimes = new String[listens.size()];
  String[] podcasts = new String[listens.size()];
  int[] locations = new int[listens.size()];
  
  String[] casts = new String[11];
  
  // Fill empty arrays with podcast listening data
  
  int counter = 0;
  
  for (int i = 0; i < listens.size(); i++) {
  
    JSONObject event = listens.getJSONObject(i);
    int[] dateArray = int(splitTokens(event.getString("date"), "-"));
    dates[i] = dateArray[2];
    startTimes[i] = event.getString("startTime");
    endTimes[i] = event.getString("endTime");
    podcasts[i] = event.getString("podcast");
    String locator = event.getString("location");
    
    if(locator.equals("Home") == true){
      
      locations[i] = 1;
    
    } else if(locator.equals("Local Driving") == true){
    
      locations[i] = 2;
    
    } else if(locator.equals("Gym") == true){
    
      locations[i] = 3;
    
    } else if(locator.equals("Highway Driving") == true){
    
      locations[i] = 4;    
    
    }
    
    int flag = 0;
    
    for (int j = 0; j < casts.length; j++) {
    
      println(casts[j]);
      println(podcasts[i]);
      println(counter);
      if (podcasts[i].equals(casts[j]) == true) {
      
        j = casts.length - 1;
        flag = 1;
      
      }
      
      if (podcasts[i].equals(casts[j]) == false && j == casts.length - 1 && flag != 1) {
      
        casts[counter] = podcasts[i];
        counter++;
        println(casts);
      
      }
      
      flag = 0;
      
    }
    
  }
  
  background(gray10);
  
  // Daylight hours
  
  noStroke();
  fill(gray05);
  rectMode(CORNERS);
  
  rect(map(sunStart, dayStart, dayEnd, canvasStartX, canvasEndX), canvasStartY, map(sunEnd, dayStart, dayEnd, canvasStartX, canvasEndX), canvasEndY);
  
  fill(255,255,255);
  rect(0, canvasEndY, width, height);
  
  // Y-axis gridlines
  
  for (int i = min(dates)-1; i <= max(dates)+1; i++) {
    
      float x1 = map(dayStart, dayStart, dayEnd, canvasStartX, canvasEndX);
      float x2 = map(sunStart, dayStart, dayEnd, canvasStartX, canvasEndX);
      float x3 = map(sunEnd, dayStart, dayEnd, canvasStartX, canvasEndX);
      float x4 = map(dayEnd, dayStart, dayEnd, canvasStartX, canvasEndX);
      float y =  map(i, min(dates)-1, max(dates)+1, canvasEndY, canvasStartY);
      int size = 4;
      
      stroke(gray15);
      strokeWeight(2);
      
      line(x1, y, x2, y);
      line(x3, y, x4, y);
      
      stroke(gray10);
      
      line(x2, y, x3, y);
    
  }
  
  // X-axis gridlines
  
  for (int i = dayStart; i <= dayEnd; i+= 60) {
    
    float x = map(i, dayStart, dayEnd, canvasStartX, canvasEndX);
    float y1 = canvasEndY;
    float y2 = canvasStartY;
    
    if ( i > sunStart && i < sunEnd) {
    
      stroke(gray10);
      
    } else {
      
      stroke(gray15);
      
    }
    
    strokeWeight(1);
    
    line(x, y1, x, y2);
    
  }
  
  // Lines
  
  for (int i = 0; i < listens.size(); i++) {
    
    int[] startTimeArray = int(splitTokens(startTimes[i], ":"));
    int[] endTimeArray = int(splitTokens(endTimes[i], ":"));
    
    int startTime = startTimeArray[0] * 60 + startTimeArray[1];
    int endTime = endTimeArray[0] * 60 + endTimeArray[1];
    
    float size = (endTime - startTime)/4;
    float x = map(startTime+2*size, dayStart, dayEnd, canvasStartX, canvasEndX);
    float y = map(dates[i], min(dates)-1, max(dates)+1, canvasStartY, canvasEndY);
    
    noStroke();
    fill(255,255,255);
    
    ellipse(x, y, 4, 4);
    
    float x0;
    float y0;
    
    if (locations[i] == 1) {
    
      x0 = dayStart;
      y0 = min(dates) - 1;
    
    } else if (locations[i] == 2) {
      
      x0 = dayEnd;
      y0 = min(dates) - 1;
      
    } else if (locations[i] == 3) {
      
      x0 = dayStart;
      y0 = max(dates) + 1;
      
    } else {
      
      x0 = dayEnd;
      y0 = max(dates) + 1;
      
    }
    
    x0 = map(x0, dayStart, dayEnd, canvasStartX, canvasEndX);
    y0 = map(y0, min(dates)-1, max(dates)+1, canvasStartY, canvasEndY);
    
    noFill();
    stroke(255,255,255);
    strokeWeight(1);
  
    line(x0, y0, x, y);
  
  }
  
  // Colored bubbles
  
  for (int i = 0; i < listens.size(); i++) {
    
    int[] startTimeArray = int(splitTokens(startTimes[i], ":"));
    int[] endTimeArray = int(splitTokens(endTimes[i], ":"));
    
    int startTime = startTimeArray[0] * 60 + startTimeArray[1];
    int endTime = endTimeArray[0] * 60 + endTimeArray[1];
    
    if(podcasts[i].equals("Adam Carolla Show") == true) {
    
      fill(carolla);
    
    }else if(podcasts[i].equals("Traction") == true) {
    
      fill(traction);
    
    }else if(podcasts[i].equals("Reply All") == true) {
    
      fill(replyall);
    
    }else if(podcasts[i].equals("Serial") == true) {
    
      fill(serial);
    
    }else if(podcasts[i].equals("Radiolab") == true) {
    
      fill(radiolab);
    
    }else if(podcasts[i].equals("Freakonomics") == true) {
    
      fill(freak);
    
    }else if(podcasts[i].equals("What's the Point") == true) {
    
      fill(wtp);
    
    }else if(podcasts[i].equals("99% Invisible") == true) {
    
      fill(nnpi);
    
    }else if(podcasts[i].equals("Planet Money") == true) {
    
      fill(money);
    
    }else if(podcasts[i].equals("The Allusionist") == true) {
    
      fill(allusionist);
    
    }else if(podcasts[i].equals("Tim Ferriss Show") == true) {
    
      fill(ferriss);
    
    }else if(podcasts[i].equals("Hot Takedown") == true) {
    
      fill(hottake);
    
    }
    
    float size = (endTime - startTime)/4;
    float x0 = map(startTime, dayStart, dayEnd, canvasStartX, canvasEndX);
    float x1 = map(startTime+2*size, dayStart, dayEnd, canvasStartX, canvasEndX);
    float y = map(dates[i], min(dates)-1, max(dates)+1, canvasStartY, canvasEndY);
    float x2 = map(startTime+4*size, dayStart, dayEnd, canvasStartX, canvasEndX);
    
    stroke(255,255,255);
    strokeWeight(3);
    
    ellipse(x1, y, x2-x0, x2-x0);
  
  }
  
  // Title and major labels
  
  textAlign(CENTER, TOP);
  
  textFont(titleFont);
  fill(gray60);
  //text("FiveThirtyEight x Dear Data: A Week of Podcasts", width/2, margin-10);
  
  textFont(subtitleFont);
  
  textAlign(LEFT, TOP);
  text("Working", canvasStartX + margin, canvasStartY + margin);
  
  textAlign(LEFT, BOTTOM);
  text("Working Out", canvasStartX + margin, canvasEndY - margin);
  
  textAlign(RIGHT, TOP);
  text("Local Driving", canvasEndX - margin, canvasStartY + margin);
  
  textAlign(RIGHT, BOTTOM);
  text("Highway Driving", canvasEndX - margin, canvasEndY - margin);
  
  // Y-axis labels
  
  for (int i = min(dates); i <= max(dates); i++) {
    
      float x = map(4*60, dayStart, dayEnd, canvasStartX, canvasEndX);
      float y =  map(i, min(dates)-1, max(dates)+1, canvasStartY, canvasEndY)-2;
      
      textAlign(LEFT, CENTER);
      
      textFont(bodyFont);
      fill(gray50);
      if ( i - min(dates) == 0 ) {
      
        text("Friday 3/" + i, x, y);
        
      } else if ( i - min(dates) == 1 ) {
      
        text("Saturday 3/" + i, x, y);
        
      } else if ( i - min(dates) == 2 ) {
        
        text("Sunday 3/" + i, x, y);
        
      } else if ( i - min(dates) == 3 ) {
        
        text("Monday 3/" + i, x, y);
        
      } else if ( i - min(dates) == 4 ) {
        
        text("Tuesday 3/" + i, x, y);
        
      } else if ( i - min(dates) == 5 ) {
        
        text("Wednesday 3/" + i, x, y);
        
      } else if ( i - min(dates) == 6 ) {
        
        text("Thursday 3/" + i, x, y);
        
      }
    
  }
  
  // X-axis labels
  
  for (int i = dayStart + 6*60; i <= dayEnd - 6*60; i+= 2*60) {
    
    float x = map(i, dayStart, dayEnd, canvasStartX, canvasEndX);
    float y = canvasEndY-margin;
    
    textAlign(CENTER, BOTTOM);
  
    textFont(bodyFont);
    fill(gray50);
    text(i/60 + ":00", x, y);
    
  }
  
  // Footer bar
  
  /*fill(gray60);
  rectMode(CORNERS);
  noStroke();
  rect(0, height, width, height-(16+padding*2));
  
  textFont(bodyFont);
  fill(gray15);
  textAlign(LEFT, BOTTOM);
  text("Benjamin D. Harvatine (@bdharva)", margin, height-padding);
  
  textAlign(RIGHT, BOTTOM);
  text("Data from March 11 to March 17, 2016", width-margin, height-padding);*/
  
  // Legend
  
  float x0 = map(0*60, dayStart, dayEnd, canvasStartX, canvasEndX)+7;
  float y0 = height - (30);
  float xStart = 0;
  float xEnd = 0;
  float yStart = 0;
  float yEnd = 0;
  float x9 = map(24*60, dayStart, dayEnd, canvasStartX, canvasEndX);
  
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
    
    }else if(casts[i].equals("The Allusionist") == true) {
    
      fill(allusionist);
    
    }else if(casts[i].equals("Tim Ferriss Show") == true) {
    
      fill(ferriss);
    
    }else if(casts[i].equals("Hot Takedown") == true) {
    
      fill(hottake);
    
    }
    
    rectMode(CORNER);
    noStroke();
    rect(x0+xStart, y0+yStart, nameWidth+2*padding, (nameHeight+2*padding));
    
    fill(255,255,255);
    textAlign(LEFT, TOP);
    text(casts[i], x0+xStart+padding, y0+yStart+padding);
    
    xStart = xStart + nameWidth + 3*padding;
  }
  
}
