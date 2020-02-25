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
class symbols {
    int destinationx;
    int destinationy;
    int rows;
    int cols;
    int moves;
    public ArrayList<String> travel;
    
    public symbols(int x,int y, int r,int c)
    {
        destinationx=x;
        destinationy=y;
        rows=r;
        cols=c;
    }
    
    public void find(ArrayList<ArrayList<Integer>> cat)
    {
        travel=new ArrayList<>();
        int i=destinationx;
        int j=destinationy;
        while(cat.get(i).get(j)!=1)
        {//System.out.println("i= "+i+"j= "+j);
            if(i!=rows-1){
                if(cat.get(i+1).get(j)-cat.get(i).get(j)==-1){
                    travel.add("U");
                    i++;
                    moves++;
                    continue;
                }
                
            }
            if(j!=0)
            {
              if(cat.get(i).get(j-1)-cat.get(i).get(j)==-1){
                    travel.add("R");
                    j--;
                    moves++;
                    continue;
                }  
            }
            if(j!=cols-1)
            {
                if(cat.get(i).get(j+1)-cat.get(i).get(j)==-1){
                    travel.add("L");
                    j++;
                    moves++;
                    continue;
                }
            }
            
            if(i!=0)
            {
                if(cat.get(i-1).get(j)-cat.get(i).get(j)==-1){
                    travel.add("D");
                    i--;
                    moves++;
                }
            }
        }
        if (moves==0) System.out.println("stay");
    }
    
    
    public void shout(){
        //System.out.println(moves);
        for(int i=moves-1;i>=0;i--){
            System.out.print(travel.get(i));
        }
    }
    
}
