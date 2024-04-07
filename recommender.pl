:- [parser].

main :- 
    writeln('Cooking the database, how are you doing today!'),
    initdb,
    consult.

consult:-
    nl,
    write('Welcome young padawan, this is chatIMDB 4.0! Do you already have a movie in your mind?'), nl,
    q_time, nl,
    read(Ans1),nl,
    % q_genre, nl,
    % read(Ans2),nl,
    % q_duration, nl,
    % read(Ans3),nl,
    % q_country, nl,
    % read(Ans4),nl,
    % q_rating,nl,
    % read(Ans5),nl,
    % write('How about these:'), nl,
    % forall(limit(5, distinct(recommend(Ans1, Ans2, Ans3, Ans4, Ans5, Output))), writeln(Output)).
    forall(limit(5, distinct(recommend(Ans1, Output))), writeln(Output)).

% recommend(Ans1, Ans2, Ans3, Ans4, Ans5, Name) :-
recommend(Ans1, Name) :- 
    db(ID, Name, _, _, _, _,_),
    search_q_time(Ans1, ID).
    % search_q_genre(Ans2),
    % search_q_duration(Ans3),
    % search_q_country(Ans4),
    % search_q_rating(Ans5). 

% Ask about time preference
q_time :- 
    write('Are you feeling old today?'), nl,
    write("1. Yes"),nl,
    write("2. No"),nl,
    write("0. Anything goes"). 

% q_genre

% q_rate

% q_country

% q_duration


% Search the movie based on q_time response
search_q_time(0,_).
search_q_time(1,ID):-
    db(ID, _, Year, _, _, _, _),
    Year < 1995.
search_q_time(2,ID):-
    db(ID, _, Year, _, _, _, _),
    Year >= 1995.
% search_q_time(Op) :- not( member(Op, [0, 1, 2]) ). 
% search_q_time(R) :- 
%    \+ member(R, [0, 1, 2]), % Check if Op is not 0, 1, or 2,
%   writeln('Invalid input for response. Please enter 0, 1, or 2.'),
 %   read(newResponse),
 %   search_q_time(newResponse). % Recursively call search_q_time with the new response
