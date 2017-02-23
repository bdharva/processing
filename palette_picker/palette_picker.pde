/*

MONOCHROMATIC COLOR PALETTE GENERATOR

This program:
* Accepts the following user inputs:
  * Color name
  * HEX color value
  * Position of input color in palette
  * Step size (percentage change in saturation and lumosity)
* Converts the color to RGB and HSL
* Calculates HSL values for a monochromatic color palette around the input
* Converts all HSL color values back to RGB and HEX
* Generates a swatch of the generated color palette including color codes
* Saves the swatch to an exports folder under sub-folders for year, month, and day

Author: Benjamin D. Harvatine
Started: Thursday, February 2, 2017
Completed: Friday, February 3, 2017
UI Added: Wednesday, February 22, 2017
Last Updated: Wednesday, February 22, 2017

*/

PFont buttonFont;
PFont bodyFont;
PFont titleFont;
PFont subtitleFont;

int margin = 40;
int padding = 20;
int cursor_offset = 1;
int cursor_width = 10;
int cursor_height = 20;
int input_steps = 9;

int field = 0;
String[] labels = {"Color Name", "HEX Value", "Postion", "Step Size"};
String[] helpers = {"Keep it simple", "Don't include the '#'", "Range of 1-9", "Range of 0-20%"};
String[] units = {"", "", "", "%"};
String[] values = {"SimpliSafe Blue", "008CC1", "5", "5"};

boolean form_flag = true;

void setup() {
  frameRate(60);
  size(400, 600);
  fill(0);
  buttonFont = createFont("DINNextLTPro-Medium", 18);
  bodyFont = createFont("DINNextLTPro-Regular", 16);
  titleFont = createFont("DINNextLTPro-Medium", 24);
  subtitleFont = createFont("DINNextLTPro-Regular", 16);
}
 
void draw() {
  
  if (form_flag) {
    
    background(240,240,240);
    
    for (int i=0; i < labels.length; i++) {
      
      float offset_field = field_offset(i);
      float offset_label = offset_field - 2.5*padding;
      
      textFont(bodyFont);
      
      textAlign(LEFT, CENTER);
      fill(100,100,100);
      text(labels[i], margin, offset_label);
      
      textAlign(RIGHT, CENTER);
      fill(200,200,200);
      text(helpers[i], width-margin, offset_label);
      
      rectMode(CORNERS);
      fill(255,255,255);
      noStroke();
      rect(margin,offset_field-1.5*padding,width-margin,offset_field+1.5*padding);
      
      if (i == field) {
        fill(0,200,50);
        rect(margin,offset_field+1.5*padding, width-margin, offset_field+1.5*padding-4);
        fill(100,100,100);
      } else {
        fill(200,200,200);
      }
      
      textAlign(LEFT, CENTER);
      text(values[i], margin+padding, offset_field);
      
      textAlign(RIGHT, CENTER);
      text(units[i], width-margin-padding, offset_field);
      
    }
    
    float sw = textWidth(values[field]);
    fill(200,200,200);
    rect(margin+padding+sw+cursor_offset, field_offset(field)-cursor_height/2, margin+padding+sw+cursor_offset+cursor_width, field_offset(field)+cursor_height/2);
    
    fill(0,200,50);
    rect(margin, height-margin, width-margin, height-margin-3*padding);
    
    textFont(buttonFont);
    textAlign(CENTER, CENTER);
    fill(255,255,255);
    text("PRESS ENTER KEY", width/2, height-margin-1.5*padding);
    
  }
  
}

float field_offset(int i) {
  return (margin+3.5*padding)*(i+1)-.5*padding;
}
 
void keyPressed() {
  if (form_flag) {
    if (keyCode == BACKSPACE) {
      if (values[field].length() > 0) {
        values[field] = values[field].substring(0, values[field].length()-1);
      }
    } else if (keyCode == DELETE) {
      values[field] = "";
    } else if (keyCode == ENTER) {
      form_flag = !form_flag;
      submit();
    } else if (keyCode == TAB || keyCode == DOWN) {
      field = field < (labels.length - 1) ? field + 1 : 0;
    } else if (keyCode == UP) {
      field = field > 0 ? field - 1 : labels.length - 1;
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
      values[field] = values[field] + key;
    }
  } else {
    form_flag = !form_flag;
  }
}

void submit(){
  
  int[] rgb = hex_to_rgb(unhex(values[1]) );
  float[] hsl = rgb_to_hsl(rgb[0], rgb[1], rgb[2]);
  float input_step = parseFloat(values[3])/100;
  float[][] hsls = hsl_tones(hsl[0], hsl[1], hsl[2], input_step, input_steps, parseInt(values[2])-1);
  int[][] rgbs = new int[3][input_steps];
  
  for (int j = 0; j < input_steps; j++) {
  
    int[] rgb_new = hsl_to_rgb(hsls[0][j], hsls[1][j], hsls[2][j]);
    
    rgb_new[0] = rgb_new[0] > 0 ? rgb_new[0] : 0;
    rgb_new[0] = rgb_new[0] < 256 ? rgb_new[0] : 256;
    
    rgb_new[1] = rgb_new[1] > 0 ? rgb_new[1] : 0;
    rgb_new[1] = rgb_new[1] < 256 ? rgb_new[1] : 256;
    
    rgb_new[2] = rgb_new[2] > 0 ? rgb_new[2] : 0;
    rgb_new[2] = rgb_new[2] < 256 ? rgb_new[2] : 256;
    
    rgbs[0][j] = rgb_new[0];
    rgbs[1][j] = rgb_new[1];
    rgbs[2][j] = rgb_new[2];
  
  }
  println("Rendering '" + values[0] + "'...");
  render(values[1], values[0], rgbs);
    
  println("Complete!");
  //exit();

}

