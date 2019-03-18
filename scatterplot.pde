class Scatterplot extends Frame {
  float pccR=0; 
  float minX, maxX;
  float minY, maxY;
  float meanX=0,meanY=0,stdX=0,stdY=0;
  float meanRX=0,meanRY=0;
  int idx0, idx1;
  int border = 5;
  boolean drawLabels = true;
  float spacer = 0;
  float sumD2=0;
  float rho;
  float pcc=0;
  float[] RX = new float[table.getRowCount()]; 
  float[] RY = new float[table.getRowCount()]; 
  float[] D = new float[table.getRowCount()]; 
  Scatterplot( Table data, int idx0, int idx1 ){
     
     this.idx0 = idx0;
     this.idx1 = idx1;
     
     minX = min(data.getFloatColumn(idx0));
     maxX = max(data.getFloatColumn(idx0));
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        meanX=meanX+r.getFloat(idx0);
        meanY=meanY+r.getFloat(idx1);
     }
     meanX=meanX/table.getRowCount();
     meanY=meanY/table.getRowCount();
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        stdX=stdX+pow((r.getFloat(idx0)-meanX),2);
        stdY=stdY+pow((r.getFloat(idx1)-meanY),2);
     }
     stdX= sqrt(stdX)/table.getRowCount();
     stdY= sqrt(stdY)/table.getRowCount();
     float[] X = new float[table.getRowCount()];    
     X=sort(data.getFloatColumn(idx0));
     float[] Y = new float[table.getRowCount()];    
     Y=sort(data.getFloatColumn(idx1));
     
     float pccd1=0,pccd2=0;
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        float x1=r.getFloat(idx0);
        float x2=r.getFloat(idx1);
        pcc= pcc+(r.getFloat(idx0)-meanX)*(r.getFloat(idx1)-meanY);
        pccd1=pccd1+(r.getFloat(idx0)-meanX)*(r.getFloat(idx0)-meanX);
        pccd2=pccd2+(r.getFloat(idx1)-meanY)*(r.getFloat(idx1)-meanY);
        int j;
        // Calculate Rnaks.....................
        
        for ( j=0; j< table.getRowCount(); j++ ){
          if(X[j]==x1) break;
        }
        RX[i]=j;
        for ( j=0; j< table.getRowCount(); j++ ){
          if(Y[j]==x2) break;
        }
        RY[i]=j;
        meanRX=meanRX+RX[i];
        meanRY=meanRY+RY[i];
        
         //Calculate Diatance...................
       D[i]=RX[i]-RY[j]; 
       
       
       sumD2=sumD2+D[i]*D[i];
     
     }
     pccd1=sqrt(pccd1);
     pccd2=sqrt(pccd2);
     pcc=pcc/(pccd1*pccd2);
     int n=table.getRowCount();
     meanRX=meanRX/n;
     meanRY=meanRY/n;
     
     float pccd1R=0,pccd2R=0;
     for( int i = 0; i < table.getRowCount(); i++ ){
        
        pccR= pccR+(RX[i]-meanRX)*(RY[i]-meanRY);
        pccd1R=pccd1R+(RX[i]-meanRX)*(RX[i]-meanRX);
        pccd2R=pccd2R+(RY[i]-meanRY)*(RY[i]-meanRY);
     }
     pccd1R=sqrt(pccd1R);
     pccd2R=sqrt(pccd2R);
     pccR=pccR/(pccd1R*pccd2R);
    sumD2= 6*sumD2;
     rho= 1-(sumD2/((n*n*n)-n));
     
     println(rho);
     
     
     minY = min(data.getFloatColumn(idx1));
     maxY = max(data.getFloatColumn(idx1));

     //table.getColumnTitle();  
     //table.getRowCount()
     //table.getRow()
     // row.getFloat();
   }
   
   void draw(){
    
    /* color B = color(0, 0, 255);  // Blue color
     color G = color(0, 255, 0);  // Green color
     color R = color(255, 0, 0);  // Red color
     color Y = color(255, 255, 0);  // Yellow color*/
     
     int R=0, G=0, B=0;
     color c=color(R,G,B);
     stroke(0);
     if(idx0==idx1){
       fill(255,255,255);
       rect( u0+border,v0+border, w-2*border, h-2*border);
     }
     if(idx0!=idx1){
     if(pcc<=-0.5)
     R=255;
     if(pcc>0.5)
     fill(Y);
     G=255;
     if(pcc>-0.5 && pcc<=0)
     B=255;
     //fill(G);
     if(pcc>0 && pcc<=0.5)
     R=128;
     c= color(R*(1-pcc),G*(pcc),B*(pcc-pccR));
     fill(c);
     
     
     println(pcc);
     rect( u0+border,v0+border, w-2*border, h-2*border);
     //background( 4,255,248 );
     
     for( int i = 0; i < table.getRowCount(); i++ ){
        TableRow r = table.getRow(i);
        
        float x = map( r.getFloat(idx0), minX, maxX, u0+border, u0+w-border );
        float y = map( r.getFloat(idx1), minY, maxY, v0+h-border, v0+border );
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
           if(RX[i]>meanRX && RY[i]>meanRY)
           stroke(#FF0000);
           else
           stroke(0);
        ellipse( x,y,1,1 );}
     }}
    
     
     
     if( drawLabels ){
       fill(0);
      // text( table.getColumnTitle(idx0), u0, v0+h );
       //pushMatrix();
       //translate( u0+10, v0+h/2 );
       //rotate( 3*PI/2 );
       text( table.getColumnTitle(idx0), u0+w, v0+15,LEFT);
       String pccs = nf(meanX, 0, 2);
       String pccRs = nf(stdX, 0, 2);
       text( "\u03BC="+pccs, u0+w, v0+25,LEFT);
       text( "STD="+pccRs, u0+w, v0+40,LEFT);
       //text( meanX, u0+w, v0+25,LEFT);
       //text( stdX, u0+w, v0+35,LEFT);
       
       //text( table.getColumnTitle(idx0), u0+w/2, v0+h-10 );
       //popMatrix();
       //text( int(minY), u0+border, v0+h-border );
       //text( int(maxY), u0+border, v0+border+10);
      // text( int(minX), u0+border+20, v0+h-5-border/2,RIGHT);
       //text( int(maxX), u0+w-border+5, v0+h-5-border/2);
     }
   }
  
}