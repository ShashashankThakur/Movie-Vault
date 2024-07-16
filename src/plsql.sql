-- ADDING NEW MOVIES
CREATE OR REPLACE PROCEDURE AddNewMovie AS
    v_Title VARCHAR2(255);
    v_YearOfRelease NUMBER;
    v_Language VARCHAR2(50);
    v_ContentWarning VARCHAR2(255);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the movie title: ');
    DBMS_INPUT.GET_LINE(v_Title);
    
    DBMS_OUTPUT.PUT('Enter the year of release: ');
    DBMS_INPUT.GET_LINE(v_YearOfRelease);
    
    DBMS_OUTPUT.PUT('Enter the language: ');
    DBMS_INPUT.GET_LINE(v_Language);
    
    DBMS_OUTPUT.PUT('Enter content warning: ');
    DBMS_INPUT.GET_LINE(v_ContentWarning);

    -- Insert the user input into the Movie table
    INSERT INTO Movie (MovieID, Title, YearOfRelease, Language, ContentWarning)
    VALUES (Movie_Seq.NEXTVAL, v_Title, v_YearOfRelease, v_Language, v_ContentWarning);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Movie added successfully.');
END AddNewMovie;
/

-- call the procedure
BEGIN
    AddNewMovie;
END;
/



-- ADDING NEW ACTORS
CREATE OR REPLACE PROCEDURE AddNewActor AS
    v_FirstName VARCHAR2(50);
    v_LastName VARCHAR2(50);
    v_DateOfBirth DATE;
    v_Gender VARCHAR2(10);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the actor\'s first name: ');
    DBMS_INPUT.GET_LINE(v_FirstName);
    
    DBMS_OUTPUT.PUT('Enter the actor\'s last name: ');
    DBMS_INPUT.GET_LINE(v_LastName);
    
    DBMS_OUTPUT.PUT('Enter the actor\'s date of birth (YYYY-MM-DD): ');
    DBMS_INPUT.GET_LINE(v_DateOfBirth);
    
    DBMS_OUTPUT.PUT('Enter the actor\'s gender: ');
    DBMS_INPUT.GET_LINE(v_Gender);

    -- Insert the user input into the Actor table
    INSERT INTO Actor (ActorID, FirstName, LastName, DateOfBirth, Gender)
    VALUES (Actor_Seq.NEXTVAL, v_FirstName, v_LastName, TO_DATE(v_DateOfBirth, 'YYYY-MM-DD'), v_Gender);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Actor added successfully.');
END AddNewActor;
/

-- call the procedure
BEGIN
    AddNewActor;
END;
/



-- ADDING NEW DIRECTORS
CREATE OR REPLACE PROCEDURE AddNewDirector AS
    v_FirstName VARCHAR2(50);
    v_LastName VARCHAR2(50);
    v_DateOfBirth DATE;
    v_Gender VARCHAR2(10);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the director\'s first name: ');
    DBMS_INPUT.GET_LINE(v_FirstName);
    
    DBMS_OUTPUT.PUT('Enter the director\'s last name: ');
    DBMS_INPUT.GET_LINE(v_LastName);
    
    DBMS_OUTPUT.PUT('Enter the director\'s date of birth (YYYY-MM-DD): ');
    DBMS_INPUT.GET_LINE(v_DateOfBirth);
    
    DBMS_OUTPUT.PUT('Enter the director\'s gender: ');
    DBMS_INPUT.GET_LINE(v_Gender);

    -- Insert the user input into the Director table
    INSERT INTO Director (DirectorID, FirstName, LastName, DateOfBirth, Gender)
    VALUES (Director_Seq.NEXTVAL, v_FirstName, v_LastName, TO_DATE(v_DateOfBirth, 'YYYY-MM-DD'), v_Gender);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Director added successfully.');
END AddNewDirector;
/

-- call the procedure
BEGIN
    AddNewDirector;
END;
/



-- ASSIGNING ACTORS TO A MOVIE WITH ROLE
CREATE OR REPLACE PROCEDURE AssignActorToMovie AS
    v_MovieID NUMBER;
    v_ActorID NUMBER;
    v_Role VARCHAR2(100);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the MovieID: ');
    DBMS_INPUT.GET_LINE(v_MovieID);
    
    DBMS_OUTPUT.PUT('Enter the ActorID: ');
    DBMS_INPUT.GET_LINE(v_ActorID);
    
    DBMS_OUTPUT.PUT('Enter the role of the actor in the movie: ');
    DBMS_INPUT.GET_LINE(v_Role);

    -- Insert the user input into the MovieActor table
    INSERT INTO MovieActor (MovieID, ActorID, Role)
    VALUES (v_MovieID, v_ActorID, v_Role);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Actor assigned to the movie successfully.');
