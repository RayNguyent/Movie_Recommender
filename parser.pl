:- use_module(library(persistency)).
:- use_module(library(csv)).
:- use_module(library(lists)).

% https://www.kaggle.com/datasets/sharathmudigoudr/imdb-movie-dataset-from-year-1893-to-2020

:- persistent(db(id:atom, name:atom, year:integer, rating:float, runtime:integer, genre:list(atom), country:list(atom))).

% Initialize database from CSV file
initdb :-
    % db_attach('imdb.db', []),
    retractall(db(_, _, _, _, _, _, _)),
    csv_read_file('IMDB.csv', Rows, []),
    maplist(assert_movie, Rows),
    writeln('Database initialized successfully.').

% Add a movie to the database
assert_movie(Row) :-
   required_columns_filled(Row),
    Row =.. [_, ID, Name, Year, Genre, Runtime, Country, Rating| _],
    atomic_list_concat(GenreList, ', ', Genre),
    atomic_list_concat(CountryList, ', ', Country),
    assert(db(ID, Name, Year, GenreList, Runtime, CountryList, Rating)).

% Predicate to check if all required columns are filled
required_columns_filled(Row) :-
    Row =.. [_, _, Name, Year, Genre, Runtime, Country,  Rating| _],
    nonvar(Name), nonvar(Year), nonvar(Runtime), nonvar(Country),
    nonvar(Genre), nonvar(Rating).

