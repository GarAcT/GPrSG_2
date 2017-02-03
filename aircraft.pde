class Aircraft{
  int load;
  int HP;
  float x,y;
  float v;
  float size;
  float money;
  boolean destroyed;
  
  Aircraft(int bomb){
    x=width + random(100);
    y=random(100,300);
    v=random(1.5,2.0);
    size = 30 + random(-5,5);
    load = bomb;
    HP = (int)(size*2);
    money = HP+load*2;
  }
  
  void update(){
    rect(x,y,size,size/3);
    fill(255);
    text(load,x,y);
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