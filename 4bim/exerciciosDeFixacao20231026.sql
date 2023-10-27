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
