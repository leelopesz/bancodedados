-- Exercicio 1

delimiter //
create function total_livros_por_genero(genero_nome VARCHAR(200))
returns INT
begin
  declare total INT;
  declare livro_genero VARCHAR(200);

  declare curso cursor for 
    select genero
    from livros
    where genero = genero_nome;

  set total = 0;

  fetch_loop: loop
    fetch curso into livro_genero;

    if not found then 
      leave fetch_loop;
    end if;
    set total = total + 1;
  end loop;
  close curso;
  return total;
end;
//
delimiter ;

-- Exercicio 2


-- Exercicio 3


-- Exercicio 4


-- Exercicio 5
