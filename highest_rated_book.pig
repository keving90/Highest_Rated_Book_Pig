-- Import the PiggyBank library for CSVExcelStorage()
-- CSVExcelStorage() is useful because it emliminates the header row
REGISTER 'lib/piggybank.jar';

-- Predefine CSVExcelStorage() for easy use
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage(';', 'NO_MULTILINE', 'UNIX', 'SKIP_INPUT_HEADER');

-- Give the job name a title
SET job.name 'Highest Rated Book';

-- Set out the schema containing book ratings
book_ratings = LOAD 'book_ratings/BX-Book-Ratings.csv' USING CSVExcelStorage() AS
(
	UserID: int,
	ISBN: chararray,
	Rating: int
);

-- Set up the schema containing books
books = LOAD 'book_ratings/BX-Books.csv' USING CSVExcelStorage() AS
(
	ISBN: chararray,
	BookTitle: chararray,
	BookAuthor: chararray,
	PublicationYear: int,
	Publisher: chararray,
	ImageURL_S: chararray,
	ImageURL_M: chararray,
	ImageURL_L: chararray
);

-- Remove implicit ratings (0 rating scores) from the book_ratings bag
explicit_ratings = FILTER book_ratings BY (Rating > 0);

-- Group the explicit book ratings by ISBN
grouped_ratings = GROUP explicit_ratings BY ISBN;

-- Get the number of explicit ratings for each book
rating_count_avg = FOREACH grouped_ratings GENERATE group AS ISBN, COUNT(explicit_ratings.UserID) AS NumRatings, AVG(explicit_ratings.Rating) AS AvgRating;

-- Exclude all books with less than 50 explicit ratings
common_books = FILTER rating_count_avg BY (NumRatings >= 50);

-- Only interested in ISBN, title, and author in books bag
book_info = FOREACH books GENERATE ISBN, BookTitle, BookAuthor;

-- Perform an inner join on the average_rating and book_info bags
inner_join = JOIN common_books BY ISBN, book_info BY ISBN;

-- The inner_join bag has two ISBN fields, which is redundant
results = FOREACH inner_join GENERATE book_info::BookTitle AS BookTitle, book_info::BookAuthor AS BookAuthor, ROUND_TO(common_books::AvgRating, 2) AS AvgRating, common_books::NumRatings AS NumRatings;

-- Sort the data
sorted_results = ORDER results BY AvgRating DESC;

-- Execute all of the above actions and store the results
STORE sorted_results INTO 'highest_rated_book' using PigStorage('\t','-schema');












































