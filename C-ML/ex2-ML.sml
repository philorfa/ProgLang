(*UPARXEI ENA \n sto telos tou arxeiou !!!!!*)



fun compare((x1,y1),(x2,y2))=
case Int.compare(x1,x2) of EQUAL=>Int.compare(y1,y2)
|order=>order 

structure K = BinaryMapFn(struct   
    type ord_key = int*int
    val compare = compare
  end)  


structure S=BinaryMapFn(struct     
    type ord_key = int
    val compare =Int.compare
  end)



fun savethecat(file)=
let

fun parse file =
let
    fun next_String input = (TextIO.inputAll input) 
    val stream = TextIO.openIn file
    val a = next_String stream
in
    explode(a)
end

fun first (a,b)=a
fun second (a,b)=b

fun Sinp (xo, k1,va2)= S.insert(xo, k1,va2)
    
fun Sfin (x1,key)=  S.find(x1,key) 
    
fun Kinp(x2,(k1,k2),valt)=K.insert(x2,(k1,k2),valt)

fun Kfin(x3,(k3,k4))=K.find(x3,(k3,k4))

fun maketree([],dentroA,dentroW,timesA,timesW,i,j,plhthosA,plhthosW,grA,grW,first,col) = (dentroA,dentroW,timesA,timesW,plhthosA,plhthosW,i-1,col-1,grA,grW)
    | maketree (a::al,dentroA,dentroW,timesA,timesW,i,j,plhthosA,plhthosW,grA,grW,first,col) =
    if(a = #"\n") then maketree(al,dentroA, dentroW,timesA,timesW,i+1,0,plhthosA,plhthosW,grA,grW,false,col)
    else if (a = #"A") then 
        (if(first) then maketree(al, Kinp(dentroA,(i,j),1),Kinp(dentroW,(i,j),0),Sinp(timesA,plhthosA,(i,j)),timesW,i,j+1,plhthosA+1,plhthosW,Kinp(grA,(i,j),"A"),Kinp(grW,(i,j),"U"),first,col+1)
        else maketree(al, Kinp(dentroA,(i,j),1),Kinp(dentroW,(i,j),0),Sinp(timesA,plhthosA,(i,j)),timesW,i,j+1,plhthosA+1,plhthosW,Kinp(grA,(i,j),"A"),Kinp(grW,(i,j),"U"),first,col))
    else if (a = #"W") then 
        (if (first) then maketree(al, Kinp(dentroA,(i,j),0),Kinp(dentroW,(i,j),1),timesA,Sinp(timesW,plhthosW,(i,j)),i,j+1,plhthosA,plhthosW+1,Kinp(grA,(i,j),"U"),Kinp(grW,(i,j),"W"),first,col+1)
        else maketree(al, Kinp(dentroA,(i,j),0),Kinp(dentroW,(i,j),1),timesA,Sinp(timesW,plhthosW,(i,j)),i,j+1,plhthosA,plhthosW+1,Kinp(grA,(i,j),"U"),Kinp(grW,(i,j),"W"),first,col))
    else if (a = #"X") then 
        (if (first) then maketree(al, Kinp(dentroA,(i,j),~1),Kinp(dentroW,(i,j),~1),timesA,timesW,i,j+1,plhthosA,plhthosW,Kinp(grA,(i,j),"U"),Kinp(grW,(i,j),"U"),first,col+1)
        else maketree(al, Kinp(dentroA,(i,j),~1),Kinp(dentroW,(i,j),~1),timesA,timesW,i,j+1,plhthosA,plhthosW,Kinp(grA,(i,j),"U"),Kinp(grW,(i,j),"U"),first,col))
    else if (a = #".") then
        (if (first) then maketree(al, Kinp(dentroA,(i,j),0),Kinp(dentroW,(i,j),0),timesA,timesW,i,j+1,plhthosA,plhthosW,Kinp(grA,(i,j),"U"),Kinp(grW,(i,j),"U"),first,col+1)
        else maketree(al, Kinp(dentroA,(i,j),0),Kinp(dentroW,(i,j),0),timesA,timesW,i,j+1,plhthosA,plhthosW,Kinp(grA,(i,j),"U"),Kinp(grW,(i,j),"U"),first,col))
    else maketree([],dentroA, dentroW,timesA,timesW,i,j,plhthosA,plhthosW,grA,grW,false,col)
    
    

fun expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,dir,grammata)= ( if (plhthos>mew) then (dentro,grammata)
                                                    else (
    
                                                    if(dir=1) then
                                                    
                                                    
                                                    (if (first(valOf(Sfin(theseis,plhthos)))<rowz) then
                                                    
                                                    (
                                                    if ((valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos)))+1,second(valOf(Sfin(theseis,plhthos))))))=0)orelse(valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos)))+1,second(valOf(Sfin(theseis,plhthos))))))>time)) then (expandgrid(plhthos,mew+1,curmew,Sinp(theseis,mew+1,((first(valOf(Sfin(theseis,plhthos)))+1,(second(valOf(Sfin(theseis,plhthos))))))),Kinp(dentro,(first(valOf(Sfin(theseis,plhthos)))+1,second(valOf(Sfin(theseis,plhthos)))),time),time,rowz,columz,2,Kinp(grammata,(first(valOf(Sfin(theseis,plhthos)))+1,second(valOf(Sfin(theseis,plhthos)))),"D")))
                                                    else expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,2,grammata)
                                                    )
                                                    
                                                    else expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,2,grammata)
                                                    )
                                                    
                                                    else if(dir=2) then
                                                    
                                                    (if(second(valOf(Sfin(theseis,plhthos)))>0) then 
                                                    
                                                    
                                                    
                                                    (
                                                    if ((valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))-1)))=0)orelse(valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))-1)))>time)) then (expandgrid(plhthos,mew+1,curmew,Sinp(theseis,mew+1,((first(valOf(Sfin(theseis,plhthos))),(second(valOf(Sfin(theseis,plhthos)))-1)))),Kinp(dentro,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))-1),time),time,rowz,columz,3,Kinp(grammata,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))-1),"L")))
                                                    else expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,3,grammata)
                                                    )
                                                    else expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,3,grammata)
                                                    )
                                                    
                                                    else if(dir=3) then
                                                    
                                                    (
                                                    if (second(valOf(Sfin(theseis,plhthos)))<columz) then
                                                    (
                                                    if ((valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))+1)))=0)orelse(valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))+1)))>time)) then (expandgrid(plhthos,mew+1,curmew,Sinp(theseis,mew+1,((first(valOf(Sfin(theseis,plhthos))),(second(valOf(Sfin(theseis,plhthos)))+1)))),Kinp(dentro,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))+1),time),time,rowz,columz,4,Kinp(grammata,(first(valOf(Sfin(theseis,plhthos))),second(valOf(Sfin(theseis,plhthos)))+1),"R")))
                                                    
                                                    else expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,4,grammata)
                                                    )
                                                    else expandgrid(plhthos,mew,curmew,theseis,dentro,time,rowz,columz,4,grammata)
                                                    )
                                                    
                                                    else(
                                                    
                                                    (
                                                    if (first(valOf(Sfin(theseis,plhthos)))>0) then 
                                                    
                                                    (
                                                     if (valOf(Kfin(dentro,(first(valOf(Sfin(theseis,plhthos)))-1,second(valOf(Sfin(theseis,plhthos))))))=0) then
                                                        (if (plhthos=curmew) then	(expandgrid(plhthos+1,mew+1,mew+1,Sinp(theseis,mew+1,((first(valOf(Sfin(theseis,plhthos)))-1,(second(valOf(Sfin(theseis,plhthos))))))),Kinp(dentro,(first(valOf(Sfin(theseis,plhthos)))-1,second(valOf(Sfin(theseis,plhthos)))),time),time+1,rowz,columz,1,grammata))
                                                        else (expandgrid(plhthos+1,mew+1,curmew,Sinp(theseis,mew+1,((first(valOf(Sfin(theseis,plhthos)))-1,(second(valOf(Sfin(theseis,plhthos))))))),Kinp(dentro,(first(valOf(Sfin(theseis,plhthos)))-1,second(valOf(Sfin(theseis,plhthos)))),time),time,rowz,columz,1,grammata))
                                                        )
                                                    else
                                                    ( if (plhthos=curmew) then (expandgrid(plhthos+1,mew,mew,theseis,dentro,time+1,rowz,columz,1,grammata))
                                                    else (expandgrid(plhthos+1,mew,curmew,theseis,dentro,time,rowz,columz,1,grammata)))
                                                    )
                                                    
                                                    else (
                                                    if (plhthos=curmew) then (expandgrid(plhthos+1,mew,mew,theseis,dentro,time+1,rowz,columz,1,grammata))
                                                    else (expandgrid(plhthos+1,mew,curmew,theseis,dentro,time,rowz,columz,1,grammata))
                                                    )
                                                    )
                                     
                                     )
                                                        
                                                    )
                                                    )
                                                    
                                                    
