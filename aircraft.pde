class Aircraft{
  int bomb;
  int HP;
  float x,y;
  float v;
  float pitch;
  float size;
  float money;
  boolean destroyed;
  
  Aircraft(int load){
    x=width + random(100);
    y=random(100,300);
    v=random(1.5,2.0);
    pitch = 0;
    size = 30 + random(-5,5);
    bomb = load;
    HP = (int)(size*2);
    money = HP+bomb*2;
  }
  
  void update(){
    rect(x,y,size,size/3);
    fill(255);
    text(bomb,x,y);
    fill(0);
    x -= v;
  }
  
  boolean needRemove(){
    if(x<-30) return true;
    if(HP<=0){
      destroyed = true;
      return true;
    }
    return false;
  }
}