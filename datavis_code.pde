
Frame PCPFrame = null;
Frame barFrame = null;
Frame lineFrame = null;
Frame scatterFrame = null;
Frame splomFrame = null;
Table table;
int selectp=-1;

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
    barFrame = new barplot( table, 0,0 );
    lineFrame = new lineplot( table, 0,0 );
    splomFrame= new Splom( table, useColumns );
    
    
  }
}


void draw(){
  background( 255 );
  
  if( table == null ) 
    return;
  
   if( scatterFrame != null ){
       scatterFrame.setPosition( 0, 0, 400, 400 );
       scatterFrame.draw();
  }
  
  if( barFrame != null ){
       barFrame.setPosition( 400, 0, 400, 400 );
       barFrame.draw();
  }
  if( lineFrame != null ){
       lineFrame.setPosition( 800, 0, 400, 400 );
       lineFrame.draw();
  }
  if( splomFrame != null ){
       splomFrame.setPosition( 0, 400, 400, 400 );
       splomFrame.draw();
  }
   if( PCPFrame != null ){
       PCPFrame.setPosition( 400, 400, 800, 400 );
       PCPFrame.draw();
  }
  if(mouseY>800 || mouseX>width)
  selectp=0;
}

void mousePressed(){
  PCPFrame.mousePressed();
  splomFrame.mousePressed();
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