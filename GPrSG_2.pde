boolean mouseStat,defeat;
Turret t0,t1;
ArrayList<Aircraft> enemyList = new ArrayList<Aircraft>();
ArrayList<Shell> shellList = new ArrayList<Shell>();
int landLine,menuLine;
int ammo,money;
int counter,wave,lp;
int HQ,overCount;

void setup(){
  size(800,600);
  background(0);
  stroke(255);
  fill(0);
  rectMode(RADIUS);
  textSize(12);
  t0 = new Turret(0);
  t1 = new Turret(1);
  landLine = height - 50;
  menuLine = 30;
  ammo = 2500;
  money = 1000;
  counter = 0;
  wave = 0;
  lp = 0;
  HQ = 100;
  defeat = false;
  overCount = 0;
}

void draw(){
  background(0);
  line(0,landLine,width,landLine);
  line(0,menuLine,width,menuLine);
  rect(50-1,landLine-25,50+1,25);
  rect(100,15,95,10);
  fill(255);
  text("ammo:"+ammo,5,height-5);
  text("¥"+money,5,height-15);
  text("HQ:"+max(0,HQ),5,height-35);
  text("+500ammo",10,20);
  text("¥500",160,20);
  textAlign(RIGHT);
  text("wave:"+wave,width-5,20);
  textAlign(LEFT);
  fill(0);
  
  for(int i=0;i<shellList.size();i++){
    Shell shell = shellList.get(i);
    shell.update();
    for(int j=0;j<enemyList.size();j++){
      Aircraft enemy = enemyList.get(j);
      if(shellCollision(shell.x,shell.y,enemy.x,enemy.y,enemy.size)){
        shell.hit = true;
        enemy.HP--;
      }
    }
    if(shell.needRemove()) shellList.remove(i);
  }
  
  for(int i=0;i<enemyList.size();i++){
    Aircraft enemy = enemyList.get(i);
    enemy.update();
    if(enemy.needRemove()){
      if(enemy.destroyed){
        money += enemy.money + wave;
      }else{
        HQ -= enemy.load*2 + 1;
      }
      enemyList.remove(i);
    }
  }
  
  if(HQ <= 0){
    defeat = true;
    fill(255);
    textSize(32);
    text("HQ was destroyeeeed!",width/2,height/2);
    textSize(12);
    text("We lost at this war.",width/2,height/2 + 15);
    text("Game will close in 10 seconds.",width/2,height/2 + 25);
    fill(0);
  }
  
  t0.update();
  t1.update();
  
  if(mouseStat){
    if(t0.power && ammo>0){
      Shell shell = new Shell(t0.muzzleX,t0.muzzleY,t0.lift);
      shellList.add(shell);
      ammo--;
    }
    if(t1.power && ammo>0){
      Shell shell = new Shell(t1.muzzleX,t1.muzzleY,t1.lift);
      shellList.add(shell);
      ammo--;
    }
  }
  
  if(counter >= 480){
    wave++;
    lp += wave;
    int array[] = new int[wave];
    for(int i=0;i<lp-wave;i++){
      array[(int)random(wave)]++;
    }
    for(int i=0;i<wave;i++){
      Aircraft enemy = new Aircraft(array[i]);
      enemyList.add(enemy);
    }
    counter = 0;
  }
  
  counter++;
  
  if(defeat){
    overCount++;
    if(overCount > 600){
      exit();
    }
  }
}

void mousePressed(){
  if(mouseButton==LEFT){
    if((mouseY < landLine) && (mouseY > menuLine)){
      mouseStat = true;
    }
    if(mouseX > 5 && mouseX < 195 && mouseY > 5 && mouseY < 25){
      if(money >= 500){
        ammo += 500;
        money -= 500;
      }
    }
  }
}

void mouseReleased(){
  mouseStat = false;
}

boolean shellCollision(float bX, float bY, float oX, float oY, float oSize) {
  if (bX < oX-oSize) return false;
  if (bX > oX+oSize) return false;
  if (bY < oY-oSize/3) return false;
  if (bY > oY+oSize/3) return false;
  return true;
}