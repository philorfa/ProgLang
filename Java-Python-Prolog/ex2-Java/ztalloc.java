import java.util.*;

public class ztalloc {
    
    
    public  void solve(int lin,int rin,int lout,int rout) {
        boolean found=false;
        
        //int counter=0;
        int outdif=rout-lout;
        Pair input=new Pair(lin,rin);
        Node inp=new Node(lin,rin,"");
        if(lin>=lout && rin<=rout) {
            System.out.println("EMPTY");
            return;
        }
        //Pair output=new Pair(lout,rout);
        Set<Pair> visited=new HashSet<Pair>();
        Queue<Node> to_visit=new LinkedList<Node>();
        visited.add(input);
        to_visit.add(inp);
        while(!to_visit.isEmpty()) {
          //  counter++;
            Node current=to_visit.poll();
            int lcurrent=current.first();
            int rcurrent=current.second();
            
            Pair hcurrent=new Pair(lcurrent/2,rcurrent/2);
            Pair tcurrent=new Pair(lcurrent*3+1,rcurrent*3+1);
            Node hcur=new Node(lcurrent/2,rcurrent/2,current.route+'h');
            Node tcur=new Node(lcurrent*3+1,rcurrent*3+1,current.route+'t');
            int curdif=rcurrent-lcurrent;
            if(lcurrent/2>=lout && rcurrent/2<=rout) {
                found=true;
                System.out.println(hcur.route);
                return;
            }
            
            if(!visited.contains(hcurrent)) {
                visited.add(hcurrent);
                to_visit.add(hcur);
            }
            
            if(lcurrent*3+1>=lout && rcurrent*3+1<=rout) {
                found=true;
                System.out.println(tcur.route);
                return;
            }
            if(curdif>outdif && lcurrent<lout ) {
                continue;
            }
            
           /* if(curdif>0 && lcurrent >0 && lout/lcurrent>outdif/curdif) {
            	continue;
            }
            */
            if(!visited.contains(tcurrent) && rcurrent*3+1<1000000) {
                visited.add(tcurrent);
                to_visit.add(tcur);
            }
        }
        if(!found) System.out.println("IMPOSSIBLE" );
        return;

    }
    public static void main(String[] args) {
        
    
    }
}