void render(String input_color, String input_color_name, int[][] rgbs) {
  
  colorMode(RGB, 255, 255, 255, 1);
  rectMode(CORNERS);
  noStroke();
  
  fill(255,255,255);
  rect(0, 0, width, height);
  
  float margin = 10;
  float padding = 20;
  
  float step_size = (height - margin) / (input_steps + 2);
  float offset = step_size * 2 + margin;
  
  fill(rgbs[0][parseInt(values[2])-1], rgbs[1][parseInt(values[2])-1], rgbs[2][parseInt(values[2])-1]);
  rect(0, 0, width, offset - margin);
  
  for (int i=0; i < input_steps; i++) {  
  
    fill(rgbs[0][i], rgbs[1][i], rgbs[2][i]);
    rect(0, i * step_size + offset, width, (i + 1) * step_size + offset);
  
  }
  
  textFont(titleFont);
  fill(255,255,255);
  
  textAlign(LEFT, TOP);
  text(input_color_name, padding, 1.5*padding);
  
  textFont(subtitleFont);
  
  textAlign(LEFT, BOTTOM);
  text("#" + hex(rgbs[0][parseInt(values[2])-1], 2) + hex(rgbs[1][parseInt(values[2])-1],2) + hex(rgbs[2][parseInt(values[2])-1],2), padding, offset - margin - padding);
  
  textAlign(CENTER, BOTTOM);
  text("(" + rgbs[0][parseInt(values[2])-1] + "," + rgbs[1][parseInt(values[2])-1] + "," + rgbs[2][parseInt(values[2])-1] + ")", width/2, offset - margin - padding);
  
  textAlign(RIGHT, BOTTOM);
  text(100*parseInt(values[2]), width - margin - padding, offset - margin - padding);
  
  for (int i=0; i < input_steps; i++) {
  
    if (i < input_steps/2) {
    
      fill(0, 0, 0, 0.54);
    
    }
    else {
    
      fill(255, 255, 255);
      
    }
    
    textFont(subtitleFont);
    textAlign(LEFT, CENTER);
    text("#" + hex(rgbs[0][i], 2) + hex(rgbs[1][i], 2) + hex(rgbs[2][i], 2), padding, offset + step_size * (i + .5));
    textAlign(CENTER, CENTER);
    text("(" + rgbs[0][i] + "," + rgbs[1][i] + "," + rgbs[2][i] + ")", width/2, offset + step_size * (i + .5));
    textAlign(RIGHT, CENTER);
    text((i+1)*100, width - margin - padding, offset + step_size * (i + .5));
  
  }
  
  String[] color_name = split(input_color_name.toLowerCase(), " ");
  String file_name = "exports/" + year() + "/" + nf(month(),2) + "/" + nf(day(),2) + "/" + join(color_name, "_") + ".png";
  
  save(file_name);

}

float[] rgb_to_hsl(float r, float g, float b) {
  
  r /= 255;
  g /= 255;
  b /= 255;
  
  float min = min(r, g, b);
  float max = max(r, g, b);
  float h, s, l;
  
  l = (max + min) / 2;
  
  if(max == min) {
  
    h = s = 0;
  
  } else {
  
    float d = max - min;
    s = l > 0.5 ? d / (2 - max - min) : d / (max +min);
    if (max == r) { h = (g - b) / d + (g < b ? 6 : 0);}
    else if (max == g) { h = (b - r) / d + 2; }
    else { h = (r - g) / d + 4; }
    h /= 6;
  
  }
  
  float[] hsl = {h, s, l};
  
  return hsl;

}

int[] hsl_to_rgb (float h, float s, float l) {

  float r, g, b;
  
  if (s == 0) {
  
    r = g = b = l;
  
  } else {
  
    float q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    float p = 2 * l - q;
    r = hue_to_rgb(p, q, h + .333333);
    g = hue_to_rgb(p, q, h);
    b = hue_to_rgb(p, q, h - .333333);
  
  }
  
  int[] rgb = {round(r * 255), round(g * 255), round(b * 255)};
  
  return rgb;

}
    
float hue_to_rgb (float p, float q, float t) {
  
  if (t < 0) t += 1;
  if (t > 1) t -= 1;
  if (t < .166667) return p + (q - p) * 6 * t;
  if (t < .5) return q;
  if (t < .666666) return p + (q - p) * (.666666 - t) * 6;
  
  return p;

}

int[] hex_to_rgb(int hex_color) {
  
  String hex = hex(hex_color, 6);
  int red = unhex(hex.substring(0,2));
  int green = unhex(hex.substring(2,4));
  int blue = unhex(hex.substring(4,6));
  int[] rgb = {red, green, blue};
  
  return rgb;

}

float[][] hsl_tones(float h, float s, float l, float step, int steps, int center) {

  float[][] hsls = new float[3][steps];
  
  for (int i = 0; i < steps; i++) {
  
    hsls[0][i] = h;
    hsls[1][i] = i < center ? s * pow(1 + step, center-i) : s * pow(1 - step, i-center);
    hsls[2][i] = i < center ? l * pow(1 + step, center-i) : l * pow(1 - step, i-center);
  
  }
  
  return hsls;

}