:- [parser].

main :- 
    writeln('Cooking the database, how are you doing today!'),
    initdb,
    consult.

consult:-
    nl,
    write('Welcome young padawan, this is chatIMDB 4.0! Do you already have a movie in your mind?'), nl,
    q_time, nl,
    read(Ans1), nl,
    q_genre, nl,
    read(Ans2), nl,
    q_duration, nl,
    read(Ans3),nl,
    q_country, nl,
    read(Ans4),nl,
    q_rating(Ans5), nl,
    
    % write('How about these:'), nl,
    forall(limit(5, distinct(recommend(Ans1, Ans2, Ans3, Ans4, Ans5, Output))), writeln(Output)).

recommend(Ans1, Genres, Ans3, Ans4, Ans5, Name) :- 
    db(ID, Name, _, _, _, _, _),
    search_q_time(Ans1, ID), 
    search_q_genres(Genres, ID),
    search_q_duration(Ans3, ID),
    search_q_country(Ans4, ID),
    search_q_rating(Ans5, ID). 

% Ask about time preference
q_time :- 
    write('Are you feeling old today?'), nl,
    write("1. Yes"),nl,
    write("2. No"),nl,
    write("0. Anything goes"). 

% q_genre
q_genre :-
    write('Got any genres in mind? Enter your preferred genres separated by commas: '), nl,
    write("1. Action"),nl,
    write("2. Comedy"),nl,
    write("3. Drama"),nl,
    write("4. Romance"),nl,
    write("5. History"),nl,
    write("6. Horror"),nl,
    write("7. Animation"),nl,
    write("8. Mystery"),nl,
    write("9. Crime"),nl,
    write("0. Anything goes"). 

% q_rating
q_rating(Rating) :-
    write('What kind of rating are you looking for?'), nl,
    write('Enter a number between 1 and 10: '),
    read(Ans),
    validate_rating(Ans, Rating).

% q_country
q_country :-
    write('Where would you like your movie to have been produced?'), nl,
    write("1. USA"),nl,
    write("2. France"),nl,
    write("3. Canada"),nl,
    write("4. India"),nl,
    write("5. Japan"),nl,
    write("6. Russia"),nl,
    write("7. UK"),nl,
    write("8. Germany"),nl,
    write("9. Sweden"),nl,
    write("0. Anything goes"). 

% q_duration
q_duration :-
    write('Would you like a movie so long that youre growing roots by the time its finished?'), nl,
    write("1. Yes"),nl,
    write("2. No"),nl,
    write("0. Whatever works"). 

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

% Query such that duration is either shorter or longer than 2h depending on user preference
search_q_duration(0,_).
search_q_duration(1,ID):-
    db(ID, _,_,_,Duration,_,_),
    Duration >= 120.
search_q_duration(2,ID):-
    db(ID, _,_,_,Duration,_,_),
    Duration < 120.

% Query such that ratings found are within users provided range (R + 1)
search_q_rating(R,ID) :-
    db(ID, _, _, _, _, _, Rating),
    Rating >= R,
    Rating < R + 1.

% Match selected value with genre and query the database
search_q_genres(0, _).
search_q_genres(1, ID) :- db(ID, _, _, Genres, _, _, _), member('Action', Genres).
search_q_genres(2, ID) :- db(ID, _, _, Genres, _, _, _), member('Comedy', Genres).
search_q_genres(3, ID) :- db(ID, _, _, Genres, _, _, _), member('Drama', Genres).
search_q_genres(4, ID) :- db(ID, _, _, Genres, _, _, _), member('Romance', Genres).
search_q_genres(5, ID) :- db(ID, _, _, Genres, _, _, _), member('History', Genres).
search_q_genres(6, ID) :- db(ID, _, _, Genres, _, _, _), member('Horror', Genres).
search_q_genres(7, ID) :- db(ID, _, _, Genres, _, _, _), member('Animation', Genres).
search_q_genres(8, ID) :- db(ID, _, _, Genres, _, _, _), member('Mystery', Genres).
search_q_genres(9, ID) :- db(ID, _, _, Genres, _, _, _), member('Crime', Genres).

% Match selected value with country and query the database
search_q_country(0, _).
search_q_country(1, ID) :- db(ID, _, _, _, _, Country, _), member('USA', Country).
search_q_country(2, ID) :- db(ID, _, _, _, _, Country, _), member('France', Country).
search_q_country(3, ID) :- db(ID, _, _, _, _, Country, _), member('Canada', Country).
search_q_country(4, ID) :- db(ID, _, _, _, _, Country, _), member('India', Country).
search_q_country(5, ID) :- db(ID, _, _, _, _, Country, _), member('Japan', Country).
search_q_country(6, ID) :- db(ID, _, _, _, _, Country, _), member('Russia', Country).
search_q_country(7, ID) :- db(ID, _, _, _, _, Country, _), member('UK', Country).
search_q_country(8, ID) :- db(ID, _, _, _, _, Country, _), member('Germany', Country).
search_q_country(9, ID) :- db(ID, _, _, _, _, Country, _), member('Sweden', Country).

% Check that provided rating is a valid number between 1 and 10.
validate_rating(Ans, ValidRating) :-
    integer(Ans),
    Ans >= 1,
    Ans =< 10,
    ValidRating = Ans.
validate_rating(_, ValidRating) :-
    write('Invalid input. Please enter a number between 1 and 10: '),
    read(NewAns),
    validate_rating(NewAns, ValidRating).

