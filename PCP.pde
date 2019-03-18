


class PCP extends Frame {
  
    ArrayList<PCPAxis> axes = new ArrayList<PCPAxis>( );
    Table data;
    int border = 20;
    
   PCP( Table data, ArrayList<Integer> useColumns ){
     this.data = data;
     for( int i = 0; i < useColumns.size(); i++ ){
       axes.add( new PCPAxis( data, useColumns.get(i) ) );
     }
   }

   void updatePositions(){
     for( int i = 0; i < axes.size(); i++ ){
       PCPAxis a =  axes.get(i);
       float u = map( i, 0, axes.size()-1, u0+border, u0+w-border );
       a.firstAxis = (i==0);
       a.lastAxis = (i==(axes.size()-1));
       
       if( a.selected ){
         u = constrain( mouseX, u0, u0+w);
         a.u0 = constrain( mouseX, u0, u0+w );
       }
       a.setPosition((int)u,v0+border,5,h-2*border); 
     }
     
     for( int i = 0; i < axes.size()-1; i++ ){
        if( axes.get(i).u0 > axes.get(i+1).u0 ){
          PCPAxis tmp = axes.get(i);
          axes.set(i,axes.get(i+1));
          axes.set(i+1,tmp);
        }
     }
   }
   
   
   void draw() {
     updatePositions();
     
     for( PCPAxis a : axes ){
       a.draw(); 
     }
     
     stroke(0);
     strokeWeight(1);
     for( int i = 0; i < data.getRowCount(); i++ ){
       
       float px = axes.get(0).u0;
       float py = axes.get(0).getValue( i );
       float distance=abs(py)-abs(mouseY);
       for( int j = 1; j < axes.size(); j++ ){
         float cx = axes.get(j).u0;
         float cy = axes.get(j).getValue( i );
         distance=abs(py)-abs(mouseY);
         if (distance<=1 && distance>=-1 && selectp!=i && mouseX>u0)
         {
           selectp=i;
           j=1;
           //println(distance);
           //fill(#FFCCBB);
         }
         
         //if((mouseX>=px-2)&& (mouseX<=cx+2) && (mouseY>=py-2)&& (mouseY<=cy+2)){
         //fill(#FFCCBB);
         //}
         if(i==selectp) stroke(#ff0000);
         else stroke(0);
         line( px,py,cx,cy);
         
         px = cx;
         py = cy;
       }
       //selectp=-1;
     }//selectp=-1;
   }
   

  void mousePressed(){ 
    for( PCPAxis a : axes ){
       if( a.mouseInside() ){
         a.selected = true;
         barFrame = new barplot( table, 0,a.attr );
        lineFrame = new lineplot( table, 0, a.attr);
        if(a.attr>0)
        scatterFrame = new Scatterplot( table, a.attr,a.attr-1 );
        else
        scatterFrame = new Scatterplot( table, a.attr,1 );
       }
    }
    // implement brushing
  }
  
  void mouseReleased(){ 
    for( PCPAxis a : axes ){
      a.selected = false;
    }
  }
  
}


class PCPAxis extends Frame {
  Table data;
  int attr;
  float minV, maxV;
  
  float futU=-1;

  boolean firstAxis = false;
  boolean lastAxis = false;
  boolean selected = false;
  boolean firstSet = true;
  
  PCPAxis( Table data, int attr ){
    this.data = data;
    this.attr = attr;
    
     minV = min(data.getFloatColumn(attr));
     maxV = max(data.getFloatColumn(attr));
  }
  
  void setPosition( int u0, int v0, int w, int h ){
    if( firstSet ) this.u0 = u0;
    this.futU = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
    firstSet = false;
  }
  
  float getValue( int idx ){
     return map( data.getFloat( idx, attr ), minV, maxV, v0+h, v0+10 ); 
  }

   void draw() {
     u0 = (int)lerp( u0, futU, 0.1f );
     
     stroke(0);
     if( selected ) stroke (255,0,0);
     strokeWeight(w);
     line( u0,v0+10,u0,v0+h);
     
     textSize(12);
     fill(0);
     textAlign( CENTER );
     if( firstAxis ) textAlign( LEFT);
     if( lastAxis ) textAlign(RIGHT);
     text( data.getColumnTitle( attr ), u0, v0 );
   }  
}