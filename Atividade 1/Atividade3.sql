-- Questão 1:
select f.titulo
from filme f
where f.codest in (select e.codest
               	from estudio e
               	where e.nomeest like 'P%')
order by f.titulo;
-- 1.1: Retorna o código do único estúdio de nome iniciado pela letra P.
-- 1.2: Retorna em ordem alfabética os títulos dos filmes produzidos pelo estúdio selecionado na subconsulta.

-- Questão 2:
select f.titulo
from filme f
where exists
 	(select e.codest
 	 from estudio e
  	where f.codest = e.codest and nomeest like 'P%')
order by f.titulo;
-- Retorna os mesmos resultados da consulta anterior. A diferença é que nesta consulta a conexão entre as tabelas envolvidas
-- é checada a cada iteração, tornando necessária a execução conjunta de ambas as consultas interna e externa.

-- Questão 3:
select c.desccateg as Descrição from categoria c
where c.codcateg in (select f.codcateg from filme f
					where f.codcateg = c.codcateg);

-- Questão 4: 
select a.nomeart as Artista from artista a
where a.codart in (select p.codart from personagem p
				  where p.codart = a.codart
				  and p.nomepers = 'Natalie'); -- Cameron Diaz
				  
-- Questão 5:
select a.nomeart as "Artistas sem personagens" from artista a
where a.codart not in (select p.codart from personagem p
					  where a.codart = p.codart);

-- Questão 6:
select a.nomeart as "Acima da média" from artista a
join personagem p on p.codart = a.codart
where p.cache > (select avg(p.cache) from personagem p);
