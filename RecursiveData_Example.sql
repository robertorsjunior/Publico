-- Drop table RecursiveData 
-- Create Table RecursiveData (ID int, Description varchar(50), IDDependency int, ItemOrder int)

Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (1, 'Dados 1', 0, 1);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (2, 'Dados 2', 0, 2);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (3, 'Dados 1.1', 1, 1);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (4, 'Dados 1.2', 1, 2);
Insert into RecursiveData (ID, Description, IdDependency, ItemOrder) Values (5, 'Dados 2.1', 2, 1);


select Id, Description, Cast(ItemOrder as varchar(100)) as NIVEL
from RecursiveData 
where iddependency = 0

union ALL 

select Rd2.Id, rd2.Description, Cast(Rd1.ItemOrder as varchar(100)) + '->' + Cast(Rd2.ItemOrder as varchar(100))
from RecursiveData Rd1
inner join RecursiveData Rd2 on Rd1.Id = Rd2.IdDependency

Order by 3