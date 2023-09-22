-- Drop table RecursiveData 
-- Create Table RecursiveData (ID int, Description varchar(50), IDDependency int, ItemOrder int)
-- Select * from RecursiveData

delete RecursiveData; 
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (1, 'Dados 1', 0, 1);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (2, 'Dados 2', 0, 2);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (3, 'Dados 1.1', 1, 1);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (4, 'Dados 1.2', 1, 2);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (5, 'Dados 2.1', 2, 1);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (6, 'Dados 1.2.1', 4, 1);

with MyCTE
as 
(

    -- anchor
    SELECT  ID, Description , IDDependency,1 AS [Level], CAST((ItemOrder) AS VARCHAR(MAX)) AS Hierarchy
    FROM    RecursiveData rd 
    WHERE   IDDependency = 0

	union all

    SELECT  t2.ID d, t2.Description, t2.IDDependency, M.[level] + 1 AS [Level], CAST((M.Hierarchy + '.' + CAST( t2.[ItemOrder] as varchar(max) )) AS VARCHAR(MAX)) AS Hierarchy
    FROM    RecursiveData AS t2
            JOIN MyCTE AS M ON t2.IDDependency = M.Id
)
SELECT * FROM MyCTE order by HIERARCHY