END AssignActorToMovie;
/

-- call the procedure
BEGIN
    AssignActorToMovie;
END;
/



-- ASSIGNING A DIRECTOR TO A MOVIE
CREATE OR REPLACE PROCEDURE AssignDirectorToMovie AS
    v_MovieID NUMBER;
    v_DirectorID NUMBER;
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the MovieID: ');
    DBMS_INPUT.GET_LINE(v_MovieID);
    
    DBMS_OUTPUT.PUT('Enter the DirectorID: ');
    DBMS_INPUT.GET_LINE(v_DirectorID);

    -- Insert the user input into the MovieDirector table
    INSERT INTO MovieDirector (MovieID, DirectorID)
    VALUES (v_MovieID, v_DirectorID);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Director assigned to the movie successfully.');
END AssignDirectorToMovie;
/

-- call the procedure
BEGIN
    AssignDirectorToMovie;
END;
/



-- ASSIGNING GENRE TO MOVIE
CREATE OR REPLACE PROCEDURE AssignGenresToMovie AS
    v_MovieID NUMBER;
    v_GenreID NUMBER;
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the MovieID: ');
    DBMS_INPUT.GET_LINE(v_MovieID);
    
    DBMS_OUTPUT.PUT('Enter the GenreID: ');
    DBMS_INPUT.GET_LINE(v_GenreID);

    -- Insert the user input into the MovieGenre table
    INSERT INTO MovieGenre (MovieID, GenreID)
    VALUES (v_MovieID, v_GenreID);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Genre assigned to the movie successfully.');
END AssignGenresToMovie;
/

-- call the procedure
BEGIN
    AssignGenresToMovie;
END;
/



-- ADDING A RATING TO A MOVIE
CREATE OR REPLACE PROCEDURE AddMovieRating(
    p_MovieID IN NUMBER,
    p_NewRating IN NUMBER
) AS
    v_CurrentRating NUMBER;
    v_CurrentNumRatings NUMBER;
BEGIN
    -- Get the current rating and number of ratings for the movie
    SELECT Rating, NumberOfRatings
    INTO v_CurrentRating, v_CurrentNumRatings
    FROM Movie
    WHERE MovieID = p_MovieID;

    -- Calculate the new average rating
    v_CurrentRating := ((v_CurrentRating * v_CurrentNumRatings) + p_NewRating) / (v_CurrentNumRatings + 1);

    -- Update the movie's attributes
    UPDATE Movie
    SET Rating = v_CurrentRating,
        NumberOfRatings = v_CurrentNumRatings + 1
    WHERE MovieID = p_MovieID;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Movie with MovieID ' || p_MovieID || ' not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

-- call the procedure
BEGIN
    AddMovieRating;
END;
/



-- DISPLAYING THE TOP FEW BEST RATED MOVIES
CREATE OR REPLACE PROCEDURE DisplayTopRatedMovies AS
    v_NumMovies NUMBER;
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the number of top-rated movies to display: ');
    DBMS_INPUT.GET_LINE(v_NumMovies);

    FOR movie_rec IN (SELECT *
                      FROM Movie
                      ORDER BY Rating DESC
                      FETCH FIRST v_NumMovies ROWS ONLY)
    LOOP
        DBMS_OUTPUT.PUT_LINE('MovieID: ' || movie_rec.MovieID || ', Title: ' || movie_rec.Title || ', Rating: ' || movie_rec.Rating);
    END LOOP;
END DisplayTopRatedMovies;
/

-- call the procedure
BEGIN
    DisplayTopRatedMovies;
END;
/



-- SEARCH MOVIE BY TITLE
CREATE OR REPLACE PROCEDURE SearchMoviesByTitle AS
    v_Title VARCHAR2(255);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the movie title to search for: ');
    DBMS_INPUT.GET_LINE(v_Title);
    
    FOR movie_rec IN (SELECT *
                      FROM Movie
                      WHERE UPPER(Title) LIKE '%' || UPPER(v_Title) || '%')
    LOOP
        DBMS_OUTPUT.PUT_LINE('MovieID: ' || movie_rec.MovieID || ', Title: ' || movie_rec.Title);
    END LOOP;
END SearchMoviesByTitle;
/

-- call the procedure
BEGIN
    SearchMoviesByTitle;
END;
/



