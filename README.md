This Pig script uses the [Book-Crossing dataset](http://www2.informatik.uni-freiburg.de/~cziegler/BX/) to find the highest rated book. The book with the highest average rating is considered to be the highest rated book. A book must have at least 50 explicit ratings to be considered. This threshold was determined when I was creating the [most_popular_book.pig](https://github.com/keving90/Most_Popular_Book_Pig) script. There are many book with few ratings whose average rating is skewed due to a small sample size. The results can be found in `results.txt`.

This script was written for my own personal interest. I have been learning about the Hadoop ecosystem to help pursue a position in 
Data Science, Big Data, or a related field. I used a pseudo-distributed Hadoop cluster on a RedHat Enterprise Linux 7.2 virtual machine.

Comments, critiques, suggestions, etc. are welcome.
