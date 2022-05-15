/*Criando usuário */
create user arthurg identified by '123';

/*Dando todos privilégios ao usuário no banco de dados uvv */
grant all privileges on uvv.* to arthurg;

/*Criando o banco de dados uvv */
create database uvv;

/*Usando o banco de dados uvv como usuário */
use uvv;


/* Criando tabela funcionário */
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50), 
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11),
                PRIMARY KEY (cpf)
);

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) COMMENT 'CPF do funcionário.';
ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) COMMENT 'Primeiro nome.';
ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio.';
ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) COMMENT 'Último nome do.';
ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do funcionário.';
ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(50) COMMENT 'Endereço.';
ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'Inicial do sexo.';
ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'Salário.';
ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) COMMENT 'CPF do supervisor. É uma FK dela mesmo, por que o supervisor é tambem um funcionario.';

/* Criando tabela departamento */
CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento.';
ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) COMMENT 'Nome do departamento.';
ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'Data de início do gerente do departamento.';
ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) COMMENT 'CPF do gerente do departamento. É uma FK para a tabela gerente.';

/* Criando chave alternativa nome_departamento em departamento */
CREATE UNIQUE INDEX nome_departamento_idx
 ON departamento
 ( nome_departamento );

/* Criando tabela localizacão do departamento */
CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(20) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É uma FK para departamento.';
ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) COMMENT 'Localização do departamento.';

/* Criando tabela projeto */
CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(20) NOT NULL, 
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER COMMENT 'Número do projeto.';
ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(20) COMMENT 'Nome do projeto e unico por isso é uma ak.';
ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER COMMENT 'Número do departamento. É uma FK para a tabela departamento.';
ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'Localização.';

/* Criando chave alternativa nome_projeto em projeto */
CREATE UNIQUE INDEX nome_projeto_idx
 ON projeto
 ( nome_projeto );

/* Criando tabela trabalha em */
CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. É uma FK da tabela funcionário.';
ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) COMMENT 'Horas trabalhadas.';
ALTER TABLE trabalha_em MODIFY COLUMN numero_departamento INTEGER COMMENT 'Numero do departamento. É uma FK da tabela departamento';

/* Criando tabela dependente */
CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(8),
                PRIMARY KEY (nome_dependente, cpf_funcionario)
);

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) COMMENT 'Nome do dependente.';
ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) COMMENT 'CPF do funcionário. É uma FK da tabela funcionário.';
ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do dependente.';
ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do dependente.';
ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(8) COMMENT 'Parentesco entre dependente e funcionário.';


/* Criando chave estrangeira cpf_supervisor na tabela funcionario */
ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Criando chave estrangeira cpf_funcionario na tabela dependente */
ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Criando chave estrangeira numero_departamento na tabela projeto */
ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Criando chave estrangeira numero_departamento na tabela funcionario */
ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Criando chave estrangeira numero_departamento na tabela trabalha_em */
ALTER TABLE trabalha_em ADD CONSTRAINT departamento_trabalha_em_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Criando chave estrangeira numero_projeto na tabela trabalha_em */
ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

/* Adicionando restrições de gênero na tupla sexo da tabela funcionario */
ALTER TABLE funcionario ADD CONSTRAINT CHK_funcionario CHECK
((sexo = 'F' OR sexo = 'M')AND salario >= 0);

/* Adicionando restrições de gênero na tupla sexo da tabela dependente */
ALTER TABLE dependente ADD CONSTRAINT CHK_dependente CHECK
(sexo = 'F' OR sexo = 'M');

/* Adicionando restrição de hora não poder ser número nagativo na tupla horas da tabela trabalha_em */
ALTER TABLE trabalha_em ADD CONSTRAINT CHK_trabalha_em CHECK 
(horas >= 0);

/* Inserindo dados na tabela funcionario */
INSERT INTO funcionario VALUES
('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL),
('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, '88866555576'),
('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, '33344555587'),
('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, '33344555587'),
('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, '33344555587'),
('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576'),
('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168'),
('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, '98765432168');

/* Inserindo dados na tabela dependente */
INSERT INTO dependente VALUES
('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaína', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

/* Inserindo dados na tabela departamento */
INSERT INTO departamento VALUES
(5, 'Pesqusia', '33344555587', '1988-05-22'),
(4, 'Administração', '98765432168', '1995-01-01'),
(1, 'Matriz', '88866555576', '1981-06-19');

/* Inserindo dados na tabela localização do departamento */
INSERT INTO localizacoes_departamento VALUES
(1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');

/* Inserindo dados na tabela projeto */
INSERT INTO projeto VALUES
(1, 'Produto X', 'Santo André', 5),
(2, 'Produto Y', 'Itu', 5),
(3, 'Produto Z', 'São Paulo', 5),
(10, 'Informatização', 'Mauá', 4),
(20, 'Reorganiazãço', 'São Paulo', 1),
(30, 'Novos benefícios', 'Mauá', 4);

/* Inserindo dados na tabela trabalha em */
INSERT INTO trabalha_em VALUES
('12345678966', 1, 32.5, 5),
('12345678966', 2, 7.5, 5),
('66688444476', 3, 40, 5),
('45345345376', 1, 20, 5),
('45345345376', 2, 20, 5),
('33344555587', 2, 10, 5),
('33344555587', 3, 10, 5),
('33344555587', 10, 10, 4),
('33344555587', 20, 10, 1),
('99988777767', 30, 30, 4),
('99988777767', 10, 10, 4),
('98798798733', 10, 35, 4),
('98798798733', 30, 5, 4),
('98765432168', 30, 20, 4),
('98765432168', 20, 15, 1),
('88866555576', 20, 0, 1);
