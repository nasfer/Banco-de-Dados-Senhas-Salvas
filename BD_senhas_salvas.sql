/* BANCO DE DADOS QUAL GUARDARÁ AS SENHAS EM QUE USUÁRIOS CADASTRAM EM SITES POR EXEMPLO,
	BD CONSISTE DE TABELAS, SENDO TABELA DE CADASTRO E TABELA DE SENHAS*/

set @@autocommit = OFF;


create schema db_senhas_usuarios; -- CRIA O SCHEMA
use  db_senhas_usuarios; -- COLOCA ELE PARA SER USADO


create table db_senhas_usuarios.tb_cadastro(

id int,
nome_usuario varchar (120) not null,
email_usuario varchar (120) not null,

primary key(id)

);



create table db_senhas_usuarios.tb_senhas(

id_senha int not null,
id_usuario int not null,
senha varchar (120) not null,

primary key(id_senha),
foreign key (id_usuario) references db_senhas_usuarios.tb_cadastro(id)

);


/* ABAIXO USA-SE O DELIMITER, ASSIM PODE-SE EXECUTAR DENTRO DESTE ESPAÇO AS CONDIÇÕES A SEREM CRIADAS */


/* ABAIXO TEM-SE O PRIMEIRO STORE PROCEDURE, ESTE É RESPONSÁVEL POR RECEBER PARAMETROS DO CALL 
	VOCÊ NÃO DEVE USAR O [NOT NULL]*/
    
    
/* APÓS O BEGIN PODE-SE CRIAR AS CONDIÇÕES NECESSÁRIAS PARA AVALIAR.
	NESTE CASO VAMOS ANALISAR SE O E-MAIL DO USUÁRIO ESTÁ CADASTRADO NO BANCO DE DADOS
    PARA ESTE PROJETO ENTENDA-SE QUE O USUÁRIO JÁ TENHA FEITO O CADASTRO*/

-- VOCÊ PODE DEFINIR OUTRO CARACTER COMO DELIMITADOR, MAS DEVE ENCERRAR ELE DEPOIS    
 
/* O START TRANSACTION É UMA "FORMA" SEGURA DE VOCÊ INICIAR UMA TRANSAÇÃO SEM MANIPULAR DIRETAMENTE
	OS DADOS DENTRO DO BANCO DE DADOS, OU SEJA, QUALQUER SITUAÇÃO QUE NÃO SATISFAÇA AS CONDIÇÕES NÃO
    CAUSARÁ DANOS NO SEU BANCO DE DADOS, LEMBRE DE USAR O ROLLBACK */

delimiter $$ 
create procedure sp_salvar_senha(email varchar(120),senha_recebe varchar(120))    
begin

declare identificador int;

start transaction;

	if exists(select email_usuario, id from db_senhas_usuarios.tb_cadastro where email = email_usuario) then
	   		
		insert into db_senhas_usuarios.tb_senhas (id_senha, id_usuario, senha) values (1, id, senha_recebe);
		commit;
		select 'Senha inserida com sucesso.' AS INFORMACAO;
		
	else
		rollback;
		select 'Este usuário não possui cadastro.' AS INFORMACAO;
		
	end if;

end $$

delimiter ;



-- INSERT --

insert into db_senhas_usuarios.tb_cadastro values (1,'Roberto', 'roberto@roberto.com');
insert into db_senhas_usuarios.tb_cadastro values (2,'Paula', 'paula@paula.com');
insert into db_senhas_usuarios.tb_cadastro values (3,'Carlos', 'carlos@carlos.com');


-- CALL --

call sp_salvar_senha ('roberto@roberto.com', '123');

-- SELECT --

select * from db_senhas_usuarios.tbCadastro;
select * from  db_senhas_usuarios.tb_senhas;
select email_usuario, id from db_senhas_usuarios.tb_cadastro where email_usuario = 'roberto@roberto.com';


-- DROP --

drop table db_senhas_usuarios.tbCadastro;
drop table db_senhas_usuarios.tb_senhas;
drop procedure sp_salvar_senha;