-- SEARCH MOVIE BY GENRE
CREATE OR REPLACE PROCEDURE SearchMoviesByGenre AS
    v_GenreName VARCHAR2(255);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the genre name to search for: ');
    DBMS_INPUT.GET_LINE(v_GenreName);
    
    FOR movie_rec IN (SELECT m.*
                      FROM Movie m
                      JOIN MovieGenre mg ON m.MovieID = mg.MovieID
                      JOIN Genre g ON mg.GenreID = g.GenreID
                      WHERE UPPER(g.Name) LIKE '%' || UPPER(v_GenreName) || '%')
    LOOP
        DBMS_OUTPUT.PUT_LINE('MovieID: ' || movie_rec.MovieID || ', Title: ' || movie_rec.Title);
    END LOOP;
END SearchMoviesByGenre;
/

-- call the procedure
BEGIN
    SearchMoviesByGenre;
END;
/



-- SEARCH MOVIE BY ACTOR
CREATE OR REPLACE PROCEDURE SearchMoviesByActor AS
    v_ActorName VARCHAR2(255);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the actor name to search for: ');
    DBMS_INPUT.GET_LINE(v_ActorName);
    
    FOR movie_rec IN (SELECT m.*
                      FROM Movie m
                      JOIN MovieActor ma ON m.MovieID = ma.MovieID
                      JOIN Actor a ON ma.ActorID = a.ActorID
                      WHERE UPPER(a.FirstName) LIKE '%' || UPPER(v_ActorName) || '%' OR
                            UPPER(a.LastName) LIKE '%' || UPPER(v_ActorName) || '%')
    LOOP
        DBMS_OUTPUT.PUT_LINE('MovieID: ' || movie_rec.MovieID || ', Title: ' || movie_rec.Title);
    END LOOP;
END SearchMoviesByActor;
/

-- call the procedure
BEGIN
    SearchMoviesByActor;
END;
/



-- SEARCH MOVIE BY DIRECTOR
CREATE OR REPLACE PROCEDURE SearchMoviesByDirector AS
    v_DirectorName VARCHAR2(255);
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the director name to search for: ');
    DBMS_INPUT.GET_LINE(v_DirectorName);
    
    FOR movie_rec IN (SELECT m.*
                      FROM Movie m
                      JOIN MovieDirector md ON m.MovieID = md.MovieID
                      JOIN Director d ON md.DirectorID = d.DirectorID
                      WHERE UPPER(d.FirstName) LIKE '%' || UPPER(v_DirectorName) || '%' OR
                            UPPER(d.LastName) LIKE '%' || UPPER(v_DirectorName) || '%')
    LOOP
        DBMS_OUTPUT.PUT_LINE('MovieID: ' || movie_rec.MovieID || ', Title: ' || movie_rec.Title);
    END LOOP;
END SearchMoviesByDirector;
/

-- call the procedure
BEGIN
    SearchMoviesByDirector;
END;
/



-- SEARCH MOVIE BY RATING RANGE
CREATE OR REPLACE PROCEDURE SearchMoviesByRatingRange AS
    v_MinRating NUMBER;
    v_MaxRating NUMBER;
BEGIN
    -- Prompt the user for input
    DBMS_OUTPUT.PUT('Enter the minimum rating: ');
    DBMS_INPUT.GET_LINE(v_MinRating);
    
    DBMS_OUTPUT.PUT('Enter the maximum rating: ');
    DBMS_INPUT.GET_LINE(v_MaxRating);
    
    FOR movie_rec IN (SELECT *
                      FROM Movie
                      WHERE Rating BETWEEN v_MinRating AND v_MaxRating)
    LOOP
        DBMS_OUTPUT.PUT_LINE('MovieID: ' || movie_rec.MovieID || ', Title: ' || movie_rec.Title);
    END LOOP;
END SearchMoviesByRatingRange;
/

-- call the procedure
BEGIN
    SearchMoviesByRatingRange;
END;
/


-- TRIGGERS



-- Trigger to delete director and corresponding director
CREATE OR REPLACE TRIGGER delete_movies_after_director_delete
AFTER DELETE ON Director
FOR EACH ROW
BEGIN
    -- delete from movie-director table
    DELETE FROM MovieDirector WHERE DirectorID = :OLD.DirectorID;
    
    -- delete from movie table
    DELETE FROM Movie WHERE MovieID IN (SELECT MovieID FROM MovieDirector WHERE DirectorID = :OLD.DirectorID);
END;
/


-- trigger to delete relation after deletion of genre
CREATE OR REPLACE TRIGGER delete_moviegenre_after_genre_delete
AFTER DELETE ON Genre
FOR EACH ROW
BEGIN
    -- delete from movie-genre table
    DELETE FROM MovieGenre WHERE GenreID = :OLD.GenreID;
END;
/

