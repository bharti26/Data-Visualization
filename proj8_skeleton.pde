

Frame myFrame = null;
JSONObject json,node1,edge1;
String[] properties;
JSONArray Vertices,Edges;
color[] palette = {#F1E6D4, #E2E1DC, #FF5733,  #790F33, #BA3D49,  #75FF33, #33FF57, #F00000,#33FFBD, #DBFF33,#9F9694};
int w, h;
int border= 100;

void setup() {
  size(800, 800);  
  w=width-border;
  h=height-border;
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectInput("Select a file to process:", "fileSelected");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());

    ArrayList<GraphVertex> verts = new ArrayList<GraphVertex>();
    ArrayList<GraphEdge>   edges = new ArrayList<GraphEdge>();
    json = loadJSONObject(selection);
    properties = (String[]) json.keys().toArray(new String[json.size()]);
    Vertices = json.getJSONArray(properties[0]);
    Edges = json.getJSONArray(properties[1]);
    
    for(int i=0;i<Vertices.size();i++){
     
     node1=Vertices.getJSONObject(i);
     String s=node1.getString("id");
     int gr=node1.getInt("group");
     GraphVertex n=new GraphVertex(s,gr,int(random(0,width)),int(random(0,height)));
     verts.add(n);
  } 
   GraphVertex n1=null,n2=null;
  for(int i=0;i<Edges.size();i++){
     
     edge1=Edges.getJSONObject(i);
     
     String sr=edge1.getString("source"); 
     
     for ( GraphVertex v1 : verts ) {
       if(match(v1.id,sr)!=null){
         //println(sr);
         n1=v1; } 
     }
     
     String tr=edge1.getString("target");
     for ( GraphVertex v2 : verts ) {
       if(match(v2.id,tr)!=null){
         //println(tr);
         n2=v2; }  
     }
     
     float eg=edge1.getFloat("value");
     GraphEdge n=new GraphEdge(n1,n2,eg);
     if(n1!=null && n2!=null )
     edges.add(n);
  } 

    // TODO: PUT CODE IN TO LOAD THE GRAPH    
   // println(edges);

    myFrame = new ForceDirectedLayout( verts, edges );
  }
}


void draw() {
  background( 255 );

  if ( myFrame != null ) {
    myFrame.setPosition( 0, 0, width, height );
    myFrame.draw();
  }
}

void mousePressed() {
  myFrame.mousePressed();
}

void mouseReleased() {
  myFrame.mouseReleased();
}

abstract class Frame {

  int u0, v0, w, h;
  int clickBuffer = 2;
  void setPosition( int u0, int v0, int w, int h ) {
    this.u0 = u0;
    this.v0 = v0;
    this.w = w;
    this.h = h;
  }

  abstract void draw();
  
  void mousePressed() { }
  void mouseReleased() { }

  boolean mouseInside() {
    return (u0-clickBuffer < mouseX) && (u0+w+clickBuffer)>mouseX && (v0-clickBuffer)< mouseY && (v0+h+clickBuffer)>mouseY;
  }
  
  
}
