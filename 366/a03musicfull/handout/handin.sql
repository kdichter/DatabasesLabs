/* REPLACE THIS WITH YOUR NAME */
/* Lab 03: Music (full) */

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

create table artist (
    artist_name varchar(100),
    primary key (artist_name)
);

create table album (
    album_id int,
    album_label_id varchar(100),
    album_title varchar(100),
    album_year numeric (4, 0),
    artist_name varchar (100),
    label_name varchar(100),
    primary key (album_id),
    foreign key (artist_name) references artist(artist_name),
    foreign key (label_name) references label(label_name)
);

create table composition (
    composition_id int, 
    composition_title varchar(100),
    composition_year numeric (4, 0),
    primary key (composition_id)
);

create table recording (
    recording_id int,
    recording_length double precision,
    recording_date varchar(100),
    composition_id int,
    primary key (recording_id, composition_id),
    foreign key (composition_id) references composition(composition_id)
);

create table person (
    person_id int,
    person_first_name varchar(100),
    person_last_name varchar(100),
    primary key (person_id)
);

create table track (
    track_num int,
    album_id int,
    composition_id int,
    recording_id int,
    primary key (track_num, album_id),
    foreign key (album_id) references album(album_id),
    foreign key (composition_id, recording_id) references recording(composition_id, recording_id)
);

create table composes (
    composes_role varchar(100),
    composes_order int,
    composition_id int, 
    person_id int,
    primary key (composes_role, person_id, composition_id),
    foreign key (composition_id) references composition(composition_id),
    foreign key (person_id) references person(person_id)
);

create table is_member_of (
    start_date varchar(100),
    end_date varchar(100),
    artist_name varchar(100),
    person_id int,
    primary key (start_date, artist_name, person_id),
    foreign key (artist_name) references artist(artist_name),
    foreign key (person_id) references person(person_id)
);

create table performs (
    performs_role varchar(100),
    composition_id int,
    person_id int,
    recording_id int,
    primary key (performs_role, composition_id, person_id, recording_id),
    foreign key (recording_id, composition_id) references recording(recording_id, composition_id),
    foreign key (person_id) references person(person_id)
);
/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT track_num, composition_title 
from track 
join composition c 
on track.composition_id = c.composition_id
join album a
on track.album_id = a.album_id
where album_title = 'Giant Steps';
/* PROBLEM 2 END */

/* PROBLEM 3 BEGIN */
SELECT person_first_name, person_last_name, performs_role
from person
join performs p
on person.person_id = p.person_id
join recording r
on p.recording_id = r.recording_id
join composition c
on r.composition_id = c.composition_id
where recording_date = '1959-05-04'
and composition_title = 'Giant Steps';
/*and r.recording_id = 1;*/
/* PROBLEM 3 END */

/* PROBLEM 4 BEGIN */
SELECT distinct person_first_name, person_last_name
from person
join performs p
on person.person_id = p.person_id
join recording r
on p.recording_id = r.recording_id
join composition c
on r.composition_id = c.composition_id
where (select count(*) from performs) >= 1
and p.performs_role = 'tenor sax';
/* PROBLEM 4 END */

/* PROBLEM 5 BEGIN */
SELECT composition_title, track_num, album_title
from track as t
join composition c
on t.composition_id = c.composition_id
join album a
on t.album_id = a.album_id
where (select count(*) from track where track.album_id = t.album_id and track.composition_id = t.composition_id) >=2
order by c.composition_title asc, t.track_num asc;
/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT recording_id, recording_date
from recording r
where not exists (
select *
from album a
where not exists (
    select *
    from track t
    where t.recording_id = r.recording_id
    and t.album_id = a.album_id
    )
);
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */
SELECT r.recording_id, r.recording_date
from recording r
join track t
on t.recording_id = r.recording_id
where (select count(*) from track where track.album_id <> t.album_id and track.recording_id = t.recording_id) >= 2;
/* <> is not equal */
/* PROBLEM 7 END */

