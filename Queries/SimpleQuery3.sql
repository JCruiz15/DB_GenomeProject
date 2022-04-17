SELECT Gene.Name as Gene, Sequence.Sequence, Sequence.size ,Protein.Name as Protein, Protein.Function 
FROM Gene, Sequence, Protein 
WHERE Gene.Name = 'TP53' 
	AND Protein.idProtein = Sequence.Protein_idProtein 
	AND Sequence.Gene_idGene = Gene.idGene;