import cx_Oracle
from tabulate import tabulate

# Replace with your Oracle database connection details
connection = cx_Oracle.connect("SYS/YourConnectionDetails@localhost:1521/xe", mode=cx_Oracle.SYSDBA)


def execute_sql(sql):
    cursor = connection.cursor()
    cursor.execute(sql)
    connection.commit()
    cursor.close()


def add_new_movie():
    v_ID = int(input("\n\nEnter the movie ID: "))
    v_Title = input("Enter the movie title: ")
    v_YearOfRelease = int(input("Enter the year of release: "))
    v_Language = input("Enter the language: ")
    v_ContentWarning = input("Enter content warning: ")

    sql = f"""
    INSERT INTO Movie (MovieID, Title, YearOfRelease, Language, ContentWarning)
    VALUES ({v_ID}, '{v_Title}', {v_YearOfRelease}, '{v_Language}', '{v_ContentWarning}')
    """
    execute_sql(sql)

    print("\n\nMovie added successfully.\n\n")


def add_new_actor():
    v_ID = int(input("\n\nEnter the actor's ID: "))
    v_FirstName = input("Enter the actor's first name: ")
    v_LastName = input("Enter the actor's last name: ")
    v_DateOfBirth = input("Enter the actor's date of birth (YYYY-MM-DD): ")
    v_Gender = input("Enter the actor's gender: ")

    sql = f"""
    INSERT INTO Actor (ActorID, FirstName, LastName, DateOfBirth, Gender)
    VALUES ({v_ID}, '{v_FirstName}', '{v_LastName}', TO_DATE('{v_DateOfBirth}', 'YYYY-MM-DD'), '{v_Gender}')
    """
    execute_sql(sql)

    print("\n\nActor added successfully.\n\n")


def add_new_director():
    v_ID = int(input("\n\nEnter the director's ID: "))
    v_FirstName = input("Enter the director's first name: ")
    v_LastName = input("Enter the director's last name: ")
    v_DateOfBirth = input("Enter the director's date of birth (YYYY-MM-DD): ")
    v_Gender = input("Enter the director's gender: ")

    sql = f"""
    INSERT INTO Director (DirectorID, FirstName, LastName, DateOfBirth, Gender)
    VALUES ({v_ID}, '{v_FirstName}', '{v_LastName}', TO_DATE('{v_DateOfBirth}', 'YYYY-MM-DD'), '{v_Gender}')
    """
    execute_sql(sql)

    print("\n\nDirector added successfully.\n\n")


def assign_actor_to_movie():
    v_MovieID = int(input("\n\nEnter the MovieID: "))
    v_ActorID = int(input("Enter the ActorID: "))
    v_Role = input("Enter the role of the actor in the movie: ")

    sql = f"""
    INSERT INTO MovieActor (MovieID, ActorID, Role)
    VALUES ({v_MovieID}, {v_ActorID}, '{v_Role}')
    """
    execute_sql(sql)

    print("\n\nActor assigned to the movie successfully.\n\n")


def assign_director_to_movie():
    v_MovieID = int(input("\n\nEnter the MovieID: "))
    v_DirectorID = int(input("Enter the DirectorID: "))

    sql = f"""
    INSERT INTO MovieDirector (MovieID, DirectorID)
    VALUES ({v_MovieID}, {v_DirectorID})
    """
    execute_sql(sql)

    print("\n\nDirector assigned to the movie successfully.\n\n")


def assign_genre_to_movie():
    v_MovieID = int(input("\n\nEnter the MovieID: "))
    v_GenreID = int(input("Enter the GenreID: "))

    sql = f"""
    INSERT INTO MovieGenre (MovieID, GenreID)
    VALUES ({v_MovieID}, {v_GenreID})
    """
    execute_sql(sql)

    print("\n\nGenre assigned to the movie successfully.\n\n")


