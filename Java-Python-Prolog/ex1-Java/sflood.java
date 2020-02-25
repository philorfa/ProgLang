/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.util.ArrayList;

/**
 *
 * @author User
 */
class sflood {
    public ArrayList<ArrayList<Integer>> grid;
    public boolean con;
    public int sources;
    public int time;
    public ArrayList<Integer> xdim;
    public ArrayList<Integer> ydim;
    public int cols;
    public int rows;
    
    public sflood()
    {
    
    }
    
    public ArrayList<ArrayList<Integer>> expand(ArrayList<ArrayList<Integer>> inp,int lastadded){
        int sou = 0;
        if(con) return inp;
        else{
            for(int i=sources-1;i>=sources-lastadded;i--){
                
                //up
                if (xdim.get(i)!=0){
                    //System.out.println("tsekarw gia panw");
                    if(inp.get((xdim.get(i)-1)).get( ydim.get(i)) == 0){
                        //System.out.println("paw panw");
                        inp.get((xdim.get(i)-1)).set(ydim.get(i),time);
                        sou++;
                        xdim.add(xdim.get(i)-1);
                        ydim.add(ydim.get(i));  
                    }
                }
                //left
                if (ydim.get(i)!=0){
                    //System.out.println("tsekarw gia aristera");
                    if(inp.get(xdim.get(i)).get(ydim.get(i)-1) == 0){
                        //System.out.println("paw aristera");
                        inp.get(xdim.get(i)).set((ydim.get(i)-1),time);
                        sou++;
                        xdim.add(xdim.get(i));
                        ydim.add(ydim.get(i)-1);  
                    }
                }
                 //down
                 if (xdim.get(i)!=rows-1){
                     //System.out.println("tsekarw gia katw");
                    if(inp.get((xdim.get(i)+1)).get(ydim.get(i)) == 0){
                        //System.out.println("paw katw");
                        inp.get((xdim.get(i)+1)).set(ydim.get(i),time);
                        sou++;
                        xdim.add(xdim.get(i)+1);
                        ydim.add(ydim.get(i));  
                    }
                 }
                //right
                if (ydim.get(i)!=cols-1){
                    //System.out.println("tsekarw gia deksia");
                    if(inp.get(xdim.get(i)).get((ydim.get(i)+1)) == 0){
                       // System.out.println("paw deksia");
                        inp.get(xdim.get(i)).set((ydim.get(i)+1),time);
                        sou++;
                        xdim.add(xdim.get(i));
                        ydim.add(ydim.get(i)+1);  
                    }
                        
                }
            }
            if(sou == 0) con=true;
            sources = (sources + sou);
            time++;
            return expand(inp,sou);
   
    }
    }
    
    public void shout(){
        for (long i=0;i<rows;i++)
        {
            for(long j=0;j<cols;j++)
            {
               System.out.print(grid.get((int) i).get((int) j));
               if(j==cols-1){
                   System.out.println("\n");
                            }
            }       
        
        }   
                       }
}
  
