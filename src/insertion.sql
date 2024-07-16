-- Insert data into the Movie table
INSERT INTO Movie (MovieID, Title, YearOfRelease, NumberOfRatings, Rating, Language, ContentWarning)
VALUES
(1, 'The Shawshank Redemption', 1994, 8900, 9.3, 'English', 'Violence'),
(2, 'The Godfather', 1972, 8000, 9.2, 'English', 'Violence'),
(3, 'Pulp Fiction', 1994, 7600, 8.9, 'English', 'Strong Language'),
(4, 'The Dark Knight', 2008, 9200, 9, 'English', 'Violence'),
(5, 'Forrest Gump', 1994, 7800, 8.8, 'English', 'None'),
(6, 'The Matrix', 1999, 7500, 8.7, 'English', 'Violence'),
(7, 'Inception', 2010, 8700, 8.8, 'English', 'None'),
(8, 'The Lord of the Rings: The Fellowship of the Ring', 2001, 9200, 8.8, 'English', 'Fantasy Violence'),
(9, 'Titanic', 1997, 9300, 7.8, 'English', 'Nudity'),
(10, 'The Silence of the Lambs', 1991, 7400, 8.6, 'English', 'Violence'),
(11, 'The Avengers', 2012, 8500, 8, 'English', 'Action Violence'),
(16, 'Shutter Island', 2010, 1, 8.2, 'English', 'Nudity'),
(12, 'Interstellar', 2014, 9100, 8.6, 'English', 'None'),
(13, 'Gladiator', 2000, 8200, 8.5, 'English', 'Violence'),
(14, 'The Social Network', 2010, 7600, 7.7, 'English', 'Strong Language'),
(15, 'Avatar', 2009, 9500, 7.8, 'English', 'Violence');


-- Insert data into the Director table
INSERT INTO Director (DirectorID, FirstName, LastName, DateOfBirth, Gender)
VALUES
(1, 'Frank', 'Darabont', TO_DATE('28-JAN-59', 'DD-MON-YY'), 'Male'),
(2, 'Francis Ford', 'Coppola', TO_DATE('07-APR-39', 'DD-MON-YY'), 'Male'),
(3, 'Quentin', 'Tarantino', TO_DATE('27-MAR-63', 'DD-MON-YY'), 'Male'),
(4, 'Christopher', 'Nolan', TO_DATE('30-JUL-70', 'DD-MON-YY'), 'Male'),
(5, 'Robert', 'Zemeckis', TO_DATE('14-MAY-51', 'DD-MON-YY'), 'Male'),
(6, 'Lana', 'Wachowski', TO_DATE('21-JUN-65', 'DD-MON-YY'), 'Female'),
(13, 'Martin', 'Scorsese', TO_DATE('17-NOV-42', 'DD-MON-YY'), 'Male'),
(7, 'Peter', 'Jackson', TO_DATE('31-OCT-61', 'DD-MON-YY'), 'Male'),
(8, 'James', 'Cameron', TO_DATE('16-AUG-54', 'DD-MON-YY'), 'Male'),
(9, 'Jonathan', 'Demme', TO_DATE('22-FEB-44', 'DD-MON-YY'), 'Male');


-- Insert data into the Actor table
INSERT INTO Actor (ActorID, FirstName, LastName, DateOfBirth, Gender)
VALUES
(1, 'Morgan', 'Freeman', TO_DATE('01-JUN-37', 'DD-MON-YY'), 'Male'),
(2, 'Marlon', 'Brando', TO_DATE('03-APR-24', 'DD-MON-YY'), 'Male'),
(3, 'John', 'Travolta', TO_DATE('18-FEB-54', 'DD-MON-YY'), 'Male'),
(4, 'Heath', 'Ledger', TO_DATE('04-APR-79', 'DD-MON-YY'), 'Male'),
(5, 'Tom', 'Hanks', TO_DATE('09-JUL-56', 'DD-MON-YY'), 'Male'),
(6, 'Keanu', 'Reeves', TO_DATE('02-SEP-64', 'DD-MON-YY'), 'Male'),
(7, 'Leonardo', 'DiCaprio', TO_DATE('11-NOV-74', 'DD-MON-YY'), 'Male'),
(8, 'Elijah', 'Wood', TO_DATE('28-JAN-81', 'DD-MON-YY'), 'Male'),
(9, 'Jodie', 'Foster', TO_DATE('19-NOV-62', 'DD-MON-YY'), 'Female'),
(10, 'Robert', 'Downey Jr.', TO_DATE('04-APR-65', 'DD-MON-YY'), 'Male'),
(11, 'Matthew', 'McConaughey', TO_DATE('04-NOV-69', 'DD-MON-YY'), 'Male'),
(12, 'Russell', 'Crowe', TO_DATE('07-APR-64', 'DD-MON-YY'), 'Male'),
(13, 'Jesse', 'Eisenberg', TO_DATE('05-OCT-83', 'DD-MON-YY'), 'Male'),
(14, 'Sam', 'Worthington', TO_DATE('02-AUG-76', 'DD-MON-YY'), 'Male');


-- Insert data into the Genre table
INSERT INTO Genre (GenreID, Name)
VALUES
(1, 'Drama'),
(2, 'Crime'),
(3, 'Action'),
(4, 'Adventure'),
(5, 'Comedy'),
(6, 'Sci-Fi'),
(7, 'Adventure'),
(8, 'Romance'),
(9, 'Crime'),
(10, 'Biography');


-- Insert data into the MovieDirector table
INSERT INTO MovieDirector (MovieID, DirectorID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 4),
(8, 7),
(9, 8),
(10, 9),
(11, 10),
(12, 4),
(13, 11),
(14, 12),
(15, 8),
(16, 13);


-- Insert data into the MovieActor table
INSERT INTO MovieActor (MovieID, ActorID, Role)
VALUES
(1, 1, 'Lead Actor'),
(2, 2, 'Lead Actor'),
(3, 3, 'Lead Actor'),
(4, 4, 'Lead Actor'),
(5, 5, 'Lead Actor'),
(6, 6, 'Lead Actor'),
(7, 7, 'Lead Actor'),
(16, 7, 'Lead Actor'),
(8, 8, 'Lead Actor'),
(9, 7, 'Lead Actor'),
(10, 9, 'Lead Actor'),
(11, 10, 'Lead Actor'),
(12, 11, 'Lead Actor'),
(13, 12, 'Lead Actor'),
(14, 13, 'Lead Actor'),
(15, 14, 'Lead Actor');


-- Insert data into the MovieGenre table
INSERT INTO MovieGenre (MovieID, GenreID)
VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 2),
(4, 3),
(5, 1),
(5, 8),
(6, 3),
(6, 6),
(7, 3),
(7, 4),
(8, 4),
(9, 1),
(9, 8),
(10, 2),
(10, 7),
(11, 3),
(11, 4),
(11, 6),
(12, 4),
(12, 6),
(13, 1),
(13, 2),
(13, 3),
(13, 4),
(14, 1),
(14, 10),
(15, 3),
(15, 4),
(15, 6),
(16, 1),
(16, 2);
