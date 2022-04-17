SELECT Genome.Name, Genome.Assembly, Chromosome.ChromosomeNum, Bookshelf.Book_idBook, Book.TItle FROM Genome
INNER JOIN Chromosome ON Genome.idGenome = Chromosome.Genome_idGenome
INNER JOIN Bookshelf ON Genome.idGenome = Bookshelf.Genome_idGenome
INNER JOIN Book ON Bookshelf.Book_idBook = Book.idBook;


