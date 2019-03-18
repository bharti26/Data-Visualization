

class Splom extends Frame {
  
    ArrayList<Scatterplot> plots = new ArrayList<Scatterplot>( );
    int colCount;
    Table data;
    float border = 20;
    
   Splom( Table data, ArrayList<Integer> useColumns ){
     this.data = data;
     colCount = useColumns.size();
     for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
           Scatterplot sp = new Scatterplot( table, useColumns.get(j), useColumns.get(i) );
           plots.add(sp);
       }
     }
       
     
     //table.getColumnCount()
     //table.getColumnType(int column) != Table.STRING
     //table.getColumnTitle();
     
   }
   
   void setPosition( int u0, int v0, int w, int h ){
     super.setPosition(u0,v0,w,h);

    int curPlot = 0;
    for( int j = 0; j < colCount-1; j++ ){
       for( int i = j+1; i < colCount; i++ ){
          Scatterplot sp = plots.get(curPlot++);
           int su0 = (int)map( i, 1, colCount, u0+border, u0+w-border );
           int sv0 = (int)map( j, 0, colCount-1, v0+border, v0+h-border );
           sp.setPosition( su0, sv0, (int)(w-2*border)/(colCount-1), (int)(h-2*border)/(colCount-1) );
           sp.drawLabels = false;
           sp.border = 3;
     }
    }
     
  }

   
   void draw() {
     for( Scatterplot s : plots ){
        s.draw(); 
     }
   }
   

  void mousePressed(){ 
    for( Scatterplot sp : plots ){
       if( sp.mouseInside() ){
          // do something!!!
          scatterFrame = new Scatterplot( table, sp.idx0,sp.idx1 );
          barFrame = new barplot( table, 0,sp.idx0 );
          lineFrame = new lineplot( table, 0,sp.idx0 );
          println(sp.idx0 + " " + sp.idx1);
          println(selectp);
       }
    }
  }
}