CREATE TABLE person (
    person_id serial not null,
    fname varchar (20),
    mname varchar (20),
    lname varchar (50),
    birthday date,
    primary key (person_id)
);

CREATE TABLE coach (
    coach_id int not null,
    primary key (coach_id),
    foreign key (coach_id) references person (person_id)
);

CREATE TABLE team (
    region varchar (50),
    nickname varchar (50),
    when_founded numeric (4, 0),
    when_disbanded numeric (4, 0),
    head_coach int not null,
    primary key (region, nickname),
    foreign key (head_coach) references coach (coach_id),
    check (when_founded >= 0 and when_disbanded >= 0)
);

CREATE TABLE player (
    player_id int not null,
    position varchar (20),
    primary key (player_id),
    foreign key (player_id) references person (person_id),
    check (position = 'Center' or position = 'Winger' or position = 'Defenseman' or position = 'Goalie')
);

CREATE TABLE roster (
    startdate date,
    enddate date,
    jerseynum smallint,
    player_id int not null,
    region varchar (50),
    nickname varchar (50),
    primary key (startdate, player_id, region, nickname),
    foreign key (player_id) references player (player_id),
    foreign key (region, nickname) references team (region, nickname)
);

CREATE TABLE game (
    season varchar (20),
    game_number smallint,
    day_played date,
    region_host varchar (50),
    nickname_host varchar (50),
    region_visitor varchar (50),
    nickname_visitor varchar (50),
    primary key (season, game_number),
    foreign key (region_host, nickname_host) references team (region, nickname),
    foreign key (region_visitor, nickname_visitor) references team (region, nickname),
    check (game_number > 0)
);

CREATE TABLE goal (
    goal_number smallint,
    period varchar (20),
    goal_time int,
    goal_type varchar(20),
    empty_net boolean,
    player_scored int not null,
    player_primary_assists int not null,
    player_secondary_assists int not null,
    season varchar (20),
    game_number smallint,
    primary key (goal_number, season, game_number),
    foreign key (season, game_number) references game (season, game_number),
    foreign key (player_scored) references player (player_id),
    foreign key (player_primary_assists) references player (player_id),
    foreign key (player_secondary_assists) references player (player_id),
    check ((goal_number > 0 and game_number > 0) and 
    (period = '1st' or period = '2nd' or period = '3rd' or period = 'OT' or period = 'SO') and 
    (goal_type = 'ES' or goal_type = 'PP' or goal_type = 'SH' or goal_type = 'PS' or goal_type = 'SO'))
);
