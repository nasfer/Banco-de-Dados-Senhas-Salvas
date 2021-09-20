/* BANCO DE DADOS QUAL GUARDARÁ AS SENHAS EM QUE USUÁRIOS CADASTRAM EM SITES POR EXEMPLO,
	BD CONSISTE DE TABELAS, SENDO TABELA DE CADASTRO E TABELA DE SENHAS*/



create schema db_senhas_usuarios;
use  db_senhas_usuarios;


create table db_senhas_usuarios.tbCadastro(

id int auto_increment,
nome_usuario varchar (120) not null,
email_usuario varchar (120) not null,

primary key(id)

);



create table db_senhas_usuarios.tb_senhas(

id_senha int auto_increment,
id_usuario int not null,
senha varchar (120) not null,

primary key(id_senha),
foreign key (id_usuario) references db_senhas_usuarios.tbCadastro(id)

);





-- SELECT --

select * from db_senhas_usuarios.tbCadastro;
select * from  db_senhas_usuarios.tb_senhas;



-- DROP --

drop table db_senhas_usuarios.tbCadastro;
drop table db_senhas_usuarios.tb_senhas;