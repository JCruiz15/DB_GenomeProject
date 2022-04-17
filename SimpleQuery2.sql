SELECT Genome.name, count(Genome_idGenome)
FROM Bookshelf, Genome
WHERE Bookshelf.Genome_idGenome = Genome.idGenome 
	AND Genome.Name = "Homo Sapiens";