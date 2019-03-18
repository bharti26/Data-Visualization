

class dotFrame extends Frame {
  
  float t = 0;
   
    void draw(){
      
      stroke(0);
      noFill();
      rect(u0,v0,w,h);
      
      
      stroke( 0 );
      fill(255,0,0);
      ellipse( u0+t, v0+t, 20, 20 );
  
      t += 5;
      if( t > w ) t = 0;
    }
}