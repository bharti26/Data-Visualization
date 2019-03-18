class Scatterplot extends Frame {
   
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 40;
  boolean drawLabels = true;
  float spacer = 5;
  
   Scatterplot( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));

     //table.getColumnTitle();  
     //table.getRowCount()
     //table.getRow()
     // row.getFloat();
   }
   
   void draw(){
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, u0+border+spacer, u0+w-border-spacer );
        float y = map( r.getFloat(idx1), minY, maxY, v0+h-border-spacer, v0+border+spacer );
         //println(y+3,y-3, mouseY);
        //if(mouseX>x-5 && mouseX<x+5 && mouseY>y+3 ){
       //println(y+3,y-3, mouseY);
        //selectp=i;}
        stroke( 0 );
        fill(255,0,0);
        if(i==selectp) {
          stroke(#00FF00);
          ellipse(x,y,10,10);
        }
         else {
           stroke(0);
        ellipse( x,y,3,3 );}
     }
     
     stroke(0);
     noFill();
     rect( u0+border,v0+border, w-2*border, h-2*border);
     
     if( drawLabels ){
       fill(0);
       text( table.getColumnTitle(idx0), u0+w/2, v0+h-10 );
       pushMatrix();
       translate( u0+10, v0+h/2 );
       rotate( 3*PI/2 );
       text( table.getColumnTitle(idx1), u0, v0+20);
       //text( table.getColumnTitle(idx0), u0+w/2, v0+h-10 );
       popMatrix();
       text( int(minY), u0+border, v0+h-border );
       text( int(maxY), u0+border, v0+border+10);
       text( int(minX), u0+border+20, v0+h-5-border/2,RIGHT);
       text( int(maxX), u0+w-border+5, v0+h-5-border/2);
     }
   }
  
}