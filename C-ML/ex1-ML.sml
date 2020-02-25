fun minimum (n1,n2)= if(n1>n2) then n2 else n1;

structure S = BinaryMapFn(struct
    type ord_key = int
    val compare = Int.compare
  end);

fun colors file=
let
fun parse file =
    let
    (* A function to read an integer from specified input. *)
        fun readInt input = 
        Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

    (* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer (number of countries) and consume newline. *)
    val mhkos = readInt inStream
    val plhthos = readInt inStream
    val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
    fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
      | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(mhkos+1,plhthos,readInts mhkos [])
    end


fun solution(mhkos,plhthos,lis)=
let
fun inp (xo, k,va)= S.insert(xo, k,va)
    
    fun fin (x1,key)= (S.find(x1,key))
in

let
fun windows (lisftiaxnw,lisdinw,arxh ,telos,min,dentro,pl,number,orio)=
    case lisftiaxnw of [] => ( case lisdinw of []=> (if(min= orio) then 0 else min)
                                            |[a]=> (if (number=pl) then ((if (min=orio) then 0 else min))
                                                    else windows([a],[],arxh,telos+1,min,inp(dentro,a,1),pl+1,number,orio))
                                | h1::t1 => 
                                            (if(number=pl) then ((if (min=orio) then 0 else min))
                                            else windows([h1],t1,arxh,telos+1,min,inp(dentro,h1,1),pl+1,number,orio))
                                )
    
                | [a]=> ( case lisdinw of []=> ( if (pl<number) then (if (min=orio) then 0 else min)
                                                    else 
                                                    ( if (valOf(fin(dentro,a))=1) then windows([],[],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,a,0),pl-1,number,orio)
                                                    else windows([],[],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,a,valOf(fin(dentro,a))-1),pl,number,orio))
                                                )
                                                
                                |[b]=> (if (pl<number) then 
                                                        (if fin(dentro,b)=NONE then (windows(a::[b],[],arxh,telos+1,min,inp(dentro,b,1),pl+1,number,orio))
                                                        else if( valOf(fin(dentro,b))=0) then (windows(a::[b],[],arxh,telos+1,min,inp(dentro,b,1),pl+1,number,orio))
                                                        else (windows(a::[b],[],arxh,telos+1,min,inp(dentro,b,valOf(fin(dentro,b))+1),pl,number,orio)))
                                                        else (
                                                        if (valOf(fin(dentro,a))=1) then (windows([],[b],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,a,0),pl-1,number,orio))
                                                        else (windows(a::[b],[],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,b,valOf(fin(dentro,a))-1),pl,number,orio)))
                                        )
                                        
                                |h::t=> (if (pl<number) then 
                                                        (if fin(dentro,h)=NONE then (windows(a::[h],t,arxh,telos+1,min,inp(dentro,h,1),pl+1,number,orio))
                                                        else if( valOf(fin(dentro,h))=0) then (windows(a::[h],t,arxh,telos+1,min,inp(dentro,h,1),pl+1,number,orio))
                                                        else (windows(a::[h],t,arxh,telos+1,min,inp(dentro,h,valOf(fin(dentro,h))+1),pl,number,orio)))
                                        else (       if (valOf(fin(dentro,a))=1) then (windows([],h::t,arxh+1,telos,minimum(min,telos-arxh),inp(dentro,a,0),pl-1,number,orio))
                                                        else (windows([],h::t,arxh+1,telos,minimum(min,telos-arxh),inp(dentro,a,valOf(fin(dentro,a))-1),pl,number,orio)))
                                        )
                        )
                                                        
                | head::tail => (	case lisdinw of []=> ( if (pl<number) then (if (min=orio) then 0 else min)
                                                    else 
                                                    (if (valOf(fin(dentro,head))=1) then windows(tail,[],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,head,0),pl-1,number,orio)
                                                    else windows(tail,[],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,head,valOf(fin(dentro,head))-1),pl,number,orio))
                                                    )
                                                        
                                |[c]=> (if (pl<number) then 
                                                        (if fin(dentro,c)=NONE then (windows([head]@tail@[c],[],arxh,telos+1,min,inp(dentro,c,1),pl+1,number,orio))
                                                        else if( valOf(fin(dentro,c))=0) then (windows([head]@tail@[c],[],arxh,telos+1,min,inp(dentro,c,1),pl+1,number,orio))
                                                        else (windows([head]@tail@[c],[],arxh,telos+1,min,inp(dentro,c,valOf(fin(dentro,c))+1),pl,number,orio)))
                                                        else (
                                                        if (valOf(fin(dentro,head))=1) then (windows(tail,[c],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,head,0),pl-1,number,orio))
                                                        else (windows(tail,[c],arxh+1,telos,minimum(min,telos-arxh),inp(dentro,head,valOf(fin(dentro,head))-1),pl,number,orio)))
                                                        )
                                        
                                |headhead::tailtail=> (if (pl<number) then 
                                                        (if (fin(dentro,headhead)=NONE) then (windows([head]@tail@[headhead],tailtail,arxh,telos+1,min,inp(dentro,headhead,1),pl+1,number,orio))
                                                        else if( valOf(fin(dentro,headhead))=0) then (windows([head]@tail@[headhead],tailtail,arxh,telos+1,min,inp(dentro,headhead,1),pl+1,number,orio))
                                                        else (windows([head]@tail@[headhead],tailtail,arxh,telos+1,min,inp(dentro,headhead,valOf(fin(dentro,head))+1),pl,number,orio)))
                                        else (       if (valOf(fin(dentro,head))=1) then (windows(tail,headhead::tailtail,arxh+1,telos,minimum(min,telos-arxh),inp(dentro,head,0),pl-1,number,orio))
                                                        else (windows(tail,headhead::tailtail,arxh+1,telos,minimum(min,telos-arxh),inp(dentro,head,valOf(fin(dentro,head))-1),pl,number,orio)))
                                                        )
                                )	
in

    print (Int.toString (windows([],lis,0,0,mhkos+1,S.empty,0,plhthos,mhkos+1)));print("\n")
end
end
in 
solution(parse file)
end;