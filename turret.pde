class Turret{
  int x,y;
  int mode;
  int size;
  float lift;
  float muzzleX,muzzleY;
  float spread;
  boolean firing;
  boolean power;
  
  Turret(int slot){
    size = 20;
    if(slot==0){
      x = 50;
      y = height-(100+size);
    }else if(slot==1){
      x = 150;
      y = height-(50+size);
    }
    mode = 0;
    lift = 0;
    spread = 1.0;
    power = true;
  }
  
  void update(){
    if(power){
      lift = atan2((y-mouseY) , (mouseX-x));
      lift = min(lift,radians(85));
      lift = max(lift,radians(-10));
      if(mousePressed){
        lift += radians(random(-spread,spread));
      }
    }
    muzzleX = x + 60*cos(lift);
    muzzleY = y - 60*sin(lift);
    liftCannon(lift);
    rect(x,y,size,size);
    
    if(mousePressed){
      if(mouseButton==RIGHT){
        if(mouseX>x-size && mouseX<x+size && mouseY>y-size && mouseY<y+size){
          power = !power;
        }
      }
    }
  }
  
  private void liftCannon(float r){
    pushMatrix();
    translate(x,y);
    rotate(-r);
    rect(30,0,30,2);
    popMatrix();
  }
  
}