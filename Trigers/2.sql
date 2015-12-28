/*Procedura*/

SET TERM ^ ;

create or alter procedure COST_DATE (
    INSTRATDATE date,
    INENDDATE date,
    INID integer)
returns (
    OUTCOST integer)
as
begin
  select   sum(roomconditions.cost)
 from roomconditions
 where roomconditions.clientid = :inid
 and roomconditions.inroom> :instratdate
 and  roomconditions.inroom< :inenddate into :outcost ;
  suspend;
end^

SET TERM ; ^


/*Triger*/

SET TERM ^ ;



CREATE OR ALTER TRIGGER FREEADDCOND FOR ROOMCONDITIONS
ACTIVE BEFORE INSERT POSITION 0
AS
declare variable pstart date;
declare variable pend date;
declare variable pcost int;
begin
  pstart = '1.1.2014';
  pend = '1.1.2016';
  execute procedure cost_date pstart,pend,new.clientid
  returning_values pcost;
  if(pcost>600000)
  then
  insert into AddServiceCondition (Number,AddServiceId,EmployeeID,EndAS,ClientID,cost)
  values (869,13,new.clientid,'1.1.2017',new.clientid,0);
end
^


SET TERM ; ^
