# Movie-Vault
A Python-based movie management system that allows users to manage and interact with a movie database sing PLSQL. This system supports various operations, including adding movies, actors, directors, and genres, assigning actors and directors to movies, adding ratings, and searching for movies based on different criteria.

## Contributors
- Shashank Thakur, U22CS060
- Shubham Waghmare, U22CS044
- Cheedalla Sathvik, U22CS031
- Kambalapally Aryan, U22CS054


## Features

- **Add New Entries**: Movies, actors, directors, and genres.
- **Assign Roles**: Actors and directors to movies.
- **Rate Movies**: Add and update movie ratings.
- **Search Functionality**: Search movies by title, genre, actor, director, and rating range.
- **Display Information**:
  - Top-rated movies.
  - All movies, actors, directors, and genres.

## Requirements

- Python 3.6.3
- `cx_Oracle` library (for Oracle database connection)
- `tabulate` library (for table formatting)

## Usage

1. Replace the `connection` variable with your Oracle database connection details.
2. Run the script using Python:
   ```bash
   python main.py
   ```
3. Follow the menu prompts to perform various operations on the movie database.

## Functions

- **add_new_movie()**: Adds a new movie to the database.
- **add_new_actor()**: Adds a new actor to the database.
- **add_new_director()**: Adds a new director to the database.
- **assign_actor_to_movie()**: Assigns an actor to a movie.
- **assign_director_to_movie()**: Assigns a director to a movie.
- **assign_genre_to_movie()**: Assigns a genre to a movie.
- **add_movie_rating()**: Adds a rating to a movie.
- **display_top_rated_movies()**: Displays the top-rated movies.
- **search_movies_by_title()**: Searches for movies by title.
- **search_movies_by_genre()**: Searches for movies by genre.
- **search_movies_by_actor()**: Searches for movies by actor.
- **search_movies_by_director()**: Searches for movies by director.
- **search_movies_by_rating_range()**: Searches for movies by rating range.
- **display_all_movies()**: Displays all movies.
- **display_all_actors()**: Displays all actors.
- **display_all_directors()**: Displays all directors.
- **display_all_genres()**: Displays all genres.

## Documentation

The documentation .pdf files are in the [docs](docs) folder
