SELECT * FROM Genome
LEFT JOIN Bookshelf ON Bookshelf.Genome_idGenome = Genome.idGenome;
FULL JOIN Book ON Bookshelf.Book_idBook = Book.idBook;




