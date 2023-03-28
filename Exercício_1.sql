create table departamento (
   CodDepto                      serial not null, 
   Nome                          varchar(20),
   Local                         varchar(20));

alter table departamento add constraint pkdepto primary key(coddepto);

create table empregado (
       Matricula               serial not null,
       PrimeiroNome            varchar(15),
       Sobrenome   	           varchar(15),
       Dataadmissao            date,
       Cargo                   varchar(30),
       Salario                 numeric(13,2),
       gerente		             integer,
       CodDepto                integer);

alter table empregado add constraint pkEmp primary key(matricula);

Alter table empregado add constraint fkgerente foreign key(gerente) references Empregado;
Alter table Empregado add constraint fkdepto foreign key(coddepto) references Departamento;

insert into departamento values (default,'Informática','Sede');
insert into departamento values (default,'Pessoal','Sede');

insert into Empregado values (default,'Jõao', 'Guedes',current_date,'Analista de Sistemas Junior',3400.00,null,1);
insert into Empregado values (default,'José', 'Batista',current_date,'Analista de Sistemas Pleno',4200.00,1,1);
insert into Empregado values (default,'Ana Maria', 'Silva',current_date,'Analista de Sistemas Junior',3400.00,1,1);
insert into Empregado values (default,'Ricardo', 'Neves',current_date,'Analista de Sistemas Pleno',4200.00,2,1);
insert into Empregado values (default,'Valter', 'Moura',current_date,'Analista de Suporte Junior',3400.00,2,1);
insert into Empregado values (default,'Mariana','Oliveira',current_date,'Designer de Interface',4800.00,1,null);
insert into Empregado values (default,'George','Lima','2023-03-03','Localization Engineer',2500.00,2,2);

select * from empregado; 

-- Questão 1:
--1.1: 
select * from empregado order by matricula;

--1.2:
select primeironome || ' ' || sobrenome as "Empregado" from empregado
where cargo = 'Analista de Sistemas Pleno';

--1.3:
Select e.primeironome || ' ' || e.sobrenome as "Empregado", d.nome as "Departamento" 
From empregado e join departamento d on e.coddepto = d.coddepto;
-- Concatena o nome e sobrenome do empregado e o departamento ao qual ele é associado.

--1.4:
select count(*) as quantidade from empregado e
join departamento d on e.coddepto = d.coddepto
group by d.nome;

--1.5:
select d.nome, count(d.nome) as Empregados from departamento d
join empregado e on d.coddepto = e.coddepto
group by d.nome having count(d.nome) > 3;

--1.6:
select sum(salario) as "Soma de salários" from empregado e
join departamento p on e.coddepto = p.coddepto
group by(e.coddepto);

--1.7:
Select  g.primeironome || ' ' || g.sobrenome as "Gerente",         
e.primeironome || ' ' || e.sobrenome as "Empregado"  
From (empregado e join empregado g   on e.gerente = g.matricula)   
order by g.Gerente;
-- Concatena o nome e sobrenome dos empregados em posição de gerência e combina com os empregados gerenciados por eles.

--1.7.1:
Select  g.primeironome || ' ' || g.sobrenome as "Gerente",         
count(g.matricula) as  "N. gerenciados" From empregado e 
join empregado g   on e.gerente = g.matricula
group by (g.matricula)
order by g.Gerente;

--Questão 2:
--2.1:
select e.primeironome from empregado e
where e.coddepto in (select d.coddepto from departamento d
                    where (select d.nome like 'P%'));

--2.2:
select e.sobrenome from empregado e
where e.gerente in (select g.matricula from empregado g
                   where g.sobrenome like 'Guedes');

--2.3:
select e.primeironome || ' ' || e.sobrenome as "sem departamento" from empregado e
where not exists (select * from departamento d
                 where d.coddepto = e.coddepto);
                 
--Questão 3:
create or replace view empDep (primeironome, nome)
as select primeironome, d.nome from empregado e
left join departamento d on e.coddepto = d.coddepto
order by d.coddepto;
select * from empDep;

--3.1:
insert into empDep values ('Maria', 'Pessoal');
--Não é possível fazer inserções nesta view pois ela foi formada a partir de duas tabelas, logo a inserção nela implicaria em inserções simultâneas nas tabelas raízes, o que não é suportado nativamente pelo SQL.

--3.2:
insert into empregado values (
default, 'Maria', 'Silva', '2022-05-18', 'Tech Recruiter', 2000, 2, null
);
select * from empDep;
--Sim, a inserção na tabela empregado foi refletida corretamente na view.

--Questão 4:
create or replace view dep (coddepto, nome)
as select coddepto, nome from departamento;
insert into dep values(default, 'Contabilidade');
select * from dep;
select * from departamento;

--Questão 5:
create or replace view emp (matricula, primeironome, dataadmissao)
as select matricula, primeironome, dataadmissao from empregado
where primeironome like 'M%'
with check option;

select * from emp;
insert into emp values (default, 'Alberto'); --Não atende o check.
insert into emp values (default, 'moises'); --Não atende por ser case sensitive.
insert into emp values (default, 'Moises'); -- Atende e é inserida.

--Questão 6:
select e.matricula
from empregado e
  EXCEPT
select e.gerente
from empregado e;
--Retorna a matrícula de todos os funcionários exceto daqueles que 
--também estão presentes no subconjunto gerentes.

select e.matricula
from empregado e
  INTERSECT
select e.gerente
from empregado e;
--Retorna a matrícula somente dos funcionários que estão presentes 
--nos subconjuntos empregados e gerentes.

--Questão 7:
select e.coddepto
from empregado e
where e.dataadmissao> '20-01-2021'
   INTERSECT
select d.coddepto
from departamento d;
--Retorna o código de departamento dos funcionários admitidos após a data especificada desde que esses departamentos estejam também presentes na tabela departamento.
--Refazendo com subquery:
select distinct e.coddepto from empregado e
where e.dataadmissao> '20-01-2021' and e.coddepto in  (select d.coddepto from departamento d);

--Refazendo com join:
select distinct e.coddepto from empregado e
join departamento d on e.coddepto = d.coddepto;

--Questão 8:
WITH
Custo_depto as (
  Select d.nome, sum(e.salario) as total_depto
  From empregado e JOIN departamento d 
       on e.coddepto = d.coddepto
  Group by d.nome), --Retorna o custo total de cada departamento.
  Custo_medio as (
	Select sum(total_depto)/Count(*) as media_dep
	From Custo_depto) --Retorna o custo médio de cada departamento.
Select *
From Custo_depto
Where total_depto > (
        	Select media_dep
        	From Custo_medio)
Order by nome; --Utiliza as consultas anteriores para exibir somente departamentos com custo acima da média.
