
%%%Διαβάζω και εισάγω στο trie ως εξής
%%%Κάνω κάθε αριθμό πίνακα τον αντιστρέφω και σε κάθε Node
%%%χρησιμοποιώ ως key το ψηφίο που αντιστοιχεί σε αυτό το σημείο
%%%και ως value τον αριθμό των παιδιών που έχει
%%%για κάθε ίδιο ψηφίο μετράω τα παιδιά και κάνω τους κατάλληλους υπολογισμούς
%%%για το πόσα κληρώνονται συνολικά


:- use_module(library(assoc)).
:- use_module(library(lists)).


lottery(File,L):-
  trie_new(Trie),
  open(File,read,Stream),
  read_line(Stream,[K,N,Q]),
  once(methodman(Trie,Stream,K,N)),
  once(ghost(Trie,Stream,K,Q,[],L)).


special([],Temp,Key):-
  append([],Temp,Key).
special([LisH|LisL],Temp,Key):-
  atom_string(LisH,TisH),
  append(Temp,[TisH],New),
  special(LisL,New,Key).

read_input(File, K, N, Q, C) :-
    open(File, read, Stream),
    read_line(Stream, [K, N, Q]),
    get_char(Stream,Char),
    process_the_stream([],Char,Stream,C),
    close(Stream).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

read_test(Stream,Reved):-
  read_line_to_codes(Stream,Codes),
%%% atom_codes(Atom, Codes),
  maplist(nonascii,Codes,Lis),
%%%  maplist(number_string,Lis,Key),
  special(Lis,[],Key),
  reverse(Key,Reved).

nonascii(Num,Res):-
  Res is Num-48.
  
powa(B,E,R) :- powa(B,E,1,R).
powa(_,0,A,A).
powa(B,E,A,R) :- E > 0, !, E1 is E - 1, A1 is B * A, powa(B,E1,A1,R).

power2(X,Y):- once(powa(2,X,Y)).

pow3(X,Y,Z) :- powend(X,Y,1,Z),!.

powend(_,0,A,Z) :- Z is A.
powend(X,Y,A,Z) :- Y1 is Y - 1, A1 is A*X, powend(X,Y1,A1,Z).

power3(X,Y):-once(pow3(2,X,Y)).


mef(Trie,Stream,K):-
  read_test(Stream,L),
  once(newinsert(Trie,L,'',K)).

methodman(_,_,_,0).

methodman(Trie,Stream,K,N):-
  mef(Trie,Stream,K),
  Counter is N-1,
  methodman(Trie,Stream,K,Counter).



newinsert(Trie,[Key|_],NodeVal,1):-
  atom_concat(NodeVal,Key,Finalkey),
  once(trie_insert(Trie,Finalkey,null)).

newinsert(Trie,[KeyH|KeyL],Value,K):-
  atom_concat(Value,KeyH,NodeVal),
  (trie_lookup(Trie,NodeVal,X)->
    X1 is X+1,
    trie_updatenew(Trie,NodeVal,X1),
    K1 is K-1,
    once(newinsert(Trie,KeyL,NodeVal,K1))
    ;
    trie_insert(Trie,NodeVal,1),
    K1 is K-1,
    once(newinsert(Trie,KeyL,NodeVal,K1))
    ).



ghost(_,_,_,0,Temp,L):-
  L=Temp.

ghost(Trie,Stream,K,Q,Temp,L):-
  read_test(Stream,[KeyH|KeyL]),
  indpayout(Trie,Stream,KeyH,KeyL,K-1,K,_,_,Temp,Res),
  append(Temp,[Res],Lnew),
  Counter is Q-1,
  once(ghost(Trie,Stream,K,Counter,Lnew,L)).



