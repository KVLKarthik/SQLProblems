create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup

with cte1 as(
select team_1,Winner from icc_world_cup
union all 
select Team_2,Winner from icc_world_cup)
select team_1,COUNT(team_1) NO_OF_MATCHES_PLAYERD,
sum(case when winner = team_1 then 1 else 0 end) NO_OF_MATCHES_won,
(COUNT(team_1) - sum(case when winner = team_1 then 1 else 0 end) )
NO_OF_MATCHES_loss
from cte1 group by team_1
ORDER BY sum(case when winner = team_1 then 1 else 0 end) DESC,COUNT(team_1) DESC,
team_1 desc;






















































































