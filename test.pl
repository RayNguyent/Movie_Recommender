:- [parser].

initdb.

% Test if a movie from the year 1990 exists in the database and print its name
test_movie_from_1990_and_print_name :-
    db_attached('imdb.db'),  % Check if the database is attached
    db(_, Name, 1990, _, _, _, _), % Find a movie with the year 1990
    writeln('A movie from the year 1990 exists in the database:'),
    writeln(Name),  % Print the name of the movie
    writeln('Test passed.').

% Entry point for testing
test :-
    test_movie_from_1990_and_print_name.