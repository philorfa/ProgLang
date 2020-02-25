colors(File,Answer):-
     read_input(File,N,K,C),
     Previous is N+1,
     Max is N+1,
     gonow(C,[],nil,Previous,K,0,0,Max,Answer).

gonow([],[],_,Previous,Goal,Countercolor,Counterlenght,Max,Answer):-
    Countercolor==Goal->(%!write('1'),
                      Counterlenght<Previous->(Answer is Counterlenght);
                      Answer is Previous);
    Countercolor<Goal->(%!write('2'),
                     Previous<Max-> (Answer is Previous);
                     Answer is 0).

gonow([H|L],[],Map,Previous,Goal,Countercolor,Counterlenght,Max,Answer):-
   %! write('3'),write('bainei to'),write(H),writeln(' gia prwth fora'),
    insert_ordmap(H,1,Map,Map1),NCountercolor is Countercolor+1, NCounterlenght is Counterlenght+1,
    gonow(L,[H],Map1,Previous,Goal,NCountercolor,NCounterlenght,Max,Answer).

gonow([],[H1|L1],Map,Previous,Goal,Countercolor,Counterlenght,Max,Answer):-
    Countercolor<Goal->(Previous<Max->(%!write('4'),
                                      Answer is Previous);
                       Answer is 0);
    Countercolor==Goal->(Counterlenght<Previous->(%!write('5'),write('feugei to '),writeln(H1),
                                                 NPrevious is Counterlenght,
                                                  remove_ordmap(H1,Map,Map1,V)->(

                                           V>1 ->(%!write('aa'),
                                                  NewV is V-1,
                                                    insert_ordmap(H1,NewV,Map1,Map0),NCounterlenght is Counterlenght-1,
                                                    gonow([],L1,Map0,NPrevious,Goal,Countercolor,NCounterlenght,Max,Answer));
                                            V=1->(%!write('bb'),write('H1='),write(H1) ,
                                                  NewV is V-1,
                                                    NCounterlenght is Counterlenght-1,
                                                     NCountercolor is Countercolor-1,
                                                     gonow([],L1,Map1,NPrevious,Goal,NCountercolor,NCounterlenght,Max,Answer))));
                        Counterlenght>=Previous->(%!write('6'),write('feugei to '),writeln(H1),
                                                   remove_ordmap(H1,Map,Map1,V)->(
                                           V>1 ->( NewV is V-1,
                                                    insert_ordmap(H1,NewV,Map1,Map0),NCounterlenght is Counterlenght-1,
                                                    gonow([],L1,Map0,Previous,Goal,Countercolor,NCounterlenght,Max,Answer));
                                            V=1->( NewV is V-1,
                                                     NCounterlenght is Counterlenght-1,
                                                     NCountercolor is Countercolor-1,
                                                     gonow([],L1,Map1,Previous,Goal,NCountercolor,NCounterlenght,Max,Answer))))).


gonow([H|L],[H1|L1],Map,Previous,Goal,Countercolor,Counterlenght,Max,Answer):-
   Countercolor<Goal ->(
                     remove_ordmap(H,Map,Map1,V)->(%!write('7'),
                         NewV is V+1,
                         %!write('bainei to '),write(H),write(' gia '),write(NewV),writeln(' fora'),
                         insert_ordmap(H,NewV,Map1,Map0),NCounterlenght is Counterlenght+1,append([H1|L1],[H],NAdded),
                         gonow(L,NAdded,Map0,Previous,Goal,Countercolor,NCounterlenght,Max,Answer));
                     \+remove_ordmap(H,Map,Map1,V)->(%!write('8'),write('bainei to '),write(H),writeln(' gia prwth fora'),
                         insert_ordmap(H,1,Map,Map1),NCountercolor is Countercolor+1,append([H1|L1],[H],NAdded),
                         NCounterlenght is Counterlenght+1,
                         gonow(L,NAdded,Map1,Previous,Goal,NCountercolor,NCounterlenght,Max,Answer)));

    Countercolor==Goal->( Counterlenght<Previous -> (
                                          %!write('9'),write('feugei to '),writeln(H1),
                                          NPrevious is Counterlenght,
                                           remove_ordmap(H1,Map,Map1,V)->(

                                            V>1 ->(%!write('aa'),
                                                  NewV is V-1,
                                                  %!write('NewV einai iso me '),writeln(NewV),
                                                    insert_ordmap(H1,NewV,Map1,Map0),NCounterlenght is Counterlenght-1,
                                                    gonow([H|L],L1,Map0,NPrevious,Goal,Countercolor,NCounterlenght,Max,Answer));
                                            V=1->(%!write('bb'),
                                                  NewV is V-1,
                                                  %!write('NewV einai iso me '),writeln(NewV),
                                                     NCounterlenght is Counterlenght-1,
                                                     NCountercolor is Countercolor-1,
                                                     gonow([H|L],L1,Map1,NPrevious,Goal,NCountercolor,NCounterlenght,Max,Answer))));
                        Counterlenght>=Previous->(%!write('10'),write('feugei to '),writeln(H1),
                                                   remove_ordmap(H1,Map,Map1,V)->(

                                           V>1 ->(%!write('aa'),
                                                  NewV is V-1,
                                                    insert_ordmap(H1,NewV,Map1,Map0),NCounterlenght is Counterlenght-1,
                                                    gonow([H|L],L1,Map0,Previous,Goal,Countercolor,NCounterlenght,Max,Answer));
                                            V=1->(%!write('bb'),
                                                  NewV is V-1,
                                                     NCounterlenght is Counterlenght-1,
                                                     NCountercolor is Countercolor-1,
                                                     gonow([H|L],L1,Map1,Previous,Goal,NCountercolor,NCounterlenght,Max,Answer))))).








insert_ordmap(K, V, nil, t(K,V,nil,nil)).
insert_ordmap(K, V, t(X,Y,L0,R), t(X,Y,L,R)) :-
    K @< X,
    insert_ordmap(K,V,L0,L).
insert_ordmap(K, V, t(X,Y,L,R0), t(X,Y,L,R)) :-
    K @> X,
    insert_ordmap(K,V,R0,R).


remove_ordmap(K, t(X,Y,L0,R), t(X,Y,L,R), V) :-
    K @< X,
    remove_ordmap(K,L0,L,V).
remove_ordmap(K, t(X,Y,L,R0), t(X,Y,L,R), V) :-
    K @> X,
    remove_ordmap(K,R0,R,V).
remove_ordmap(K, t(X,V,L,R), T, V) :-
    K == X,
    (L == nil ->
        T = R
    ; R == nil ->
        T = L
    ;
        rm_max(L,L1,K1,V1),
        T = t(K1,V1,L1,R)
    ).
rm_max(t(K,V,L,nil), L, K, V) :- !.
rm_max(t(X,Y,L,R0), t(X,Y,L,R), K, V) :-
    rm_max(R0,R,K,V).



read_input(File, N, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).