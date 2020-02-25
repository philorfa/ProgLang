import java.io.*;
import java.util.*;

public class readfile {
    private Scanner x;
    
    public readfile(ztalloc problem,String filename) {
        
        try {
            x=new Scanner(new File(filename));
        }
        catch(Exception E) {
            System.out.println("no file");
        }
        int t=x.nextInt();
        while(t>0) {
            int lin=x.nextInt();
            int rin=x.nextInt();
            int lout=x.nextInt();
            int rout=x.nextInt();
            problem.solve(lin,rin,lout,rout);
            t--;
        }
        x.close();
    }
public static void main(String[] args){

}

}