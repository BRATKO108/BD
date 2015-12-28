create procedure NEW_PROCEDURE2 (
    CATEGROOM type of column CATEGORIES.ID not null)
returns (
    ROOM integer,
    KV integer,
    KV2 integer,
    KV3 integer,
    KV4 integer)
as
declare variable I integer = 1; /* 1 */
declare variable CURYEAR integer;
declare variable BUFER float;
declare variable I2 integer = 1;
declare variable BUFER2 float;
declare variable RESKVA float;
begin
  /* Procedure Text */

  for
  select rooms.id
  from rooms
  where rooms.categoryid = :categroom
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

     select kva1.kva1ch from
    (select roomconditions.roomid as kva1rid, count(roomconditions.roomid) as kva1ch
    from roomconditions
    where  extract(year from roomconditions.inroom)
    =:curyear-1 and roomconditions.roomid in (select rooms.id from rooms)
    and  extract(month from roomconditions.inroom) between :i2 and :i2+2
    GROUP BY roomconditions.roomid
    order by roomconditions.roomid) as kva1
    where kva1.kva1rid = :i
    into :bufer2;
    reskva = bufer/bufer2*100;
    if (i2 = 1) then kv = reskva;
    if (i2 = 4) then kv2 = reskva;
    if (i2 = 7) then kv3 = reskva;
    if (i2 = 10) then kv4 = reskva;
    i2 = i2 + 3;
    end
    suspend;
    i2 = 1;
    end

end