fun search(0,0,dentrA,dentrW,time,ipoint,jpoint,columzz)=
                                                (if ((valOf(Kfin(dentrW,(0,0)))=0)andalso(valOf(Kfin(dentrA,(0,0)))>0)) then 
                                                (print("infinity");print("\n");(0,0))
                                                
                                                else if (valOf(Kfin(dentrW,(0,0))))>(valOf(Kfin(dentrA,(0,0)))) then
                                                (if ((valOf(Kfin(dentrW,(0,0)))>=time)andalso(time<>0)) then (print(Int.toString (valOf(Kfin(dentrW,(0,0)))-2));(0,0))
                                                 else (
                                                 if(time=0) then (print("infinity");print("\n");(ipoint,jpoint))
                                                 else (print(Int.toString (time-2));print("\n");(ipoint,jpoint)))
                                                 )
                                                 
                                                 else(
                                                 if(time=0) then (print("infinity");print("\n");(ipoint,jpoint))
                                                 else (print(Int.toString (time-2));print("\n");(ipoint,jpoint))
                                                 ))
                                                 
    |search(inow,jnow,dentrA,dentrW,time,ipoint,jpoint,columzz)= (
                                                if ((valOf(Kfin(dentrW,(inow,jnow)))=0)andalso(valOf(Kfin(dentrA,(inow,jnow)))>0)) then 
                                                ((if(jnow>0)then(search(inow,jnow-1,dentrA,dentrW,valOf(Kfin(dentrW,(inow,jnow))),inow,jnow,columzz))
                                                else (search(inow-1,columzz,dentrA,dentrW,valOf(Kfin(dentrW,(inow,jnow))),inow,jnow,columzz))))
                                                
                                                else if (valOf(Kfin(dentrW,(inow,jnow)))>valOf(Kfin(dentrA,(inow,jnow)))) then
                                                (if ((valOf(Kfin(dentrW,(inow,jnow)))>=time)andalso(time<>0)) then 
                                                (if(jnow>0)then(search(inow,jnow-1,dentrA,dentrW,valOf(Kfin(dentrW,(inow,jnow))),inow,jnow,columzz))
                                                else (search(inow-1,columzz,dentrA,dentrW,valOf(Kfin(dentrW,(inow,jnow))),inow,jnow,columzz)))
                                                 else  (if(jnow>0)then(search(inow,jnow-1,dentrA,dentrW,time,ipoint,jpoint,columzz))
                                                else (search(inow-1,columzz,dentrA,dentrW,time,ipoint,jpoint,columzz))))
                                                
                                                else (if(jnow>0)then(search(inow,jnow-1,dentrA,dentrW,time,ipoint,jpoint,columzz))
                                                    else (search(inow-1,columzz,dentrA,dentrW,time,ipoint,jpoint,columzz)))
                                                )