indpayout(Trie,Stream,KeyH,[RestH|RestL],Depth,K,Payout,Winners,Temp,L):-
  atom_concat('',KeyH,Keysearch),
  (trie_lookup(Trie,Keysearch,X)->
    atom_concat(Keysearch,RestH,Tool),
    append([Tool],RestL,[TempH|TempL]),
    Payout is X,
    Winners is X,
    Depth2 is Depth-1,
    once(indpayout2(Trie,Stream,TempH,TempL,Depth2,K,Payout,Winners,Temp,L))
    ;
    L=[0,0]
    ).


indpayout2(Trie,_,Key,_,0,K,Payout,Winners,_,L):-
  (trie_lookup(Trie,Key,_)->
    Power is K,
    payout(Power,1,Payout,Payout2),
    L=[Winners,Payout2];
    L=[Winners,Payout]
  ).  

indpayout2(Trie,Stream,KeyH,[RestH|RestL],Depth,K,Payout,Winners,Temp,L):-
  atom_concat('',KeyH,Keysearch),
  (trie_lookup(Trie,Keysearch,X)->
    atom_concat(Keysearch,RestH,Tool),
    append([Tool],RestL,[TempH|TempL]),
    Power is K-Depth,
    payout(Power,X,Payout,Payout2),
    Depth2 is Depth-1,
    once(indpayout2(Trie,Stream,TempH,TempL,Depth2,K,Payout2,Winners,Temp,L))
    ;
    L=[Winners,Payout]
    ).



payout(0,_,Sum,Return):-
  Return is Sum.

payout(Pow,X,Sum,Return):-
  Temp is Pow-1,
  power3(Pow,Z),
  power3(Temp,Z1),
  Sum2 is Sum+(Z-1)*X-(Z1-1)*X,
  Return is Sum2.

payoutred(0,_,Sum,Return):-
  Return is Sum.

payoutred(Pow,X,Sum,Return):-
  power3(Pow,Z),
  Sum2 is Sum-(Z-1)*X,
  Pow2 is Pow-1,
  payoutred(Pow2,X,Sum2,Return).

someshit(X,C):-
  trie_new(Trie),
  trie_insert(Trie,0,2),
  trie_insert(Trie,'1',1),
  trie_insert(Trie,'12',null),
  trie_insert(Trie,'123',fuck),
  trie_insert(Trie,'1234',shouldbethere),
  trie_insert(Trie,'t',t),
  trie_insert(Trie,'tr',tr),
  trie_insert(Trie,'tri',tri),
  trie_insert(Trie,'247193',391742),
  trie_lookup(Trie,X,C).



%%% the following was from the this github : https://github.com/JanWielemaker/tabling_library/blob/5ac1b7e61fa9d643057ed0cb0de8d53428ef443d/trie.pl  plus some things that were missing and were necessary for adjustment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% Structure of tries:
% trie_inner_node(MaybeValue,Children).
% where Children is an association list of nonvars to tries.
% and where MaybeValue is maybe_none/0 or maybe_just(Value).

% For a term of the form p(a,q(b)), "returns" functor_data(p,2) and [a,q(b)].
% p_trie_arity_univ(+Term,-FunctorData,-ArgumentsList).
p_trie_arity_univ(Term,functor_data(Name,Arity),Arguments) :-
  Term =.. [Name|Arguments],
  functor(Term,_NameAgain,Arity).

% Returns a new empty trie.
trie_new(Trie) :-
  empty_assoc(A),
  Trie = trie_inner_node(maybe_none,A).

% Succeeds if given trie does not contain any key-value pair.
% trie_is_empty(+Trie)
trie_is_empty(trie_inner_node(maybe_none,A)) :-
  empty_assoc(A).

% For internal use.
% For now, Children is an association list that can be manipulated using the assoc_ predicates.
trie_get_children(trie_inner_node(_MaybeValue,Children),Children).

% For internal use.
trie_get_maybe_value(trie_inner_node(MaybeValue,_Children),MaybeValue).

% Destructive update of the association list Children.
% For internal use.
trie_set_children(Trie,Children) :-
  nb_linkarg(2,Trie,Children).

