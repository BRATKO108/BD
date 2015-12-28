/*
--Old Version
select first 10 
	 AddServiceCondition.cost, clients.name as Client, AddServices.name as Service
from 
	AddServiceCondition,clients,AddServices
where 

AddServices.id = AddServiceCondition.AddServiceId and clients.id = AddServiceCondition.clientid

order by AddServiceCondition.cost desc ;
*/
select first 10 clients.name, schit
  from ( select (addservicecondition.clientid),addservicecondition.clientid as client, sum(addservicecondition.cost) as schit
  from addservicecondition
  group by addservicecondition.clientid
  order by schit desc), clients
  where clients.id = client  ;

