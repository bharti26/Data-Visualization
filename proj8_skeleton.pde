import mdsj.*;

Frame myFrame = null;
JSONObject json,node1,edge1;
String[] properties;
JSONArray Vertices,Edges;
color[] palette = {#F1E6D4, #E2E1DC, #FF5733,  #790F33, #BA3D49,  #75FF33, #33FF57, #F00000,#33FFBD, #DBFF33,#9F9694};
int w, h;
int border= 100;
double [][]dM;
double[][] output;
float[][] outputf;

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
     GraphVertex n=new GraphVertex(s,gr,int(random(0+border,width-border)),int(random(0+border,height-border)),i);
     //idIndex.put(s,i);
     verts.add(n);
  } 
  dM= new double [Vertices.size()][Vertices.size()];
  outputf= new float [Vertices.size()][Vertices.size()];
  for(int i=0;i<Vertices.size();i++){
    for(int j=0;j<Vertices.size();j++){
      if(i==j)
      dM[i][j]=0;
      else
      dM[i][j]=99999;
    }
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
     //idIndex.put(s,i);
     if(n1!=null && n2!=null )
     edges.add(n);
     if(n1!=null && n2!=null){
       dM[n1.getNum()][n2.getNum()]=eg;
       dM[n2.getNum()][n1.getNum()]=eg;
     }
  } 
  
/*for(int i=0;i<Vertices.size();i++){
    for(int j=0;j<Vertices.size();j++){
      print(dM[i][j]);
    }
    println();
  }*/
  
 for(int i=0;i<Vertices.size();i++){
   dijkstra(i);
   //MDS();
 }
  output=MDSJ.classicalScaling(dM);
  for(int i=0; i<Vertices.size(); i++) {  // output all coordinates
        //println(output[0][i]+" "+output[1][i]);
        outputf[0][i]= (float)output[0][i];
        outputf[1][i]= (float)output[1][i];
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
  }//
}

void mousePressed() {
  myFrame.mousePressed();
}

void mouseReleased() {
  myFrame.mouseReleased();
}

void dijkstra(int i){
  double mini;
  int u=i;
  //double alt;
 double dist[]=new double[Vertices.size()];
 int prev[]=new int[Vertices.size()];
 //ArrayList<Integer> Q = new ArrayList<Integer>();
 int [] Q= new int [Vertices.size()];
 for(int j=0; j<Vertices.size(); j++) { 
   dist[j]=99999;
   prev[j]=0;
   Q[i]=0;
   
   //Q.add(j);
 }
 dist[i]=0;
 
 for(int k=0;k<Vertices.size()-1;k++){
   mini=999990;
   //find minimum distance node
   for(int p=0; p<Vertices.size();p++){
     if(Q[i]==0&& dist[p]<=mini){
       mini=dist[p];
       u=p;
     }
   }
   // Vertex u is processed 
   Q[u]=1;
   for(int p=0; p<Vertices.size();p++){
     if(Q[p]==0 && u!=p &&  dist[u]+dM[u][p]<dist[p])
       dist[p]=dist[u]+dM[u][p];
   }
   //for(int k=0;k<Q.size();k++){
     //if(dist[Q.get(k)]<=mini) {
       //mini=dist[Q.get(k)];
       //u=Q.get(k);
       //break;
     //}
     
   }
   for(int p=0; p<Vertices.size();p++){
    dM[i][p]=dist[p];
   }
   //Q.remove(u);
   /*for(int k=0;k<Vertices.size();k++){
     if(dM[u][k]<99999 && u!=k && Q.contains(k))
      alt=dist[u]+dM[u][k];
      //if(alt<dist[u]){*/
        
     // }
  // }
   //println(dist);
   
 //}
  
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
