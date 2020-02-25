/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author User
 */
class sgrid {
    
    public  int cols; // columns of grid
    public  int rows; // rows of grid
    public ArrayList<ArrayList<String>> a; // input grid
    public ArrayList<ArrayList<Integer>> gridc; //grid of cat
    public ArrayList<ArrayList<Integer>> gridw; // grid of watersources
    public int sources; // watersources in grid
    public int cats;    // cats in grid
    public ArrayList<Integer> xwater;//x-dimension of water
    public ArrayList<Integer> ywater;//y-dimension of water
    public ArrayList<Integer> xcat;//x-dimension of cat
    public ArrayList<Integer> ycat;//y-dimension of cat
    
    public sgrid(String file) throws FileNotFoundException{
        // read in the data
        gridc = new ArrayList<>();
        gridw = new ArrayList<>();
        a = new ArrayList<>();
        xwater = new ArrayList<>();
        ywater = new ArrayList<>();
        xcat = new ArrayList<>();
        ycat = new ArrayList<>();
        Scanner input;
        input = new Scanner(new File(file));
        while(input.hasNextLine())
            {
                    Scanner colReader = new Scanner(input.nextLine());
                    ArrayList<String> col = new ArrayList<>();
                    ArrayList<Integer> colc = new ArrayList<>();
                    ArrayList<Integer> colw = new ArrayList<>();
                    cols=0;
                    colReader.useDelimiter("");
                    while(colReader.hasNext())
                        {
        
                            col.add(colReader.next());
                            if (col.get(cols).equals("A")) {
                                colc.add(1);
                                colw.add(0);
                                xcat.add(rows);
                                ycat.add(cols);
                                cats++;
                                                            } 
                            else if(col.get( cols).equals("W")){
                                colc.add(0);
                                colw.add(1);
                                xwater.add(rows);
                                ywater.add(cols);
                                sources++;
                                                             }
                            else if(col.get( cols).equals("X")){
                                colc.add(-1);
                                colw.add(-1);
                                                              }
                            else{
                                colc.add(0);
                                colw.add(0);
                                 }
                        cols++;
                            }
                    gridc.add(colc);
                    gridw.add(colw);
                    a.add(col);
                    rows++;
            }
    }
    
    
    public sgrid(){
            /*Default Constructor*/    
            }
    
    
    public void dimension(){
    System.out.println("Colums= "+cols+" Rows= "+rows);
}
    
    
    public void shouta(){
        for (int i=0;i<rows;i++)
        {
            for(int j=0;j<cols;j++)
            {
               System.out.print(a.get(i).get(j));
               if(j==cols-1){
                   System.out.println("\n");
                            }
            }       
        
        }   
                       }
    
    
    public void shoutc(){
        for (int i=0;i<rows;i++)
        {
            for(int j=0;j<cols;j++)
            {
               System.out.print(gridc.get(i).get(j));
               if(j==cols-1){
                   System.out.println("\n");
                            }
            }       
        
        }   
                       }
    
    
    public void shoutw(){
        
        for (int i=0;i<rows;i++)
        {
            
            for(int j=0;j<cols;j++)
            {
               System.out.print(gridw.get(i).get(j));
               if(j==cols-1){
                   System.out.println("\n");
                            }
            }       
        
        }   
                       }
    
    public void whereiscat(){
        for(int i=0;i<cats;i++){
            System.out.println("["+xcat.get(i)+","+ycat.get(i)+"]");
        }
    }
    
    public void whereiswater(){
        for(int i=0;i<sources;i++){
            System.out.println("["+xwater.get(i)+","+ywater.get(i)+"]");
        }
    }
      
}
