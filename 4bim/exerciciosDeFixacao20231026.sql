--Exercicio 1
create trigger after_cliente_insert
after insert on Clientes
for each row
insert into Auditoria(mensagem, data_hora)
values('Está sendo inserido um novo cliente');

--Exercicio 2
create trigger before_cliente_delete
before delete on Clientes
for each row
insert into Auditoria(mensagem, data_hora)
values('Há uma tentativa de exclusão de um cliente');

--Exercicio 3
create trigger after_cliente_update
after update on Clientes
for each row
insert into Auditoria(mensagem, data_hora)
values ('O antigo tem o nome:',old.nome,'. E o novo cliente se chama:', new.nome);

--Exercicio 4
delimiter //
create trigger update_cliente
before update on Clientes
for each row
if new.nome = null or new.nome='' then
insert into Auditoria(mensagem)
values ('Há uma tentativa de atualização de cliente para nulo ou uma string vazia!');
end if;
//

--Exercicio 5
//
create trigger insert_pedidos_estoque
after insert on Pedidos
for each row
update Produtos set estoque = estoque - new.quantidade where produto_id;
if estoque<5 then
insert into Auditoria(mensagem)
values ('O estoque está abaixo de 5');
end if;
//
