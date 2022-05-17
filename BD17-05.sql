create database BD17_05;

use BD17_05;

create table Aluno(
idAluno int primary key,
nome varchar(45) not null,
email varchar(45) not null unique,
fkGrupo int,
foreign key (fkGrupo) references Grupo (idGrupo)
);

create table professor(
idProfessor int primary key auto_increment,
nome varchar(45) not null,
disciplina varchar(45) not null
) auto_increment = 1000;

create table Grupo (
idGrupo int primary key auto_increment,
nome varchar (45) not null unique,
descricao varchar (45)
);

create table avaliacao(
fkProfessor int,
foreign key (fkProfessor) references professor (idProfessor),
fkGrupo int,
foreign key (fkGrupo) references Grupo (idGrupo),
dataHora datetime,
primary key (fkProfessor, fkGrupo, datahora),
nota decimal(3,1) not null
);

insert into Grupo (nome, descricao) values
('SPmonitore', 'controle de espaços'),
('Cogulovers', 'controle de temperatura de cogumelos'),
('Queijadinha', 'controle de temperatura de frios'),
('Avocados', 'controle de Temperatura de abacates');

insert into aluno (idAluno, nome, email, fkgrupo) values
(101,'Camila', 'Camila@gmail.com', 1),
(102, 'Thais', 'Thais@gmail.com', 1),
(103, 'Viego', 'Viego@gmail.com', 2),
(104, 'Tristana', 'Tristana@gmail.com', 2),
(105, 'Talon', 'Talon@gmail.com', 3),
(106, 'Yone', 'Yone@gmail.com', 4),
(107, 'Seraphine', 'Seraphine@gmail.com', 3),
(108, 'Valquiria', 'Valquiria@gmail.com', 4);

insert into professor (nome, disciplina) values
('marise', 'Arq. Comp'),
('Célia', 'Banco de dados'),
('Monika', 'TI'),
('Yoshi', 'Algoritmo'),
('Brandão', 'PI');

insert into avaliacao (fkprofessor, fkgrupo, datahora, nota) values
(1000, 1, '2022-05-04 17:00', 7.5),
(1001, 1, '2022-05-04 17:00', 8),
(1002, 2, '2022-05-08 19:00', 9.5),
(1003, 2, '2022-05-08 19:00', 10),
(1004, 3, '2022-05-12 08:00', 5.5),
(1000, 3, '2022-05-12 08:00', 8),
(1001, 4, '2022-05-14 13:00', 4),
(1004, 4, '2022-05-14 13:00', 2.5);

select * from avaliacao;

-- 5. Exibir os dados dos grupos e os dados de seus respectivos alunos

select * from grupo, aluno 
		where fkgrupo = idgrupo;

-- 6. Exibir os dados de um determinado grupo e os dados de seus respectivos alunos.

select * from grupo, aluno 
		where fkgrupo = idgrupo 
			and idgrupo = 1;

-- 7. Exibir a média das notas atribuídas aos grupos, no geral.

select avg(nota) from avaliacao;

select min(nota), max(nota) from avaliacao;

select sum(nota) from avaliacao;

select professor.nome, professor.disciplina, grupo.nome, grupo.descricao, avaliacao.datahora
			from professor, grupo, avaliacao
				where fkgrupo = idgrupo and fkprofessor = idprofessor;

select professor.nome, professor.disciplina, grupo.nome, grupo.descricao, avaliacao.datahora
			from professor, grupo, avaliacao
				where fkgrupo = idgrupo and fkprofessor = idprofessor
					and idgrupo = 3;
                    
select grupo.nome, professor.nome from professor, grupo, avaliacao
	where idgrupo = fkgrupo 
		and idprofessor = fkprofessor
			and idprofessor = 1000;
            
select grupo.nome, grupo. descricao, aluno.nome, aluno.email, professor.nome, professor.disciplina, avaliacao.datahora
				from grupo, aluno, professor, avaliacao
					where idgrupo = aluno.fkgrupo
						and idgrupo = avaliacao.fkgrupo
							and fkprofessor = idprofessor;
                            
select distinct nota from avaliacao;         

select professor.nome, avg(nota), sum(nota) 
	from avaliacao, professor 
		group by Professor.nome;
        

select grupo.nome, avg(nota), sum(nota) 
	from avaliacao, grupo 
		group by grupo.nome;                   
        
select professor.nome, min(nota), max(nota) 
	from avaliacao, professor 
		group by Professor.nome;
        
select grupo.nome, min(nota), max(nota) 
	from avaliacao, grupo 
		group by grupo.nome;        