/*TREE IMPLEMENTATION FROM https://en.wikibooks.org/wiki/Prolog/Associative_map*/
lookup_ordmap(K, t(X,Y,L,R), V) :-
    (K == X ->
        V = Y
    ; K @< X ->
        lookup_ordmap(K,L,V)
    ;
        lookup_ordmap(K,R,V)
    ),!.
insert_ordmap(K, V, nil, t(K,V,nil,nil)).
insert_ordmap(K, V, t(X,Y,L0,R), t(X,Y,L,R)) :-
    K @< X,
    insert_ordmap(K,V,L0,L),!.
insert_ordmap(K, V, t(X,Y,L,R0), t(X,Y,L,R)) :-
    K @> X,
    insert_ordmap(K,V,R0,R).

/*empty*/



ztalloc([LIN,RIN],[LOUT,ROUT],_,_,_,'EMPTY'):-
    LIN>=LOUT,
    RIN=<ROUT, !.
/*impossible*/
ztalloc([_LIN,_RIN],_OUT,[],_VISITED,_ROUTES,'IMPOSSIBLE'):- !.

/*ftanw se mia kinisi*/
ztalloc([_LIN,_RIN],[LOUT,ROUT],[point(LCUR,RCUR)|_TO_VISIT],_VISITED,[ROUTE|_ROUTES],RES):-
    L_H is div(LCUR,2),
    R_H is div(RCUR,2),
    L_H>=LOUT,
    R_H=<ROUT,
    concat(ROUTE,h,RES),!.
ztalloc([_LIN,_RIN],[LOUT,ROUT],[point(LCUR,RCUR)|_TO_VISIT],_VISITED,[ROUTE|_ROUTES],RES):-
    L_T is LCUR*3+1,
    R_T is RCUR*3+1,
    R_T<1000000,
    L_T>=LOUT,
    R_T=<ROUT,
    concat(ROUTE,t,RES),!.

/*megalitero evros se mikroterous arithmous-> paw mono pros ta katw*/
ztalloc([LIN,RIN],[LOUT,ROUT],[point(LCUR,RCUR)|TO_VISIT],VISITED,[ROUTE|ROUTES],RES):-
    DIFIN is RCUR-LCUR,
    DIFOUT is ROUT-LOUT,
    DIFIN>DIFOUT,
    RCUR=<ROUT,
     L_H is div(LCUR,2),
    R_H is div(RCUR,2),
     ( \+lookup_ordmap(point(L_H,R_H),VISITED,_VAL)->(insert_ordmap(point(L_H,R_H),1,VISITED,V1),append(TO_VISIT,[point(L_H,R_H)],TO_V1),
                                     concat(ROUTE,h,R1),
                                    append(ROUTES,[R1],NR1));
                                  (   V1=VISITED,TO_V1=TO_VISIT,NR1=ROUTES)),
     ztalloc([LIN,RIN],[LOUT,ROUT],TO_V1,V1,NR1,RES),!.



/*BFS*/

ztalloc([LIN,RIN],[LOUT,ROUT],[point(LCUR,RCUR)|TO_VISIT],VISITED,[ROUTE|ROUTES],RES):-

     L_H is div(LCUR,2),
    R_H is div(RCUR,2),
     L_T is LCUR*3+1,
    R_T is RCUR*3+1,
    ( \+lookup_ordmap(point(L_H,R_H),VISITED,_VAL)->(insert_ordmap(point(L_H,R_H),1,VISITED,V1),append(TO_VISIT,[point(L_H,R_H)],TO_V1),
                                     concat(ROUTE,h,R1),
                                    append(ROUTES,[R1],NR1));
                                  (   V1=VISITED,TO_V1=TO_VISIT,NR1=ROUTES)),
      (  (\+lookup_ordmap(point(L_T,R_T),VISITED,_VALUE),R_T<1000000)->(insert_ordmap(point(L_T,R_T),1,V1,V2),append(TO_V1,[point(L_T,R_T)],TO_V2),
                                     concat(ROUTE,t,R2),
                                     append(NR1,[R2],NR2));
                              (   V2=V1,TO_V2=TO_V1,NR2=NR1)),
      ztalloc([LIN,RIN],[LOUT,ROUT],TO_V2,V2,NR2,RES).


ztalloc_([LIN,RIN],[LOUT,ROUT],RESULT):-
    ztalloc([LIN,RIN],[LOUT,ROUT],[point(LIN,RIN)],t(point(LIN,RIN),1,nil,nil),[s],RES),
    (   ( RES='EMPTY';RES='IMPOSSIBLE')->(RESULT=RES);
    concat(s,RESULT,RES)),!.



read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

ztalloc(_STREAM,0,[]).
ztalloc(STREAM,TESTCASES,[ANS|ANSWER]):-

    read_line(STREAM,[LIN,RIN,LOUT,ROUT]),
   ztalloc_([LIN,RIN],[LOUT,ROUT],ANS),
   NT is TESTCASES-1,

   ztalloc(STREAM,NT,ANSWER),!.
ztalloc_(FILE,ANS):-
    open(FILE,read,STREAM),
    read_line(STREAM,TESTCASES),
    ztalloc(STREAM,TESTCASES,ANS),!.
ztalloc(FILE,ANSWER):-
    ztalloc_(FILE,ANSWER),
    write('Answer = '),
     maplist(writeln,ANSWER),!.