/* REPLACE THIS WITH YOUR NAME
* Kevin Dichter
*/
/* Lab 02: Music (basic) */

/* PROBLEM 1 BEGIN */
create table label (
    label_name varchar(100),
    label_street varchar(100),
    label_city varchar(100),
    label_state varchar(100),
    label_postcode varchar(100),
    label_nation varchar(100),
    primary key (label_name)
);

create table album (
    album_id int,
    album_label_id varchar(100),
    album_title varchar(100),
    album_year numeric (4, 0),
    label_name varchar(100),
    primary key (album_id),
    foreign key (label_name) references label(label_name)
);

create table track (
    track_id int,
    track_num int,
    track_title varchar(100),
    track_length double precision,
    album_id int,
    primary key (track_id),
    foreign key (album_id) references album(album_id)
);
/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT track_title, album_title, track_length 
from track 
join album 
on track.album_id = album.album_id 
order by album_title asc, track_length asc, track_title asc;
/* PROBLEM 2 END */

/* PROBLEM 3 BEGIN */
SELECT track_title, track_length 
from track 
where album_id = (select album_id from album where album_id = 2);
/* PROBLEM 3 END */

/* PROBLEM 4 BEGIN */
SELECT album_title, track_title, track_length 
from album 
join track 
on album.album_id = track.album_id 
join (select album_id, max(track_length) as max_length from track group by album_id) as max_tracks 
on track.album_id = max_tracks.album_id
and track.track_length = max_tracks.max_length;
/* PROBLEM 4 END */

/* PROBLEM 5 BEGIN */
SELECT album_title, count(track.album_id) as count, sum(track_length) as sum
from album
join track 
on album.album_id = track.album_id 
group by album.album_id, album.album_title
order by count desc;
/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT label.label_name, label_nation, album_title, sum(track.track_length) as album_length
from label
join album
on label.label_name = album.label_name
join track
on album.album_id = track.album_id
group by label.label_name, label_nation, album_title
having sum(track.track_length) > 40;
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */
SELECT album_title, track_title, track_length
from album
join track
on album.album_id = track.album_id
order by track_length asc
limit 3;
/* PROBLEM 7 END */

/* PROBLEM 8 BEGIN */
create view album_view (album_id, album_label_id, album_title, album_year, album_length)
as select album.album_id, album_label_id, album_title, album_year, sum(track.track_length) as album_length
from album
join track
on track.album_id = album.album_id
group by album.album_id, album_label_id, album_title, album_year;
/* PROBLEM 8 END */

/* PROBLEM 9 BEGIN */
SELECT track_title, track_length, album_title
from track
join album
on track.album_id = album.album_id
where track_title
like 'C%';
/* PROBLEM 9 END */

/*

select track_title from track t join album a on t.album_id = a.album_id where t.track_id > 0 and t.track_id < 10;

select track_title from track t, album a where t.track_id > 0 and t.track_id < 10;

create table address (
    address varchar(100),
    city varchar (100),
    primary key (address)
);

create table customer (
    customer_id int,
    fname varchar (100),
    address varchar (100),
    primary key (customer_id),
    foreign key (address) references address(address)
);

select fname, a.address from address a join customer on customer.address = a.address where a.address = '123 st';

select fname, a.address from address a, customer where a.address = '123 st  ';
*/