trie_set_maybe_value(Trie,MaybeValue) :-
  nb_linkarg(1,Trie,MaybeValue).

trie_insert_succeed(Trie,Key,Value) :-
  ( trie_insert(Trie,Key,Value) ->
    true
  ;
    true
  ).

% Succeeds if the term was not present, fails if the term was present.
% The term will be present now, whatever the outcome.
% We don't use an extra argument to indicate earlier presence, as this increases the trail size.
trie_insert(Trie,Key,Value) :-
  p_trie_arity_univ(Key,FunctorData,KeyList),
  trie_insert_1(KeyList,FunctorData,Trie,Value).

trie_insert_1([],FunctorData,Trie,Value) :-
  trie_get_children(Trie,Assoc),
  % You need Assoc twice: once to traverse through it, once keeping it as a whole for insertion using put_assoc/4.
  trie_insert_a(Assoc,Assoc,FunctorData,Trie,Value).
% Inline the failure and success continuation to avoid a growing trail stack.
trie_insert_1([First|Rest],FunctorData,Trie,Value) :-
  trie_get_children(Trie,Assoc),
  % You need Assoc twice: once to traverse through it, once keeping it as a whole for insertion using put_assoc/4.
  trie_insert_1_1(Assoc,Assoc,FunctorData,Trie,First,Rest,Value).

% Else part, base case: empty assoc list.
trie_insert_a(t,Assoc,FunctorData,Trie,Value) :-
  trie_new(Subtrie),
  trie_set_maybe_value(Subtrie,maybe_just(Value)),
  put_assoc(FunctorData,Assoc,Subtrie,NewAssoc),
  trie_set_children(Trie,NewAssoc).

% Then part, nonempty assoc tree.
trie_insert_a(t(K,V,_,L,R),Assoc,FunctorData,Trie,Value) :-
  compare(Rel,FunctorData,K),
  trie_insert_b(Rel,V,L,R,Assoc,FunctorData,Trie,Value).

% Recursively look in the left part of the assoc tree.
trie_insert_b(<,_V,L,_R,Assoc,FunctorData,Trie,Value) :-
  trie_insert_a(L,Assoc,FunctorData,Trie,Value).

  % Recursively look in the right part of the assoc tree.
trie_insert_b(>,_V,_L,R,Assoc,FunctorData,Trie,Value) :-
  trie_insert_a(R,Assoc,FunctorData,Trie,Value).

trie_insert_b(=,V,_L,_R,_Assoc,_FunctorData,_Trie,Value) :-
  trie_get_maybe_value(V,MaybeValue), % V is the Subtrie
  ( MaybeValue == maybe_none ->
    trie_set_maybe_value(V,maybe_just(Value))
    % Use true to indicate that the answer was new.
    ;
    MaybeValue = maybe_just(JustValue),
    ( JustValue == Value ->
      % Fail to indicate earlier presence
      fail
      ;
      throw('trie: attempt to update the value for a key')
    )
  ).


% Else part, base case: empty assoc list
trie_insert_1_1(t,Assoc,FunctorData,Trie,First,Rest,Value) :-
  % Assoc = t, % t is the empty assoc tree
  trie_new(Subtrie),
  put_assoc(FunctorData,Assoc,Subtrie,NewAssoc),
  trie_set_children(Trie,NewAssoc),
  trie_insert_2(First,Rest,Subtrie,Value).

% Then part, lookup in assoc list.
trie_insert_1_1(t(K,V,_,L,R),Assoc,FunctorData,Trie,First,Rest,Value) :-
  compare(Rel,FunctorData,K),
  trie_insert_1_1_1(Rel,V,L,R,Assoc,FunctorData,Trie,First,Rest,Value).

trie_insert_1_1_1(=,V,_L,_R,_Assoc,_FunctorData,_Trie,First,Rest,Value) :-
  trie_insert_2(First,Rest,V,Value). % V is the Subtrie

