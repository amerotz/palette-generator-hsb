color start;
color red = color(255, 0, 0);
color white = color(255);
int k = 5;
boolean edit = false;

float H = 0;
float S = 0;
float B = 0;

float hc = 1;
float sc = 1;
float bc = 1;

final float step = 0.1;
final float step2 = 1;

void setup(){
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
  start = color(H, S, B);
}

void keyPressed(){
  if(key == 'e') edit = !edit;
  else if(edit){
    if(key == '7') H -= step2;
    else if(key == '8') H += step2;
    if(key == '4') S -= step2;
    else if(key == '5') S += step2;
    if(key == '1') B -= step2;
    else if(key == '2') B += step2;
    H = constrain(H, 0, 360);
    S = constrain(S, 0, 100);
    B = constrain(B, 0, 100);
    start = color(H, S, B);
  } else {
    if(key == '7') hc -= step;
    else if(key == '8') hc += step;
    if(key == '4') sc -= step;
    else if(key == '5') sc += step;
    if(key == '1') bc -= step;
    else if(key == '2') bc += step;
    hc = constrain(hc, 0, 1);
    sc = constrain(sc, 0, 1);
    bc = constrain(bc, 0, 1);
  }
  key = '\\';
}

void draw(){
  for(int i = 0; i < k; i++){
    float hoff = H > 180 ? -H : 360-H;
    float soff = S > 50 ? -S : 100-S;
    float boff = B > 50 ? -B : 100-B;
    color nc = color(H + hc*hoff*i/k, S + sc*soff*i/k, B + bc*boff*i/k);
    stroke(i == 0 ? red : white);
    strokeWeight(2);
    fill(nc);
    rect(i*width/k, 0, (i+1)*width/k, height);
    textSize(12);
    fill(white);
    String str = i == 0 && edit ? "EDITING" : "";
    text( "H: " + (int)hue(nc) + "\n" + 
          "S: " + (int)saturation(nc) + "\n" + 
          "B: " + (int)brightness(nc) + "\n" + str, i*width/k + 10, 22);
  }
  text("Shift:\nH: " + format(hc, 1) + "\nS: " + format(sc, 1) + "\nB: " + format(bc, 1), 10, height - 80);
}

float format(float x, int amt){
  for(int i = 0; i < amt; i++) x *= 10.0;
  float n = (int)x;
  for(int i = 0; i < amt; i++) n /= 10.0;
  return n;
}
