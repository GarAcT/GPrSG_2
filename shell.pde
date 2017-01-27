class Shell{
  float x,y;
  float v;
  float theta;
  boolean hit;
  
  Shell(float startX,float startY,float lift){
    x=startX;
    y=startY;
    theta = lift;
    v = 10;
  }
  
  void update(){
    ellipse(x,y,2,2);
    x += v*cos(theta);
    y += -v*sin(theta);
    v /= 1.007;
  }
  
  boolean needRemove(){
    if(y<30 || y>height-50 || x>width || x<0) return true;
    if(hit) return true;
    
    return false;
  }
}