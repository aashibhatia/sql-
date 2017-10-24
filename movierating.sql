# sql-
stanford social-network sql command 
/* Delete the tables if they already exist */
drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);

===================================================================================================================================
1.select name from highschooler where highschooler.id in(select id2 from friend ,highschooler where highschooler.id=friend.id1 and name='Gabriel');
2.select n1, g1 ,n2 ,g2 from (select h1.name as n1,h1.grade as g1,id1,id2,h2.name as n2,h2.grade as g2 from highschooler h1, likes l, highschooler h2 where h1.id=l.id1 and h2.id= l.id2)  as p 
where g1-g2>1;
3.select h1.name, h1.grade, h2.name, h2.grade  from Likes l1, Likes l2, Highschooler h1, Highschooler h2
where l1.ID1=l2.ID2 and l2.ID1=l1.ID2 and l1.ID1=h1.ID and l1.ID2=h2.ID and h1.name<h2.name;
or
select n1, g1,n2,g2 from(select id1,id2,h1.name as n1,h1.grade as g1 ,h2.name as n2 ,h2.grade as g2
from likes,highschooler h1,highschooler h2 
where h1.id=likes.id1 and h2.id=likes.id2 or (likes.id1= h2.id and likes.id2= h1.id)) as p
where n1<n2 group by n1,n2 having count(*)=2 ;

4.select  distinct name, grade from highschooler , likes where id not in(select id1 from likes )and id not in(select id2 from likes)
 order by grade,name;
5.select  h1.name , h1.grade,h2.name,h2.grade from highschooler h1,highschooler h2,likes l where h1.id=l.id1 and h2.id=l.id2 and l.id2 not in(select id1 from likes );
6. select distinct name , grade from HIGHSCHooler where id not in  (select f.id1 from highschooler h1,highschooler h2,friend f 
where f.id1=h1.id and h2.id=f.id2 and h1.grade<>h2.grade)order by grade, name;
7. select distinct n1, g1,n2,g2,n3,g3 from (select h1.name as n1,h1.grade as g1,h2.name as n2,h2.grade as g2 ,h3.name as n3, h3.grade as g3 from highschooler h1,highschooler h2, highschooler h3 , friend f1, friend f2,likes l1
   where h1.id=l1.id1 and h2.id=l1.id2 and h3.id=f1.id2 and h1.id=f1.id1 and h2.id not in(select id2 from friend where h1.id=id1  ) and h2.id=f2.id2 and h3.id=F2.ID1) AS P;