fun vhmata(gram,istart,jstart,kin,dentr)=if(valOf(Kfin(dentr,(istart,jstart)))=1) then if(kin=[]) then (print("stay");kin)else kin
                                                else
                                            (if (valOf(Kfin(gram,(istart,jstart)))="R")then vhmata(gram,istart,jstart-1,"R"::kin,dentr)
                                            else if(valOf(Kfin(gram,(istart,jstart)))="L")then vhmata(gram,istart,jstart+1,"L"::kin,dentr)
                                            else if(valOf(Kfin(gram,(istart,jstart)))="U")then vhmata(gram,istart+1,jstart,"U"::kin,dentr)
                                            else vhmata(gram,istart-1,jstart,"D"::kin,dentr)
                                            )



fun printlist l = 
    case l of [] => print"\n"
            |[a] => (print (a);printlist [])
            | x::xs => (print (x) ; printlist xs) ;


val (treeA,treeW,phgesA,phgesW,plA,plW,rows,colums,grammataA,grammataW)=maketree(parse(file),K.empty,K.empty,S.empty,S.empty,0,0,0,0,K.empty,K.empty,true,0)
val (dentroA,poreiaA)=expandgrid(0,plA-1,plA-1,phgesA,treeA,2,rows,colums,1,grammataA)
val (dentroW,poreiaW)=expandgrid(0,plW-1,plW-1,phgesW,treeW,2,rows,colums,1,grammataW)
val (targeti,targetj)=search(rows,colums,dentroA,dentroW,1,0,0,colums)
val (kiniseis) = vhmata(poreiaA,targeti,targetj,[],dentroA)
in
if (plA=0) then print"Missing cat Reward If Founnd"
else printlist (kiniseis)
end