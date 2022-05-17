create database sptech;
use sptech;

-- Vamos criar primeiro a tabela Curso, porque
-- depois vamos criar a tab Aluno, e já configurar
-- a fkCurso no create table da tab Aluno
create table Curso (
  idCurso int primary key auto_increment,
  nome char(3),
  coordenador varchar(30)
) auto_increment = 100;

-- Agora sim, vamos criar a tabela Aluno, já 
-- configurando a fkCurso
create table Aluno (
  ra int primary key auto_increment,
  nome varchar(40),
  bairro varchar(30),
  fkCurso int, 
  foreign key(fkCurso) references Curso(idCurso)
) auto_increment = 50000;

-- Vamos inserir dados primeiro na tab Curso
insert into Curso (nome, coordenador) values
            ('ADS', 'Gerson'),
            ('CCO', 'Marise'),
            ('SIS', 'Alex');

-- Exibir os dados da tab Curso
select * from Curso;

-- Inserindo os dados dos alunos
insert into Aluno (nome, bairro, fkCurso) values
          ('Maria', 'Saúde',102),            
          ('José', 'Tatuapé',102),            
          ('Paulo', 'Jabaquara',100),            
          ('Cláudia', 'Mooca',101); 

-- Exibindo os dados da tabela Aluno
select * from Aluno;

-- Exibir os dados dos alunos e dos cursos correspondentes
-- JEITO ERRADO
select * from Aluno, Curso;
-- JEITO CORRETO
select * from Aluno, Curso where fkCurso = idCurso;

-- Exibir os dados dos alunos e dos cursos correspondentes
-- mas somente do curso 'SIS'
select * from Aluno, Curso where fkCurso = idCurso
                             and idCurso = 102;
-- idem ao anterior, mas informando o nome do curso
-- é preciso colocar Curso.nome para resolver a ambiguidade                             
select * from Aluno, Curso where fkCurso = idCurso
                             and Curso.nome = 'SIS';
-- Exibir os dados dos alunos e dos cursos correspondentes
-- mas sem repetir a informação da fkCurso
select ra, Aluno.nome, bairro, idCurso, Curso.nome,
    coordenador from Aluno, Curso where fkCurso=idCurso;                              
select ra, Aluno.nome, bairro, Curso.*
              from Aluno, Curso where fkCurso=idCurso;                              
select Aluno.*,Curso.nome, coordenador
              from Aluno, Curso where fkCurso=idCurso;
              
-- Vamos criar um tabela Grupo
create table Grupo (
  idGrupo int primary key auto_increment,
  nomeGrupo char(7),
  tipoSensor varchar(30)
);

-- Inserindo dados na tabela Grupo
insert into Grupo (nomeGrupo, tipoSensor) values
         ('Grupo01', 'umidade'),
         ('Grupo02', 'temperatura'),
         ('Grupo03', 'luminosidade'),
         ('Grupo04', 'proximidade');

-- Exibindo os dados dos grupos
select * from Grupo;

-- Exibindo os dados dos alunos
select * from Aluno;

-- Adicionando uma coluna fkGrupo na tabela Aluno
alter table Aluno add fkGrupo int;
-- Configurando a coluna fkGrupo para ser de fato uma FK
alter table Aluno 
   add foreign key(fkGrupo) references Grupo(idGrupo);

-- Os 2 comandos acima poderiam ser feitos de uma vez só:   
alter table Aluno add fkGrupo int,
   add foreign key(fkGrupo) references Grupo(idGrupo);

-- Exibindo os dados da tabela Aluno
select * from Aluno;

-- Atualizando os nulls da coluna fkGrupo
update Aluno set fkGrupo = 1 where ra <= 50001;   
update Aluno set fkGrupo = 7 where ra = 50002;  -- esse comando dá erro
update Aluno set fkGrupo = 2 where ra = 50002;
update Aluno set fkGrupo = 3 where ra = 50003;

-- inserindo um novo aluno
-- o comando abaixo dá um erro, pq não existe idGrupo = 7
insert into Aluno values
    (null, 'Pedro', 'Consolação', 101,7);
insert into Aluno values
    (null, 'Pedro', 'Consolação', 101,4);
    
-- Exibir os dados das 3 tabelas de forma correspondente
select * from Aluno, Curso, Grupo
      where fkCurso = idCurso and fkGrupo = idGrupo;  
         
         
-- parte nova 17/05
-- aplicando join (inner, left, right)

-- Exibir os dados dos alunos e correspondentes com JOIN
select * from Aluno join Curso on fkCurso = idCurso;

-- Exibir os dados dos alunos e correspondentes com JOIN mas somente de um curso
select * from Aluno join Curso on fkCurso = idCurso where Curso.nome = 'SIS';

-- Exibir os dados dos alunos, dos cursos e dos grupos correspondentes com JOIN
select * from Aluno join Curso on fkCurso = idCurso
					join Grupo on fkGrupo = idGrupo;
                    
-- evitar fazer desse jeito a seguir pois não é uma boa prática, fácil de se cometer erros e não
-- tem uma boa aparencia

select * from Aluno join Curso join Grupo on fkCurso = idCurso
											and fkGrupo = idGrupo;

-- inserindo um aluno que não está matriculado em nenhum curso
insert into Aluno values (null, 'Mickey', 'Disney', null, null);

-- inserindo um curso em que não existe alunos matriculados
insert into Curso values (null, 'ADM', 'Monica');

-- Exibir os dados dos alunos e dos cursos correspondentes, mas de forma que apareça tambem
-- os alunos que não estão matriculados
select * from Aluno left join Curso on fkCurso = idCurso;

-- mundando a ordem de exibição usando o 'right join'
select * from Aluno right join Curso on fkCurso = idCurso;


-- Exibir os dados dos alunos e dos cursos correspondentes, mas de forma que apareça tambem
-- de forma que apareça tambem os cursos que não tem aluno matriculado
select * from Aluno left join Curso on fkCurso = idCurso;
select * from Curso left join Aluno on fkCurso = idCurso;


-- exibe todos os alunos e todos os cursos
-- equivalente ao full outer join (não existe no MySql Server)
select * from Aluno left join Curso on fkCurso = idCurso
	union
select * from Aluno right join Curso on fkCurso = idCurso;
