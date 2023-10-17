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

delimiter //

create procedure listar_livros_por_autor(in primeiro_nome varchar(200), in ultimo_nome varchar(200))
begin
    declare done int default 0;
    declare livro_titulo varchar(255);
    declare livro_titulos text default '';
    declare curso cursor for
   
    select Livro.Titulo from Livro_Autor
    join Autor on Livro_Autor.AutorID = Autor.ID
    join Livro on Livro_Autor.LivroID = Livro.ID
    where Autor.PrimeiroNome = primeiro_nome and Autor.UltimoNome = ultimo_nome;
    
    open curso;
    read_loop: loop
        fetch cur into livro_titulo;
        IF done = 1 then
            leave read_loop;
        end if;
        set livro_titulos = CONCAT(livro_titulos, ', ', livro_titulo);
    end loop;
    close curso;
    select livro_titulos as LivrosDoAutor;
end //

DELIMITER ;

-- Exercicio 3

delimiter //

create function atualizar_resumos()
returns int
begin
    declare done int default 0;
    declare livro_id int;
    declare livro_resumo text;
    declare curso cursor for
    
    select ID, Resumo from Livro;
    
    open curso;
    update_loop: loop
        fetch curso into livro_id, livro_resumo;
        if done = 1 then
            leave update_loop;
        end if;
        set livro_resumo = concat(livro_resumo, ' Este é um excelente livro!');
        update Livro
        set Resumo = livro_resumo
        where ID = livro_id;
    end loop;
    close curso;
    return 1;
end //

delimiter ;


-- Exercicio 4

delimiter //

create function media_livros_por_editora() returns decimal(10,2)
begin
    declare done int default 0;
    declare editora_id int;
    declare total_livros int default 0;
    declare total_editoras int default 0;
    declare media decimal(10,2) default 0.0;

    declare curso_editoras cursor for
    select ID from Editora;

    open curso_editoras;
    fetch_loop: loop
        fetch curso_editoras into///
      editora_id;
        if done = 1 then
            leave editoras_loop;
        end if;

        declare curso_livros curso for
        select count(*) from Livro where EditoraID = editora_id;
        open curso_livros;
        fetch curso_livros into total_livros;
        close curso_livros;

        set total_editoras = total_editoras + total_livros;
    end loop;
    close curso_editoras;

    if total_editoras > 0 then
        set media = total_editoras / (select count(*) from Editora);
    end if;
    return media;
end //

delimiter ;

-- Exercicio 5

delimiter //

create function autores_sem_livros()
returns text
begin
    declare done INT DEFAULT 0;
    declare autor_id INT;
    declare autores_sem_livros_texto TEXT default '';
    declare curso_autores cursor for
    select ID, CONCAT(PrimeiroNome, ' ', UltimoNome) AS NomeAutor from Autor;

    open curso_autores;
    fetch_loop: loop
        fetch curso_autores into autor_id, NomeAutor;
        if done = 1 then
            leave fetch_loop;
        end if;

        declare curso_verificar_livros cursor for 
        select ID from Livro_Autor where AutorID = autor_id limit 1;
        declare possui_livros INT default 0;

        open curso_verificar_livros;
        fetch curso_verificar_livros into possui_livros;
        close curso_verificar_livros;

        -- Se o autor não possui livros, adicione à lista
        if possui_livros is null then
            set autores_sem_livros_texto = concat(autores_sem_livros_texto, NomeAutor, ', ');
        end if;
    end loop;

    close cur_autores;
    set autores_sem_livros_texto = left(autores_sem_livros_texto, LENGTH(autores_sem_livros_texto) - 2);
    return autores_sem_livros_texto;
end //

delimiter ;
