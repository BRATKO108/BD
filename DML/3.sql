delete from categories where id not in(select categoryid from rooms);