def add_movie_rating():
    v_MovieID = int(input("\n\nEnter MovieID for rating: "))
    v_NewRating = float(input("Enter the new rating: "))

    cursor = connection.cursor()
    cursor.execute(f"SELECT Rating, NumberOfRatings FROM Movie WHERE MovieID = {v_MovieID}")
    row = cursor.fetchone()

    if row:
        current_rating, current_num_ratings = row
        if current_rating is not None and current_num_ratings is not None:
            new_avg_rating = ((current_rating * current_num_ratings) + v_NewRating) / (current_num_ratings + 1)
        else:
            # If current_rating or current_num_ratings is None, set new_avg_rating to v_NewRating
            new_avg_rating = v_NewRating
            current_num_ratings = 1  # Set the number of ratings to 1

        cursor.execute(f"UPDATE Movie SET Rating = {new_avg_rating}, NumberOfRatings = {current_num_ratings} WHERE MovieID = {v_MovieID}")
        connection.commit()
        cursor.close()
        print("\n\nRating added successfully.")
    else:
        cursor.close()
        print(f"\n\nMovie with MovieID {v_MovieID} not found.")


def display_top_rated_movies():
    v_NumMovies = int(input("\n\nEnter the number of top-rated movies to display: "))

    cursor = connection.cursor()
    cursor.execute(f"SELECT MovieID, Title, Rating FROM Movie ORDER BY Rating DESC FETCH FIRST {v_NumMovies} ROWS ONLY")

    movie_data = []
    for row in cursor:
        movie_data.append([row[0], row[1], row[2]])
    cursor.close()

    headers = ["MovieID", "Title", "Rating"]
    table = tabulate(movie_data, headers, tablefmt="pretty")

    print("\n\nTop Rated Movies:")
    print(table)


def search_movies_by_title():
    v_Title = input("\n\nEnter the movie title to search for: ")

    cursor = connection.cursor()
    cursor.execute(f"SELECT MovieID, Title FROM Movie WHERE UPPER(Title) LIKE '%' || UPPER('{v_Title}') || '%'")

    movie_data = []
    for row in cursor:
        movie_data.append([row[0], row[1]])

    headers = ["MovieID", "Title"]
    table = tabulate(movie_data, headers, tablefmt="pretty")

    print("\nMovies matching the title:")
    print(table)


def search_movies_by_genre():
    v_GenreName = input("\n\nEnter the genre name to search for: ")

    cursor = connection.cursor()
    cursor.execute(f"""
    SELECT m.MovieID, m.Title
    FROM Movie m
    JOIN MovieGenre mg ON m.MovieID = mg.MovieID
    JOIN Genre g ON mg.GenreID = g.GenreID
    WHERE UPPER(g.Name) LIKE '%' || UPPER('{v_GenreName}') || '%'
    """)

    movie_data = []
    for row in cursor:
        movie_data.append([row[0], row[1]])

    headers = ["MovieID", "Title"]
    table = tabulate(movie_data, headers, tablefmt="pretty")

    print("\nMovies matching the genre:")
    print(table)


def search_movies_by_actor():
    v_ActorName = input("\n\nEnter the actor name to search for: ")

    cursor = connection.cursor()
    cursor.execute(f"""
    SELECT m.MovieID, m.Title
    FROM Movie m
    JOIN MovieActor ma ON m.MovieID = ma.MovieID
    JOIN Actor a ON ma.ActorID = a.ActorID
    WHERE UPPER(a.FirstName) LIKE '%' || UPPER('{v_ActorName}') || '%' OR
          UPPER(a.LastName) LIKE '%' || UPPER('{v_ActorName}') || '%'
    """)

    movie_data = []
    for row in cursor:
        movie_data.append([row[0], row[1]])

    headers = ["MovieID", "Title"]
    table = tabulate(movie_data, headers, tablefmt="pretty")

    print("\nMovies matching the actor:")
    print(table)


def search_movies_by_director():
    v_DirectorName = input("\n\nEnter the director name to search for: ")

    cursor = connection.cursor()
    cursor.execute(f"""
    SELECT m.MovieID, m.Title
    FROM Movie m
    JOIN MovieDirector md ON m.MovieID = md.MovieID
    JOIN Director d ON md.DirectorID = d.DirectorID
    WHERE UPPER(d.FirstName) LIKE '%' || UPPER('{v_DirectorName}') || '%' OR
          UPPER(d.LastName) LIKE '%' || UPPER('{v_DirectorName}') || '%'
    """)

    movie_data = []
    for row in cursor:
        movie_data.append([row[0], row[1]])

    headers = ["MovieID", "Title"]
    table = tabulate(movie_data, headers, tablefmt="pretty")

    print("\nMovies matching the director:")
    print(table)