trie_insert_1_1_1(<,_V,L,_R,Assoc,FunctorData,Trie,First,Rest,Value) :-
  % Look in the left part of the assoc tree.
  trie_insert_1_1(L,Assoc,FunctorData,Trie,First,Rest,Value).

trie_insert_1_1_1(>,_V,_L,R,Assoc,FunctorData,Trie,First,Rest,Value) :-
  % Look in the right part of the assoc tree.
  trie_insert_1_1(R,Assoc,FunctorData,Trie,First,Rest,Value).

trie_insert_2(RegularTerm,Rest,Trie,Value) :-
  p_trie_arity_univ(RegularTerm,FunctorData,KList),
  append(KList,Rest,KList2),
  trie_insert_1(KList2,FunctorData,Trie,Value).

trie_lookup(Trie,Key,Value) :-
    p_trie_arity_univ(Key,FunctorData,KeyList),
    trie_lookup_1(FunctorData,KeyList,Trie,Value).

trie_lookup_1(FunctorData,Rest,Trie,Value) :-
  % Select right subtree, fail if it isn't there, and do recursive call.
  trie_get_children(Trie,Assoc),
  get_assoc(FunctorData,Assoc,Subtrie), % Fails if not present
  trie_lookup_2(Rest,Subtrie,Value).

trie_lookup_2([],Trie,Value) :-
  % If the value at this trie is maybe_just(X), then X is our Value.
  % Otherwise, there is no value for this key, so we fail...
  trie_get_maybe_value(Trie,maybe_just(Value)).
% Regular term at the head, like p or p(a). Not functor_data/2.
trie_lookup_2([RegularTerm|Rest],Trie,Value) :-
  % split RegularTerm
  p_trie_arity_univ(RegularTerm,FunctorData,KList),
  % Make a recursive call on KList ++ Rest.
  % Since we cannot implement p_trie_arity_univ so that "its result", KList, has a free variable at the end, without resorting to techniques that require linear time, we need a call to append/3. However, since KList will in general be rather short, I don't expect this to be a large problem in practice.
  append(KList,Rest,KList2),
  trie_lookup_1(FunctorData,KList2,Trie,Value).


% Returns all values in the trie by backtracking - we don't provide any information about the associated key.
trie_get_all_values(Trie,Value) :-
  trie_get_maybe_value(Trie,maybe_just(Value)).
trie_get_all_values(Trie,Value) :-
  trie_get_children(Trie,Children),
  gen_assoc(_Key, Children, ChildTrie),
  trie_get_all_values(ChildTrie,Value).


%%%The following is the addition to those i found on github
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



  


trie_updatenew(Trie,Key,Value) :-
    p_trie_arity_univ(Key,FunctorData,KeyList),
    trie_lookup_1new(FunctorData,KeyList,Trie,Value).

trie_lookup_1new(FunctorData,Rest,Trie,Value) :-
  % Select right subtree, fail if it isn't there, and do recursive call.
  trie_get_children(Trie,Assoc),
  get_assoc(FunctorData,Assoc,Subtrie), % Fails if not present
  trie_lookup_2new(Rest,Subtrie,Value).

trie_lookup_2new([],Trie,Value) :-
  % If the value at this trie is maybe_just(X), then X is our Value.
  % Otherwise, there is no value for this key, so we fail...
  trie_set_maybe_value(Trie,maybe_just(Value)).
% Regular term at the head, like p or p(a). Not functor_data/2.
trie_lookup_2new([RegularTerm|Rest],Trie,Value) :-
  % split RegularTerm
  p_trie_arity_univ(RegularTerm,FunctorData,KList),
  % Make a recursive call on KList ++ Rest.
  % Since we cannot implement p_trie_arity_univ so that "its result", KList, has a free variable at the end, without resorting to techniques that require linear time, we need a call to append/3. However, since KList will in general be rather short, I don't expect this to be a large problem in practice.
  append(KList,Rest,KList2),
  trie_lookup_1new(FunctorData,KList2,Trie,Value).



