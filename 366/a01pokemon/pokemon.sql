/* question 1: */
CREATE TABLE pokemon (
	name VARCHAR(100),
	Type_1 VARCHAR(100),
	Type_2 VARCHAR(100),
	Total SMALLINT,
	Hit_points SMALLINT,
	Attack SMALLINT,
	Defence SMALLINT,
	special_attack SMALLINT,
	special_defense SMALLINT,
	speed SMALLINT,
	Generation SMALLINT,
	Legendary BOOLEAN, 
	PRIMARY KEY (name));
/* 
* Question 3: insert into pokemon values ('Marauder', 'Fighting', null, 400, 100, 70, 50, 100, 30, 50, 6, true);
	INSERT 0 1
* Question 4: select name from pokemon where legendary = true and generation = 1; 
			name         
	---------------------
	Articuno
	Zapdos
	Moltres
	Mewtwo
	MewtwoMega Mewtwo X
	MewtwoMega Mewtwo Y
	(6 rows)
* Question 5: select name from pokemon where speed > 150 and attack > defence;
		name        
	-------------------
	Ninjask
	DeoxysSpeed Forme
	(2 rows)
* Question 6: select distinct type_1, type_2 from pokemon where speed > 40 and speed < 45;
	type_1  | type_2 
	----------+--------
	Bug      | Grass
	Normal   | Flying
	Rock     | Grass
	Poison   | 
	Fairy    | 
	Ghost    | Grass
	Dragon   | Ground
	Rock     | Ground
	Psychic  | 
	Water    | 
	Poison   | Dragon
	Ice      | 
	Normal   | 
	Fighting | 
	(14 rows)
* Question 7: select count (name) from pokemon;
	count 
	-------
	801
	(1 row)
* Question 8: select max (hit_points) from pokemon where generation = 3;
	max 
	-----
	170
	(1 row)
* Question 9: select name from pokemon where name ~* '^z'; or select name from pokemon where name like 'Z%';
		name       
	------------------
	Zubat
	Zapdos
	Zigzagoon
	Zangoose
	Zebstrika
	Zorua
	Zoroark
	Zweilous
	Zekrom
	Zygarde50% Forme
	(10 rows)
* Question 10: delete from pokemon where name = 'Marauder';
	DELETE 1
*/

/* get max hit_point pokemon from each generation */
select generation, max(hit_points) as max_hp
from pokemon 
group by generation 
order by generation asc;

/* get name of pokemon with max hit_point from each generation */
select p.name, p.generation, p.hit_points 
from pokemon p
join (select generation, max(hit_points) as max_hp
	  from pokemon
	  group by generation) as hp
on p.generation = hp.generation and p.hit_points = hp.max_hp;

/* OR */

select name, generation, hit_points
from pokemon p
where hit_points = 
(select max(hit_points)
 from pokemon
 where generation = p.generation);

/* having max(hit_points) = 
(select max(hit_points)
from pokemon)) */

