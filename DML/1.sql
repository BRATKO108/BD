select 
	rooms.numberroom as TOP10ROOMS
from 
	(
	select  
		first 10 count(roomconditions.roomid) as schit,roomconditions.roomid  
	from 
		roomconditions 
	where  
		roomconditions.id IN (
		
		select 
			roomconditions.id from roomconditions 
		where 
			roomconditions.InRoom> '25.6.2014' and OutRoom< '13.2.2016')

	group by roomconditions.roomid 
	order by schit desc) as coof, rooms 
where rooms.id = coof.roomid;