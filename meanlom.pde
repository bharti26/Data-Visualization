class meanlom extends Frame {
 
    ArrayList<meanplot> plots = new ArrayList<meanplot>( );
    int colCount;
    Table data;
    float border = 30;
    
   meanlom( Table data, ArrayList<Integer> useColumns ){
     this.data = data;
     colCount = useColumns.size();
     for( int i = 0; i < colCount; i++ ){
       for( int j = 0; j < colCount; j++ ){
           meanplot mean = new meanplot( table, useColumns.get(j), useColumns.get(i) );
           plots.add(mean);
       }
        println("meannnnnnnnnnnnnnnn");
     }
   }
   
   void setPosition( int u0, int v0, int w, int h ){
     super.setPosition(u0,v0,w,h);

    int curPlot = 0;
    for( int i = 0; i < colCount; i++ ){
       for( int j = 0; j < colCount; j++ ){
          meanplot mean = plots.get(curPlot++);
           int su0 = (int)map( i, 0, colCount, u0+border, u0+w-border );
           int sv0 = (int)map( j, 0, colCount, v0+border, v0+h-border );
           mean.setPosition( su0, sv0, (int)(w-2*border)/(colCount+1), (int)(h-2*border)/(colCount+1) );
           if (i==j)
           mean.drawLabels = true;
           else mean.drawLabels = false;
           mean.border = 0;
     }
    }
     
  }

   
   void draw() {
     for( meanplot mean : plots ){
        mean.draw(); 
     }
   }
   

 void mousePressed(){ 
    for( meanplot sp : plots ){
       if( sp.mouseInside() ){
          // do something!!!
          scatterFrame = new Scatterplot( table, sp.idx0,sp.idx1 );
          barFrame1 = new barplot( table, 0,sp.idx0 );
          barFrame2 = new barplot( table, 0,sp.idx1 );
          barFrame = new barchart( table, 0,sp.idx0 );
          //barFrame4 = new barplot( table, 0,sp.idx0 );
          lineFrame = new lineplot( table, 0,sp.idx0 );
          println(sp.idx0 + " " + sp.idx1);
          println(selectp);
       }
    }
  }
}