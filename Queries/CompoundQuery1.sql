SELECT Name, Location_start, Location_end, Type, Size 
FROM Sequence, Gene 
WHERE Size > (SELECT AVG(Size) FROM Sequence) 
	AND Gene.idGene = Gene_idGene;	