trie_insert42(Trie,Key,Value) :-
  p_trie_arity_univ(Key,FunctorData,KeyList),
  trie_insert_142(KeyList,FunctorData,Trie,Value).

trie_insert_142([],FunctorData,Trie,Value) :-
  trie_get_children(Trie,Assoc),
  % You need Assoc twice: once to traverse through it, once keeping it as a whole for insertion using put_assoc/4.
  trie_insert_a42(Assoc,Assoc,FunctorData,Trie,Value).
% Inline the failure and success continuation to avoid a growing trail stack.
trie_insert_142([First|Rest],FunctorData,Trie,Value) :-
  trie_get_children(Trie,Assoc),
  % You need Assoc twice: once to traverse through it, once keeping it as a whole for insertion using put_assoc/4.
  trie_insert_1_142(Assoc,Assoc,FunctorData,Trie,First,Rest,Value).

% Else part, base case: empty assoc list.
trie_insert_a42(t,Assoc,FunctorData,Trie,Value) :-
  trie_new(Subtrie),
  trie_set_maybe_value(Subtrie,maybe_just(Value)),
  put_assoc(FunctorData,Assoc,Subtrie,NewAssoc),
  trie_set_children(Trie,NewAssoc).

% Then part, nonempty assoc tree.
trie_insert_a42(t(K,V,_,L,R),Assoc,FunctorData,Trie,Value) :-
  compare(Rel,FunctorData,K),
  trie_insert_b42(Rel,V,L,R,Assoc,FunctorData,Trie,Value).

% Recursively look in the left part of the assoc tree.
trie_insert_b42(<,_V,L,_R,Assoc,FunctorData,Trie,Value) :-
  trie_insert_a42(L,Assoc,FunctorData,Trie,Value).

  % Recursively look in the right part of the assoc tree.
trie_insert_b42(>,_V,_L,R,Assoc,FunctorData,Trie,Value) :-
  trie_insert_a42(R,Assoc,FunctorData,Trie,Value).

trie_insert_b42(=,V,_L,_R,_Assoc,_FunctorData,_Trie,Value) :-
    trie_set_maybe_value(V,maybe_just(Value)).


% Else part, base case: empty assoc list
trie_insert_1_142(t,Assoc,FunctorData,Trie,First,Rest,Value) :-
  % Assoc = t, % t is the empty assoc tree
  trie_new(Subtrie),
  put_assoc(FunctorData,Assoc,Subtrie,NewAssoc),
  trie_set_children(Trie,NewAssoc),
  trie_insert_242(First,Rest,Subtrie,Value).

% Then part, lookup in assoc list.
trie_insert_1_142(t(K,V,_,L,R),Assoc,FunctorData,Trie,First,Rest,Value) :-
  compare(Rel,FunctorData,K),
  trie_insert_1_1_142(Rel,V,L,R,Assoc,FunctorData,Trie,First,Rest,Value).

trie_insert_1_1_142(=,V,_L,_R,_Assoc,_FunctorData,_Trie,First,Rest,Value) :-
  trie_insert_242(First,Rest,V,Value). % V is the Subtrie

trie_insert_1_1_142(<,_V,L,_R,Assoc,FunctorData,Trie,First,Rest,Value) :-
  % Look in the left part of the assoc tree.
  trie_insert_1_142(L,Assoc,FunctorData,Trie,First,Rest,Value).

trie_insert_1_1_142(>,_V,_L,R,Assoc,FunctorData,Trie,First,Rest,Value) :-
  % Look in the right part of the assoc tree.
  trie_insert_1_142(R,Assoc,FunctorData,Trie,First,Rest,Value).

trie_insert_242(RegularTerm,Rest,Trie,Value) :-
  p_trie_arity_univ(RegularTerm,FunctorData,KList),
  append(KList,Rest,KList2),
  trie_insert_142(KList2,FunctorData,Trie,Value).



trie_update(Trie,Key,Value):-
  trie_insert42(Trie,Key,Value).
%%%%%