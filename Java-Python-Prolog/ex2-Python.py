import queue
import sys
def process(f):
    first_line = f.readline()
    for line in f:
        data = line.split()
        start1=(int(data[0]))
        end1=(int(data[1]))
        start2=(int(data[2]))
        end2=(int(data[3]))
        solve(start1,start2,end1,end2)
def solve(lin,lout,rin,rout):
     visited=set()
     visited.add((lin,rin))
     routes={
         (lin,rin):""
     }
     to_visit=queue.Queue()
     found=False
     counter=0
     to_visit.put((lin,rin))
     if(lin>=lout and rin<=rout):
         print("EMPTY")
         return
     while(not to_visit.empty()):
         counter=counter+1
         (lcurrent,rcurrent)=to_visit.queue[0]
         (lhcur,rhcur)=(int(lcurrent/2),int(rcurrent/2))
         (ltcur,rtcur)=(int(lcurrent*3+1),int(rcurrent*3+1))
         if (lhcur>=lout and rhcur<=rout):
             print(routes[(lcurrent,rcurrent)]+'h')
             found=True
             break
         if not visited.__contains__((lhcur, rhcur)):
             visited.add((lhcur,rhcur))
             to_visit.put((lhcur,rhcur))
             routes[(lhcur,rhcur)]=routes[(lcurrent,rcurrent)]+'h'
            # print("adding:", lhcur, rhcur)
         if(rcurrent-lcurrent>rout-lout and lcurrent<lout):
             to_visit.get()
             continue
         if (ltcur>=lout and rtcur<=rout):
             print(routes[(lcurrent,rcurrent)]+'t')
             found=True
             break
         if (not visited.__contains__((ltcur, rtcur)) and rtcur<1000000):
             visited.add((ltcur,rtcur))
             to_visit.put((ltcur,rtcur))
             routes[(ltcur,rtcur)]=routes[(lcurrent,rcurrent)]+'t'
             #print("adding:", ltcur,rtcur)
         to_visit.get()
         #print("debug",to_visit.queue[0])
     if not found:
         print("IMPOSSIBLE")

     return


if __name__ == "__main__":
    if len(sys.argv) > 1:
        with open(sys.argv[1], "rt") as f:
            process(f)
    else:
        process(sys.stdin) 