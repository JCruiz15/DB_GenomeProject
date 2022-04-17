SELECT Organism.Common_name, Organism.Family, Organism.Species
FROM Organism
WHERE idOrganism IN (SELECT idGenome FROM Genome WHERE Release_date < DATE '2018-1-1');