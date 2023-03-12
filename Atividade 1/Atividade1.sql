
insert into artista values(default,'Elisabeth Olsen','Los Angeles','USA','16/02/89');
insert into artista values(default,'Benedict Cumberbatch','Londres','Inglaterra','19/07/76');
insert into artista values(default,'Chadwick Boseman','Carolina do Sul','USA','29/11/76');

insert into categoria values(default,'Fantasia');
insert into categoria values(default,'Terror');
insert into categoria values(default,'Musical');

insert into estudio values(default,'Warner');
insert into estudio values(default,'Sony Pictures');
insert into estudio values(default,'Lionsgate');

insert into filme values(default,'Vingadores: Ultimato',2019,181,7,2);
insert into filme values(default,'Harry Potter and...',2011,130,7,4);
insert into filme values(default,'O exorcista do Papa',2023,136,8,5);
insert into filme values(default,'Bohemian Rhapsody',2018,134,9,6);

insert into personagem values(8,7,'Wanda Maximoff',16000);
insert into personagem values(10,8,'Albus Dumbledore',17000);
insert into personagem values(11,9,'Tchalla',14500);

-- Consultas gerais para conferência:
select * from artista;
select * from categoria;
select * from estudio;
select * from filme;
select * from personagem;

-- Consultas propostas na atividade:

-- Verifique quais são os artistas cadastrados ordenados pelo nome.
select * from artista
order by nomeart;
-- Os artistas estão inseridos em ordem alfabética? Por quê?
-- Não inseridos, mas LISTADOS. Porque o valor padrão para order by é ascendente, e a ordem das letras do alfabeto é considerada ascendente em ordenamento.

-- Selecione os artistas que têm o nome iniciando com a letra ‘B’.
select * from artista
where nomeart like 'B%';

-- Verifique os filmes que foram lançados em 2019.
select * from filme
where ano = 2019;

-- Atualize o cachê dos artistas em 15%.
update personagem
set cache = (cache * 1.15);

-- Atualize o país de 3 artistas à sua escolha.
update artista
set pais = 'Porto Rico'
where codart = 4; -- Joaquim Phoenix
update artista
set pais = 'USA'
where codart = 1; -- Cameron Diaz
update artista
set pais = 'USA'
where codart = 3; -- Brad Pitt

-- Insira 2 artistas brasileiros.
insert into artista values(default,'Lázaro Ramos','Salvador','Brasil','01/11/78');
insert into artista values(default,'Wagner Moura','Salvador','Brasil','27/06/76');
insert into artista values(default,'Camila Pitanga','Rio de Janeiro','Brasil','14/06/77');

-- Delete 1 artista recentemente incluído que não seja brasileiro.
delete from artista
where codart = 2; -- Julia Roberts.