### Overview
This Pig script uses the [Book-Crossing dataset](http://www2.informatik.uni-freiburg.de/~cziegler/BX/) to find the highest rated book. The book with the highest average rating is considered to be the highest rated book. A book must have at least 50 explicit ratings to be considered. This threshold was determined when I was creating the [most_popular_book.pig](https://github.com/keving90/Most_Popular_Book_Pig) script. There are many books with few ratings whose average rating is skewed due to a small sample size. The results can be found in `results.tsv`. I used a `tsv` file instead of a `csv` because some book titles contain commas. This will cause problems when the `csv` file is opened with Microsoft Excel. The datasets I used for this project were `BX-Book-Ratings.csv` and `BX-Books.csv` from the Book-Crossing's CSV Dump. They are not included in this repository due to their large size.

This script was written for my own personal interest. I have been learning about the Hadoop ecosystem to help pursue a position in 
Data Science, Big Data, Software Engineering, or a related field. I used a pseudo-distributed Hadoop cluster on a RedHat Enterprise Linux 7.2 virtual machine.

Comments, critiques, suggestions, etc. are welcome.

### Hadoop Shell Commands

Open Terminal and change the current directory to Pig's home directory: `cd /home/kevin/pig-0.17.0`.

I placed a folder of the two datasets called `book_ratings` onto the hadoop cluster using: `hadoop fs -put book_ratings`.

The Pig script was run using: `bin/pig scripts/highest_rated_book.pig`.

When PigStorage takes `-schema` (line 57 of `highest_rated_book.pig`), it will create a `.pig_schema` and a `.pig_header` file in the output directory. To output the results as a `tsv` file, we need to merge '.pig_header' with 'part-x-xxxxx’. Since `-getmerge` takes an input directory, we need to get rid of `.pig_schema` first. We use the following two commands:

`hadoop fs -rm -r highest_rated_book/.pig_schema`

`hadoop fs -getmerge highest_rated_book/ ./results.tsv`

The `results.tsv` file will now be found in Terminal's current directory (the Pig home directory on my virtual machine).
