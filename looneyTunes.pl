:-dynamic assegure/1.
:-dynamic verifique/1.

carregar:-
	open('teste.txt', append, S), write(S,''),close(S),
	['teste.txt'].

go :- carregar,
      write('Vou tentar adivinhar o nome do seu personagem da Looney Tunes! '),nl,nl,
      verifique(Personagem),
      write('Eu acho que é: '),
      write(Personagem),
      nl,
      undo;
      perguntar,
      undo.

perguntar :- 
	write('Ok, você venceu...\nQual o nome do seu personagem?'),nl,
	read(Personagem),
	write('Qual é a característica marcante do seu personagem?'),nl,
	read(Caracteristica),
	append('teste.txt'),
	write(verifique(Personagem):-(Personagem,!)),write('.\n'),
	write(Personagem),write(' :- '),
	lista_caracteristicas,
	write('assegure'),write('(\''),write(Caracteristica),write('\')'),write('.\n'),
	told.

lista_caracteristicas :- findall(yes(X),yes(X),C), lista_caracteristicas(C).
lista_caracteristicas([H]) :- pega_argumento(H,A),write('assegure'),write('(\''),write(A),write('\'),'),nl.
lista_caracteristicas([H|T]) :- pega_argumento(H,A),write('assegure'),write('(\''),write(A),write('\'),'),nl,lista_caracteristicas(T).
pega_argumento(yes(X),X).

/* how to ask questions */
ask(Question) :-
    write('O seu personagem '),
    write(Question),
    write(' ?\n'),
    read(Response),
    nl,
    ( (Response == sim ; Response == s)
      ->
       assert(yes(Question));
       assert(no(Question)),fail).

:- dynamic yes/1,no/1.

/* How to assegure something */
assegure(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).

/* undo all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.
