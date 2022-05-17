create database Exemplo_EntidadeFraca_Recursivo;
use Exemplo_EntidadeFraca_Recursivo;

-- Criação da tab Funcionario, já com a fkSupervisor do 
-- relacionamento recursivo
create table Funcionario (
  idFuncionario int primary key auto_increment,
  nomeFuncionario varchar(45),
  salario decimal (7,2),
  constraint CkSalario check (salario > 0),
  sexo char(1) check (sexo = 'm' or sexo = 'f' or sexo = 'n'),
  fkSupervisor int,
  constraint Funcionario_fkSupervisor foreign key(fkSupervisor)
  references Funcionario(idFuncionario)
) auto_increment = 1000;

-- Criação da tab Dependente - essa tabela é uma ENTIDADE FRACA
create table Dependente (
  fkFuncionario int,
  foreign key(fkFuncionario) references Funcionario(idFuncionario),
  idDependente int,  -- NÃO COLOCAR PRIMARY KEY AQUI NEM AUTO_INCREMENT
  primary key(fkFuncionario, idDependente),  -- CHAVE PRIMÁRIA COMPOSTA
  nomeDependente varchar(45),
  tipo varchar(45),
  dataNascimento date
);

-- Inserir dados dos funcionários
insert into Funcionario values
      (null, 'João Nunes', 30000, 'm', null),  
      (null, 'Cláudio Silva', 20000, 'm', 1000),
      (null, 'Ana Teixeira', 18000, 'f', 1000),
      (null, 'Pedro Sousa', 12000, 'm', 1001),
      (null, 'Maria Ferreira', 10000, 'f', 1002);

-- Exibir os dados da tabela Funcionario
select * from Funcionario;

-- Inserir dados da tabela Dependente
-- O 2o campo é o idDependente, que começa com o valor 1 para cada fkFuncionario diferente
insert into Dependente values 
      (1000, 1, 'Joana Nunes', 'cônjuge', '1990-06-07'),
      (1000, 2, 'Juan Nunes', 'filho', '2010-03-06'),
      (1001, 1, 'Cláudia Silva', 'cônjuge', '1995-08-10'),
      (1001, 2, 'Claudete Silva', 'filha', '2012-09-05'),
      (1002, 1, 'Anilson Teixeira', 'cônjuge', '2000-11-09');

-- Exibir os dados da tab Dependente
select * from Dependente;

-- Exibir os dados dos funcionários e dos seus dependentes
select * from Funcionario, Dependente where fkFuncionario = idFuncionario;      

-- Exibir os dados dos funcionários e dos seus dependentes, mas somente de um funcionario
select * from Funcionario, Dependente where fkFuncionario = idFuncionario and nomeFuncionario = 'João Nunes';      

-- Exibir os dados dos funcionários e dos seus supervisores
select * from Funcionario as funcionario, 
              Funcionario as supervisor
        where funcionario.fkSupervisor = supervisor.idFuncionario;

-- Exibir os dados dos funcionários e dos seus supervisores
-- e dos dependentes dos funcionários
select * from Funcionario as funcionario, 
              Funcionario as supervisor,
              Dependente
        where funcionario.fkSupervisor = supervisor.idFuncionario
		  and fkFuncionario = funcionario.idFuncionario;
          
-- Exibir os dados dos funcionários e dos seus supervisores
-- e dos dependentes dos supervisores
select * from Funcionario as funcionario, 
              Funcionario as supervisor,
              Dependente
        where funcionario.fkSupervisor = supervisor.idFuncionario
		  and fkFuncionario = supervisor.idFuncionario;
          
   -- Exibir os dados dos funcionários e dos seus supervisores
select * from Funcionario as f, Funcionario as s
        where f.fkSupervisor = s.idFuncionario;
       
          -- parte nova 17/05 com join
          
-- Exibir os funcionarios e os seus dependentes com join
select * from Funcionario join Dependente on fkFuncionario = idFuncionario;

-- Exibir os funcionarios e os seus dependentes com join, mas tambem aparecer os funcionarios que não tem dependentes
select * from Funcionario left join Dependente on fkFuncionario = idFuncionario;

-- Exibir os funcionarios e seus supervisores com JOIN
select * from Funcionario as Supervisor inner join Funcionario as funcionario
													 on funcionario.fkSupervisor = supervisor.idFuncionario;

-- Exibir os funcionarios e seus supervisores com JOIN
-- mas de forma que tambem apareça os funcionarios que não tem supervisor
select * from Funcionario as funcionario left join
Funcionario as supervisor
on funcionario.fkSupervisor = supervisor.idFuncionario;

-- Exibir os funcionarios, seus dependentes e seus supervisores
select * from Funcionario as funcionario inner join
Funcionario as supervisor
on funcionario.fkSupervisor = supervisor.idFuncionario join Dependente 
on Dependente.fkFuncionario =  Funcionario.idFuncionario;

-- Exibir os funcionarios, seus supervisores e seus dependentes com JOIN
-- incluindo os funcionarios que não tem dependente
select * from Funcionario as funcionario inner join
Funcionario as supervisor
on funcionario.fkSupervisor = supervisor.idFuncionario left join Dependente 
on Dependente.fkFuncionario =  Funcionario.idFuncionario;

-- Exibir os funcionarios, seus supervisores e seus dependentes com JOIN
-- incluindo os funcionarios que não tem dependente
-- e os funcionarios que não tem supervisor
select * from Funcionario as funcionario left join
Funcionario as supervisor
on funcionario.fkSupervisor = supervisor.idFuncionario left join Dependente 
on Dependente.fkFuncionario =  Funcionario.idFuncionario;
