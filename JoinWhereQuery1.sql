SELECT Gene.Name as Gene, Sequence.RefSeq, Protein.Name as Protein, Protein.Function, Chromosome.ChromosomeNum 
FROM Gene 
INNER JOIN Chromosome ON Gene.idGene = Chromosome.Gene_idGene 
INNER JOIN Protein ON Gene.idGene = Protein.Gene_idGene
INNER JOIN Sequence ON Gene.idGene = Sequence.Gene_idGene
WHERE length(Protein.Transcript) > 15000;