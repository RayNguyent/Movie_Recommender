:- use_module(library(persistency)).
:- use_module(library(csv)).
:- use_module(library(lists)).

:- persistent(db(id:atom, name:atom, year:integer, rating:float, runtime:integer, genre:list(atom), country:list(atom))).

% Initialize database from CSV file
initdb :-
    db_attach('imdb.db', []),
    csv_read_file('IMDB.csv', Rows, []),
    maplist(assert_movie, Rows),
    writeln('Database initialized successfully.').

% Add a movie to the database
assert_movie(Row) :-
    required_columns_filled(Row),
    Row =.. [_, ID, Name, _, Year, _, Genre, Runtime, Country, _, _, _, _, _, _, Rating| _],
    atomic_list_concat(GenreList, ', ', Genre),
    atomic_list_concat(CountryList, ', ', Country),
    assert(db(ID, Name, Year, Rating, Runtime, GenreList, CountryList)).

% Predicate to check if all required columns are filled
required_columns_filled(Row) :-
    Row =.. [_, _, Name, _, Year, _, Genre, Runtime, Country, _, _, _, _, _, _, Rating| _],
    nonvar(Name), nonvar(Year), nonvar(Runtime), nonvar(Country),
    nonvar(Genre), nonvar(Rating).

