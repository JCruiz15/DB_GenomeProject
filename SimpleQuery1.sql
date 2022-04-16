SELECT Name, Assembly, Release_date 
FROM Genome 
WHERE Release_number > 0 
ORDER BY Release_date asc;	#If the release number is less than 0 it means that the number is unknown