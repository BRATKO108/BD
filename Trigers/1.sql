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