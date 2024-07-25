:-use_module(data).
is_friend(X,Y):- %Q1
friend(X,Y),!;friend(Y,X).
%___________________________________________________________
friendList(Name,Friends):-  %Q2
    friendcheck(Name,Friends,[]).

friendcheck(Name,Friends,List):-
     if_Frriend(Name,X),
    \+ memberlist(X,List),!,
    friendcheck(Name,Friends,[X|List]).
friendcheck(_,List,List).
%___________________________________________________________

friendListCount(Person,Count):-%Q3
    friendList(Person, Friends) ,
    length_of_list(Friends,Count).

%___________________________________________________________
peopleYouMayKnow(Person,Friend) :- %Q4
     if_Frriend(Person, X),
     if_Frriend(X,Friend),
    \+if_Frriend(Person, Friend),
    Person\==Friend.
%___________________________________________________________
peopleYouMayKnow(Person,N,Result):- %Q5
   friendList(Person,ListMutual),
   peopleSuggest(Person,ListMutual,0,N,Result).
peopleSuggest(Person,[H|T],Count,N,Result):-
    if_Frriend(H,Result),Result\==Person,Newcount is Count+1,
    peopleSuggest(Person,T,Newcount,N,Result),!.
peopleSuggest(_,_,N,N,Result).
%___________________________________________________________
peopleYouMayKnowList(X, Mutual):- %Q6
   mutualcheck(X,[],Mutual).

mutualcheck(X,List,Mutual):-
     mutualFriend(X,L),
    \+ memberlist(L,List),!,
   mutualcheck(X,[L|List],Mutual).
mutualcheck(_,List,List).
%____________________________________________________________
mutualFriend(X,Y):-
  friend(X,Z),
  if_Frriend(Y,Z),
  Y\==X.

memberlist(X,[X|_]).
memberlist(X,[_|Tail]):-
    memberlist(X, Tail).

length_of_list([],0).
length_of_list([_|T],N):-
  length_of_list(T,N1), N is N1 + 1.

if_Frriend(X,Y):-
friend(X,Y);friend(Y,X).

%__________________________________________________________
peopleYouMayKnow_indirect(X,W):- %Bonus
    if_Frriend(X,R),
    if_Frriend(R,Z),
    if_Frriend(W,Z),
   not(if_Frriend(X,W)),
   not(peopleYouMayKnow(X,W)).
