// most modification should occur in this file




class ForceDirectedLayout extends Frame {
  
  
  float RESTING_LENGTH = 10.0f;   // update this value
  float SPRING_SCALE   = 0.01f; // update this value
  float REPULSE_SCALE  = 400.0f;  // update this value

  float TIME_STEP      = 0.5f;    // probably don't need to update this

  // Storage for the graph
  ArrayList<GraphVertex> verts;
  ArrayList<GraphEdge> edges;
  // Storage for the node selected using the mouse (you 
  // will need to set this variable and use it) 
  GraphVertex selected = null;
  

  ForceDirectedLayout( ArrayList<GraphVertex> _verts, ArrayList<GraphEdge> _edges ) {
    verts = _verts;
    edges = _edges;
  }

  void applyRepulsiveForce( GraphVertex v0, GraphVertex v1 ) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A REPULSIVE FORCE
     PVector p0=v0.getPosition();
     PVector p1=v1.getPosition();
     float m0=v0.mass;
     float m1=v1.mass;
     float d= dist(p0.x,p0.y,p1.x,p1.y);
     float Rfrc= REPULSE_SCALE*m0*m1/d;
     float frcx0= Rfrc*(p0.x-p1.x)/sqrt(d);
     float frcy0= Rfrc*(p0.y-p1.y)/sqrt(d);
     //println(frcx0);
     v0.addForce(frcx0,frcy0);
      //Rfrcx= REPULSE_SCALE*m0*m1/(p1.x-p0.x);
      //Rfrcy= REPULSE_SCALE*m0*m1/(p1.y-p0.y);
     v1.addForce(-frcx0,-frcy0 );
     
     
  }

  void applySpringForce( GraphEdge edge ) {
    // TODO: PUT CODE IN HERE TO CALCULATE (AND APPLY) A SPRING FORCE
    
    PVector p0=edge.v0.getPosition();
    PVector p1=edge.v1.getPosition();
    float len= edge.getSpringLength();
    float d= sqrt(dist(p0.x,p0.y,p1.x,p1.y));
    
    float Sfrc=SPRING_SCALE*max(0,(d-RESTING_LENGTH));
    float Sfrcx0=Sfrc*(p1.x-p0.x)/d;
    float Sfrcy0=Sfrc*(p1.y-p0.y)/d;    //edge.v1.addForce( Sfrc,Sfrc);
    edge.v0.addForce( Sfrcx0,Sfrcy0 );
    
    
    //float Sfrcx1=SPRING_SCALE*((p1.x-p0.x)-RESTING_LENGTH);
    //float Sfrcy1=SPRING_SCALE*((p1.y-p0.y)-RESTING_LENGTH);
    //float Sfrcx1=SPRING_SCALE*max(0,(p1.x-p0.x)-RESTING_LENGTH);
    //float Sfrcy1=SPRING_SCALE*max(0,(p1.y-p0.y)-RESTING_LENGTH);
    
    //edge.v1.addForce( Sfrc,Sfrc);
    edge.v1.addForce( -Sfrcx0,-Sfrcy0 );
    //println("Sfrc");
  }

  void draw() {
    update(); // don't modify this line  
    for ( GraphEdge e : edges ) {
      GraphVertex n1= e.v0;
       //PVector p1=null,p2=null;
      
     PVector p1=n1.getPosition();
      GraphVertex n2= e.v1;
      
      PVector p2=n2.getPosition();
      stroke(0); 
      strokeWeight(2);
     // if(n1!=null && n2!=null ){
      line(p1.x,p1.y,p2.x,p2.y); 
    }
    for ( GraphVertex v : verts ) {
      if(selected!=null && selected.id==v.id){
        if(mouseX<0)
          mouseX=0;
        if(mouseY<0)
          mouseY=0;
      v.setPosition(mouseX%w,mouseY%h);
      fill(0);
    text(v.getID(),mouseX+v.diam/2,mouseY+v.diam/2);}
      //selected=null;
      PVector p=v.getPosition();
      //text(v.getID(),p.x,p.y);   

      stroke(255);
      strokeWeight(1);
      fill(0);
      for(int i=0;i<=10;i++){
        if(v.group==i)
        fill(palette[i]);
      }
     
      ellipse(p.x,p.y,v.getDiameter(),v.getDiameter()); 
    }
    // TODO: ADD CODE TO DRAW THE GRAPH
    
  }
  


  void mousePressed() { 
    for ( GraphVertex v : verts ) {
      
      PVector p=v.getPosition();
      
     // if(p.x+(v.getDiameter())<  mouseX && p.y+(v.getDiameter())<  mouseY && p.x-(v.getDiameter())>  mouseX && p.y-(v.getDiameter())>  mouseY)
      //if((p.x-mouseX)<10 && (p.x-mouseX)>-20 && (p.y-mouseY)<10 && (p.y-mouseY)<-20 )
      if(isHit(p.x,p.y))
        selected= v;
        
      //else selected=null;
    }
   
    // TODO: ADD SOME INTERACTION CODE

  }

  void mouseReleased() {  
    selected=null;
    //update();
    // TODO: ADD SOME INTERACTION CODE

  }
boolean isHit(float x, float y) {
  return sq(mouseX - x)/(20*20) + sq(mouseY - y)/(20*20) < 1;
  /* https://forum.processing.org/two/discussion/7916/how-to-limit-mousepressed-range-into-an-ellipse*/
}


  // The following function applies forces to all of the nodes. 
  // This code does not need to be edited to complete this 
  // project (and I recommend against modifying it).
  void update() {
    for ( GraphVertex v : verts ) {
      v.clearForce();
    }

    for ( GraphVertex v0 : verts ) {
      for ( GraphVertex v1 : verts ) {
        if ( v0 != v1 ) applyRepulsiveForce( v0, v1 );
      }
    }

    for ( GraphEdge e : edges ) {
      applySpringForce( e );
    }

    for ( GraphVertex v : verts ) {
      v.updatePosition( TIME_STEP );
      //println(v);
    }
  }
  
  float dist(float x0, float y0, float x1, float y1){
    return ( ((x0-x1)*(x0-x1))+((y0-y1)*(y0-y1))+ 0.0001f);
  }
}