def search_movies_by_rating_range():
    v_MinRating = float(input("\n\nEnter the minimum rating: "))
    v_MaxRating = float(input("Enter the maximum rating: "))

    cursor = connection.cursor()
    cursor.execute(f"""
    SELECT MovieID, Title, Rating
    FROM Movie
    WHERE Rating BETWEEN {v_MinRating} AND {v_MaxRating}
    """)

    movie_data = []
    for row in cursor:
        movie_data.append([row[0], row[1], row[2]])

    headers = ["MovieID", "Title", "Rating"]
    table = tabulate(movie_data, headers, tablefmt="pretty")

    print("\nMovies in the specified rating range:")
    print(table)


def display_all_movies():
    cursor = connection.cursor()
    try:
        cursor.execute("SELECT * FROM Movie")
        rows = cursor.fetchall()

        if not rows:
            print("No movies found.")
        else:
            headers = [i[0] for i in cursor.description]
            table = tabulate(rows, headers, tablefmt="pretty")
            print("\n\nAll Movies:")
            print(table)
    finally:
        cursor.close()


def display_all_actors():
    cursor = connection.cursor()
    try:
        cursor.execute("SELECT * FROM Actor")
        rows = cursor.fetchall()

        if not rows:
            print("No actors found.")
        else:
            headers = [i[0] for i in cursor.description]
            table = tabulate(rows, headers, tablefmt="pretty")
            print("\n\nAll Actors:")
            print(table)
    finally:
        cursor.close()


def display_all_directors():
    cursor = connection.cursor()
    try:
        cursor.execute("SELECT * FROM Director")
        rows = cursor.fetchall()

        if not rows:
            print("No directors found.")
        else:
            headers = [i[0] for i in cursor.description]
            table = tabulate(rows, headers, tablefmt="pretty")
            print("\n\nAll Directors:")
            print(table)
    finally:
        cursor.close()


def display_all_genres():
    cursor = connection.cursor()
    try:
        cursor.execute("SELECT * FROM Genre")
        rows = cursor.fetchall()

        if not rows:
            print("No genres found.")
        else:
            headers = [i[0] for i in cursor.description]
            table = tabulate(rows, headers, tablefmt="pretty")
            print("\n\nAll Genres:")
            print(table)
    finally:
        cursor.close()


def main_menu():
    while True:
        options = [
            [1, "Add New Movie"],
            [2, "Add New Actor"],
            [3, "Add New Director"],
            [4, "Assign Actor to Movie"],
            [5, "Assign Director to Movie"],
            [6, "Assign Genre to Movie"],
            [7, "Add Movie Rating"],
            [8, "Display Top Rated Movies"],
            [9, "Search Movies by Title"],
            [10, "Search Movies by Genre"],
            [11, "Search Movies by Actor"],
            [12, "Search Movies by Director"],
            [13, "Search Movies by Rating Range"],
            [14, "Display all Movies"],
            [15, "Display all Actors"],
            [16, "Display all Directors"],
            [17, "Display all Genres"],
            [0, "Exit"]
        ]

        headers = ["Option", "Action"]
        table = tabulate(options, headers, tablefmt="pretty", colalign=("left", "left"))
        print(table)

        choice = input("\nEnter your choice: ")

        if choice == "1":
            add_new_movie()
        elif choice == "2":
            add_new_actor()
        elif choice == "3":
            add_new_director()
        elif choice == "4":
            assign_actor_to_movie()
        elif choice == "5":
            assign_director_to_movie()
        elif choice == "6":
            assign_genre_to_movie()
        elif choice == "7":
            add_movie_rating()
        elif choice == "8":
            display_top_rated_movies()
        elif choice == "9":
            search_movies_by_title()
        elif choice == "10":
            search_movies_by_genre()
        elif choice == "11":
            search_movies_by_actor()
        elif choice == "12":
            search_movies_by_director()
        elif choice == "13":
            search_movies_by_rating_range()
        elif choice == "14":
            display_all_movies()
        elif choice == "15":
            display_all_actors()
        elif choice == "16":
            display_all_directors()
        elif choice == "17":
            display_all_genres()
        elif choice == "0":
            break
        else:
            print("Invalid choice. Please select a valid option.")


if __name__ == "__main__":
    main_menu()

# Close the database connection
connection.close()
