SET TERM ^ ;

create or alter procedure NEW_PROCEDURE
returns (
    ROOM integer,
    KV integer,
    KV2 integer,
    KV3 integer,
    KV4 integer)
as
declare variable I integer = 1; /* 1 */
declare variable CURYEAR integer;
begin
  /* Procedure Text */

  for
  select rooms.id
  from rooms
  into :i
  do
    begin
    select rooms.numberroom
    from rooms
    where rooms.id =:i
    into :room;
    curyear = extract(year from (current_date ));
    /*1 kvartal*/
    select kva1.kva1ch from
    (select roomconditions.roomid as kva1rid, count(roomconditions.roomid) as kva1ch
    from roomconditions
    where  extract(year from roomconditions.inroom)
    =:curyear and roomconditions.roomid in (select rooms.id from rooms)
    and  extract(month from roomconditions.inroom) between 1 and 3
    GROUP BY roomconditions.roomid
    order by roomconditions.roomid) as kva1
    where kva1.kva1rid = :i
    into :kv;

    /*2 kvartal*/
    select kva2.kva2ch from
    (select roomconditions.roomid as kva2rid, count(roomconditions.roomid) as kva2ch
    from roomconditions
    where  extract(year from roomconditions.inroom)
    =:curyear and roomconditions.roomid in (select rooms.id from rooms)
    and  extract(month from roomconditions.inroom) between 4 and 6
    GROUP BY roomconditions.roomid
    order by roomconditions.roomid) as kva2
    where kva2.kva2rid = :i
    into :kv2;

    /*3 kvartal*/
    select kva3.kva3ch from
    (select roomconditions.roomid as kva3rid, count(roomconditions.roomid) as kva3ch
    from roomconditions
    where  extract(year from roomconditions.inroom)
    =:curyear and roomconditions.roomid in (select rooms.id from rooms)
    and  extract(month from roomconditions.inroom) between 7 and 9
    GROUP BY roomconditions.roomid
    order by roomconditions.roomid) as kva3
    where kva3.kva3rid = :i
    into :kv3;

    /*4 kvartal*/
    select kva4.kva4ch from
    (select roomconditions.roomid as kva4rid, count(roomconditions.roomid) as kva4ch
    from roomconditions
    where  extract(year from roomconditions.inroom)
    =:curyear and roomconditions.roomid in (select rooms.id from rooms)
    and  extract(month from roomconditions.inroom) between 10 and 12
    GROUP BY roomconditions.roomid
    order by roomconditions.roomid) as kva4
    where kva4.kva4rid = :i
    into :kv4;

    suspend;
    end

end^

SET TERM ; ^

GRANT SELECT ON ROOMS TO PROCEDURE NEW_PROCEDURE;

GRANT SELECT ON ROOMCONDITIONS TO PROCEDURE NEW_PROCEDURE;

GRANT EXECUTE ON PROCEDURE NEW_PROCEDURE TO SYSDBA;







SET TERM ^ ;

create or alter procedure NEW_PROCEDURE
returns (
    ROOM integer,
    KV integer,
    KV2 integer,
    KV3 integer,
    KV4 integer)
as
declare variable I integer = 1; /* 1 */
declare variable CURYEAR integer;
declare variable BUFER integer;
declare variable I2 integer = 1;
begin
  /* Procedure Text */

  for
  select rooms.id
  from rooms
  into :i
  do
    begin
    select rooms.numberroom
    from rooms
    where rooms.id =:i
    into :room;
    curyear = extract(year from (current_date));
    while (i2 < 13)
    do
    begin
    /*1 kvartal*/

    select kva1.kva1ch from
    (select roomconditions.roomid as kva1rid, count(roomconditions.roomid) as kva1ch
    from roomconditions
    where  extract(year from roomconditions.inroom)
    =:curyear and roomconditions.roomid in (select rooms.id from rooms)
    and  extract(month from roomconditions.inroom) between :i2 and :i2+2
    GROUP BY roomconditions.roomid
    order by roomconditions.roomid) as kva1
    where kva1.kva1rid = :i
    into :bufer;
    if (i2 = 1) then kv = bufer;
    if (i2 = 4) then kv2 = bufer;
    if (i2 = 7) then kv3 = bufer;
    if (i2 = 10) then kv4 = bufer;
    i2 = i2 + 3;
    end
    suspend;
    i2 = 1;
    end

end^

SET TERM ; ^

GRANT SELECT ON ROOMS TO PROCEDURE NEW_PROCEDURE;

GRANT SELECT ON ROOMCONDITIONS TO PROCEDURE NEW_PROCEDURE;

GRANT EXECUTE ON PROCEDURE NEW_PROCEDURE TO SYSDBA;