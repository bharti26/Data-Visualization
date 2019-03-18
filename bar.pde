class barplot extends Frame {
  float[][] mat = new float[3][int(bin)]; 
  int selectpp=-1;
  float minX, maxX;
  float minY, maxY;
  int idx0, idx1;
  int border = 30;
  boolean drawLabels = true;
  float spacer = 5;
   float max=0;
   float mean=0;
  int wid=(w-2*border)/int(bin);
  
   barplot( Table data, int idx0, int idx1 ){
     
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
    
     float binSize= (maxY-minY)/bin;
     for(int b=0;b<bin;b++){
       float freq=0; 
       mat[0][b]=minY+binSize*(b);
       mat[1][b]=minY+binSize*(b+1);
       for( int i = 0; i < table.getRowCount(); i++ ){
          TableRow r = table.getRow(i);
        
          //float x = map( float(b), 0, bin, u0+border+spacer, u0+w-border-spacer );
          //float y = map( r.getFloat(idx1), minY, maxY, v0+border,v0+h-border );
          if (r.getFloat(idx1)>=minY+binSize*b && r.getFloat(idx1)<minY+binSize*(b+1)){
            freq=freq+1;
          }
        
     }
     if (max<freq)
       max=freq;
     mat[2][b]=freq;
     mean=mean+mat[2][b];
     }
     mean=mean/bin;
     for(int b=0;b<bin;b++){     
       //println(freq);
        float x = map( float(b), 0, bin, u0+border+spacer, u0+w-border-spacer );
        float y = map( mat[2][b], 0, max, v0+border,v0+h-border );
        stroke( 0 );
        float std=y-mean;
        if(std<1) std=std*-1;
        fill(0+std/2,0+std/2,0+std/2);
        if(mouseX>x-3 && mouseX<x+3 && mouseY>v0+border && mouseY<v0+h-border )
        {//selectpp=b;
        stroke(#000000);
        fill(#FF0000);
        text(mat[0][b]+","+mat[1][b] ,x,v0+h-y,CENTER);
        
      }
        else stroke(0);
        rect(x-wid,v0+h-y,3*wid,y-border);
     }
     
     stroke(0);
     noFill();
     rect( u0+border,v0+border, w-2*border, h-2*border);
     
     if( drawLabels ){
       fill(0);
       text( table.getColumnTitle(idx1), u0+w/2+border/2,v0+border,CENTER);
       text( int(0), u0+border, v0+h-border );
       text( int(max), u0+border, v0+border+10);
       text( "0", u0+border+5, v0+h-5-border/2);
       text( int(bin), u0+w-border+5, v0+h-5-border/2);

       //popMatrix();
     }
   }
  
}