-- Create the Movie table
CREATE TABLE Movie (
    MovieID NUMBER PRIMARY KEY,
    Title VARCHAR2(255),
    YearOfRelease NUMBER,
    NumberOfRatings NUMBER,
    Rating NUMBER,
    Language VARCHAR2(50),
    ContentWarning VARCHAR2(255)
);

SELECT * FROM Movie;



-- Create the Genre table
CREATE TABLE Genre (
    GenreID NUMBER PRIMARY KEY,
    Name VARCHAR2(100)
);

SELECT * FROM Genre;



-- Create the Actor table
CREATE TABLE Actor (
    ActorID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    DateOfBirth DATE,
    Gender VARCHAR2(10)
);

SELECT * FROM Actor;



-- Create the Director table
CREATE TABLE Director (
    DirectorID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    DateOfBirth DATE,
    Gender VARCHAR2(10)
);

SELECT * FROM Director;



-- Create the MovieGenre table to represent the many-to-many relationship
CREATE TABLE MovieGenre (
    MovieID NUMBER,
    GenreID NUMBER,
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)
);

SELECT * FROM MovieGenre;



-- Create the MovieActor table to represent the many-to-many relationship
CREATE TABLE MovieActor (
    MovieID NUMBER,
    ActorID NUMBER,
    Role VARCHAR2(100),
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    FOREIGN KEY (ActorID) REFERENCES Actor(ActorID)
);

SELECT * FROM MovieActor;



-- Create the MovieDirector table to represent the many-to-many relationship
CREATE TABLE MovieDirector (
    MovieID NUMBER,
    DirectorID NUMBER,
    FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
    FOREIGN KEY (DirectorID) REFERENCES Director(DirectorID)
);

SELECT * FROM MovieDirector;
