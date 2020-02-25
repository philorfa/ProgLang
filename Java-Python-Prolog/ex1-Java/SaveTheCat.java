/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.FileNotFoundException;

/**
 *
 * @author User
 */
public class SaveTheCat{

    /**
     * @param args the command line arguments
     * @throws java.io.FileNotFoundException
     */
    public static void main(String[] args) throws FileNotFoundException {
        sgrid input=new sgrid(args[0]);
        //input.whereiswater();
        //input.shoutw();
        //input.whereiscat();
        if(input.sources==0){
            System.out.println("infinity");
            System.out.println("stay");
        }
        else{
            sflood cat=new sflood();
            //dummy constructor
            cat.con=false;
            cat.sources=input.cats;
            cat.time=2;
            cat.xdim=input.xcat;
            cat.ydim=input.ycat;
            cat.rows=input.rows;
            cat.cols=input.cols;
            cat.grid=cat.expand(input.gridc,input.cats);
            //cat.shout();
            
            sflood water=new sflood();
            //dummy constructor
            water.con=false;
            water.sources=input.sources;
            water.time=2;
            water.xdim=input.xwater;
            water.ydim=input.ywater;
            water.rows=input.rows;
            water.cols=input.cols;
            water.grid=water.expand(input.gridw,input.sources);
           //water.shout();
            selem current=new selem();
            current.process(cat.grid,water.grid,input.rows,input.cols);
           // current.show();
           if(!current.save) System.out.println(current.time-2);
           symbols journey=new symbols(current.posx,current.posy,input.rows,input.cols);
           journey.find(cat.grid);
           journey.shout();
}
        
    }
    
}
