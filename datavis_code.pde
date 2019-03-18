
Frame PCPFrame = null;
Frame barFrame1 = null;
Frame barFrame2 = null;
Frame barFrame3 = null;
Frame barFrame4 = null;
Frame lineFrame = null;
Frame barFrame = null;
Frame scatterFrame = null;
Frame meanplotFrame = null;
Frame splomFrame = null;
Frame meanFrame = null;
Table table;
int selectp=-1;
float bin= 20;

void setup(){
  size(1200,800);  
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } else {
    println("User selected " + selection.getAbsolutePath());
    table = loadTable( selection.getAbsolutePath(), "header" );
    
    ArrayList<Integer> useColumns = new ArrayList<Integer>();
    for(int i = 0; i < table.getColumnCount(); i++){
      if( !Float.isNaN( table.getRow( 0 ).getFloat(i) ) ){
        println( i + " - type float" );
        useColumns.add(i);
      }
      else{
        println( i + " - type string" );
      }
    }
    PCPFrame = new PCP( table, useColumns );
    scatterFrame = new Scatterplot( table, 0,1 );
     scatterFrame = new Scatterplot( table, 0,1 );
    barFrame = new barchart( table, 0,0 );
    lineFrame = new lineplot( table, 0,0 );
    barFrame1 = new barplot( table, 0,0 );
    barFrame2 = new barplot( table, 0,1 );
    barFrame3 = new barplot( table, 0,2 );
    barFrame4 = new barplot( table, 0,3 );
    
    lineFrame = new lineplot( table, 0,0 );
    splomFrame= new Splom( table, useColumns );
    meanplotFrame= new meanplot(table,0,1);
    meanFrame= new meanlom( table, useColumns );
    
    
  }
}


void draw(){
  background( 255 );
  
  if( table == null ) 
    return;
  
  if( barFrame1 != null ){
       barFrame1.setPosition( 0, 0, 300, 400 );
       barFrame1.draw();
  }
  if( barFrame2 != null ){
       barFrame2.setPosition( 300, 0, 300, 400 );
       barFrame2.draw();
  }
  if( lineFrame != null ){
       lineFrame.setPosition( 600, 0, 300, 400 );
       lineFrame.draw();
  }
   if( barFrame != null ){
       barFrame.setPosition( 900, 0, 300, 400 );
       barFrame.draw();
   }
  
  if( splomFrame != null ){
       splomFrame.setPosition( 0, 400, 400, 400 );
       splomFrame.draw();
  }
  if( meanFrame != null ){
       meanFrame.setPosition( 400, 400, 400, 400 );
       meanFrame.draw();
  }
   if( PCPFrame != null ){
       PCPFrame.setPosition( 800, 400, 400, 400 );
       PCPFrame.draw();
  }
  if(mouseY>800 || mouseX>width)
  selectp=0;
}

void mousePressed(){
  PCPFrame.mousePressed();
  splomFrame.mousePressed();
  meanFrame.mousePressed();
}

void mouseReleased(){
  PCPFrame.mouseReleased();
}

abstract class Frame {
  
  int u0,v0,w,h;
     int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ){
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }
  
  abstract void draw();
  void mousePressed(){ }
  void mouseReleased(){ }
  
   boolean mouseInside(){
      return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY; 
   }
  
  
}