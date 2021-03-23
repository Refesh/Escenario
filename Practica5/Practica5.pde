float minSize = 0;

boolean leftMouseButton = false;

PShape chair;
PShape desk;
PShape bed;
PShape lamp;
PShape lamp2;

boolean frontMove = false;
boolean backMove = false;
boolean rightMove = false;
boolean leftMove = false;

float lightAngle = 0;

float clickX;
float clickY;

float posX = 0;
float posZ = 0;

float cameraAngle = -90;
float cameraAngleSave;

void setup()
{
  fullScreen(P3D);
  minSize = width/140;
  chair = loadShape("Models/chair/Armchair DAW_obj.obj");
  desk =  loadShape("Models/desk/desk.obj");
  bed = loadShape("Models/bed/Bed.obj");
  lamp = loadShape("Models/lamp/lamp.obj");
  lamp2 = loadShape("Models/lamp2/burri_living_room_210.obj");
  chair.scale(1.1);
  desk.scale(120);
  bed.scale(80);
  lamp.scale(60);
  lamp2.scale(0.8);
}

void draw(){
  
  background(255);
  
  
  noLights();
  ambientLight(100, 100, 60);
  if (leftMouseButton){
    cameraAngle = cameraAngleSave +  ((clickX - mouseX)/width) * 180;
  }
  
  if (frontMove) {
     posX += minSize/5 * sin(radians(cameraAngle + 90));
     posZ -= minSize/5 * cos(radians(cameraAngle + 90));
  }
  
  if (backMove) {
      posX -= minSize/5 * sin(radians(cameraAngle + 90));
      posZ += minSize/5 * cos(radians(cameraAngle + 90));
  }
  
  if (rightMove) {
      posX -= minSize/5 * sin(radians(cameraAngle));
      posZ += minSize/5 * cos(radians(cameraAngle));
  }
  
  if (leftMove) {
      posX -= minSize/5 * sin(radians(cameraAngle + 180));
      posZ += minSize/5 * cos(radians(cameraAngle + 180));
  }
  
  camera(width/2 + posX, height/2, minSize*40+ posZ, width/2 + posX + 10 *cos(radians(cameraAngle)), height/2, minSize*40+ posZ + 10 *sin(radians(cameraAngle)), 0, 1.0f, 0.0f);
  translate(width/2, height/2, 0);
  
  pushMatrix();
  translate(0, 0, minSize*30);
  
  lightAngle +=0.4f;
  directionalLight(255 , 255 , 255 , cos(radians(lightAngle)),sin(radians(lightAngle)) , 0) ;
  pushMatrix();
  translate(0,0,-minSize*25);
  rotateY(radians(180));
  box(minSize*30, minSize*20, 3);
  popMatrix();
  pushMatrix();
  translate(0, 0, minSize*25);
  box(minSize*30, minSize*20, 3);
  popMatrix();
  fill(100,100,100);
  
  //Techo y suelo
  pushMatrix();
  translate(0, minSize*10,0);
  box(minSize*30, 3, minSize*50);
  popMatrix();
  pushMatrix();
  translate(0, -minSize*10,0);
  box(minSize*30, 3, minSize*50);
  popMatrix();
  fill(50,50,50);
  
  pushMatrix();
  translate(-minSize*15,0,0);
  box(3, minSize*50, minSize*148);
  popMatrix();
  pushMatrix();
  translate(minSize*15, 0, 0);
  box(3, minSize*50, minSize*148);
  popMatrix();
  
  fill(192,192,192);
  
  rotateX(radians(180));
  translate(0, -10*minSize, minSize*19);
  shape(chair, 0, 0);
  pushMatrix();
  translate(-minSize*0.5,-minSize, minSize*3);
  rotateY(radians(90));
  shape(desk, 0, 0);
  popMatrix();
  pushMatrix();
  rotateY(radians(30));
  translate(-minSize*7, minSize*6.8f, 0);
  shape(lamp, 0, 0);
  popMatrix();
  
  pushMatrix();
  translate(-minSize*12, 0, minSize*3);
  rotateX(radians(-90));
  shape(lamp2, 0, 0);
  popMatrix();
  
  pushMatrix();
  translate(-minSize*12, 0, -minSize*40);
  rotateX(radians(-90));
  shape(lamp2, 0, 0);
  popMatrix();
  translate(minSize*11, 0, -minSize*4);
  rotateY(radians(180));
  shape(bed, 0, 0);
  popMatrix();
  
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  fill(255, 255, 255, 204);
  textSize(minSize*1.5);
  text("Press esc to exit", minSize*3, minSize*3);
  textSize(minSize*1.2);
  text("Click and drag to move camera angle", minSize*3, height-minSize*9);
  text("R to reset", minSize*3, height-minSize*6);
  text("Use w-a-s-d to move around", minSize*3, height-minSize*12);
  fill(192, 192, 192);
  hint(ENABLE_DEPTH_TEST);

}

void mousePressed(){
  if (mouseButton == LEFT) {
    clickX = mouseX;
    clickY = mouseY;
    cameraAngleSave = cameraAngle;
    leftMouseButton = true;
  }
}
void mouseReleased(){
  if (mouseButton == LEFT) leftMouseButton = false;
}
void keyPressed(){
  if (key == 'w' || key == 'W') frontMove = true;
  if (key == 's' || key == 'S') backMove = true;
  if (key == 'd' || key == 'D') rightMove  = true;
  if (key == 'a' || key == 'A') leftMove  = true;
  if (key == 'r' || key == 'R'){
    posX = 0;
    posZ = 0;
    cameraAngle = -90;
    lightAngle = 0;
  }
}

public void keyReleased(){
  if (key == 'w' || key == 'W') frontMove = false;
  if (key == 's' || key == 'S') backMove = false;
  if (key == 'd' || key == 'D') rightMove  = false;
  if (key == 'a' || key == 'A') leftMove  = false;
}
