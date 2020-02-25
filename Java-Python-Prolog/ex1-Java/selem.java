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
class selem {
 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

    public int time=0;
    public int posx=0;
    public int posy=0;
    public boolean save=false;
    
    public void process(ArrayList<ArrayList<Integer>> cat, ArrayList<ArrayList<Integer>> water,int row,int col){
        for(int i=0;i<row;i++){
            for(int j=0;j<col;j++){
                if(water.get(i).get(j)==0 && cat.get(i).get(j)>0){
                    this.save=true;
                    this.posx=i;
                    this.posy=j;
                    System.out.println("infinity");
                    break;
                    }
                else if(water.get(i).get(j)>cat.get(i).get(j) && water.get(i).get(j)>time){
                    this.posx=i;
                    this.posy=j;
                    time=water.get(i).get(j);
                    
                }
            }
            if(save) break;
        }
        
    }
    
    
    public void show(){
        System.out.println("posx= "+posx+"posy= "+posy+"time= "+time);
    }
    
}
