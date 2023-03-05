create table teste1 (cod integer, valor char(2));
//Inserindo valores repetidos para teste. Como não foi definida PK, as repetições são aceitas:
insert into teste1 values (1, 'xx');
insert into teste1 values (1, 'xx');
insert into teste1 values (1, 'xx');

select * from teste1;

//Truncate esvazia a tabela:
truncate table teste1;

select * from teste1;

drop table teste1;