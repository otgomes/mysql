-- Side commands

alter table hotel
change uf fu varchar(2) not null;

alter table clients
change cpf ssn varchar(14) unique not null;

alter table hotel
change fu hotel_fu varchar(2) not null;

alter table hotel
change city hotel_city varchar(255) not null;

update hosting
set room_id = 2
where hosting_id in (6, 8, 10, 12, 14, 16, 18, 20);

truncate table hosting;
-- updated in hosting query.

ALTER TABLE hotel
DROP CONSTRAINT  hotel_chk_1;

ALTER TABLE hotel
ADD CONSTRAINT hotel_chk_1 CHECK (rating >= 1 AND rating <= 5);