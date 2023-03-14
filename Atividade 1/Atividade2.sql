-- Questão 1:
select * from artista;
select * from categoria;
select * from estudio;
select * from filme;
select * from personagem;

-- Questão 2:
insert into filme values(default,'Elvis',2022,120,null,3);
select * from filme;
-- Código do filme: 11 (meu banco conta com mais inserções particulares).

-- Questão 3:
select titulo, duracao from filme
where duracao > 120;

-- Questão 4:
select * from artista
where cidade is null;

update artista set cidade = 'Not informed'
where cidade is null;

-- Questão 5:
select titulo, desccateg from filme f
join categoria c on c.codcateg = f.codcateg
where f.titulo = 'Coringa';

-- Questão 6:
select f.titulo, e.nomeest as Estúdio, c.desccateg as Categoria from filme f
join estudio e on e.codest = f.codest
join categoria c on c.codcateg = f.codcateg;

-- Questão 7:
select a.nomeart from artista a
join personagem p on p.codart = a.codart
join filme f on f.codfilme = p.codfilme
where f.titulo = 'Encontro Explosivo';

-- Questão 8:
select a.nomeart from artista a
join personagem p on p.codart = a.codart
join filme f on f.codfilme = p.codfilme
join categoria c on c.codcateg = f.codcateg
where a.nomeart like 'B%' and c.desccateg = 'Aventura';

-- Questão 9:
select c.desccateg as Categoria, count(c.desccateg) as Total from categoria c
join filme f on f.codcateg = c.codcateg
group by c.desccateg;

-- Questão 10:
select a.nomeart, p.nomepers from artista a
left outer join personagem p on a.codart = p.codart;
-- Exibe a relação de artistas e personagens interpretados por eles, incluindo artistas que não possuem personagens associados a eles.

-- Questão 11:
Select f.titulo as Filme, c.desccateg as Categoria From filme f
right join categoria c on f.codcateg = c.codcateg
Where f.codcateg is null;
-- É um anti-join exibindo apenas categorias que não possuem filmes associados a elas.
