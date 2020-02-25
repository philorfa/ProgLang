public class Node {
      public int low,high;
     public String route;
     public Node(int low,int high,String route) {
         this.low=low;
         this.high=high;
         this.route=route;
     }
     
     public int first() {
         return this.low;
     }
    public int second() {
        return this.high;
    }
public static void main(String[] args) {
        
    ztalloc problem=new ztalloc();
   new readfile(problem,args[0]);
    }

    } 