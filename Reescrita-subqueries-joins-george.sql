-- Query original com subqueries:
select p.data from pedido p -- Retorna a data do pedido da subquerie.
where p.numped in
				(select i.numped -- Retorna 3, o ID do pedido que contém chocolate.
				 from itenspedido i
				 where i.codprod in
								  (select pr.codprod
								   from produto pr
								   where descricao like 'Chocolate')); -- Retorna 2, o ID do chocolate.
								   
-- Query reescrita com junções:
select p. data from pedido p
join itenspedido i on i.numped = p.numped
join produto pr on pr.codprod = i.codprod
where pr.descricao = 'Chocolate';