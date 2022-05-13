/* 1: */
SELECT      numero_departamento,      AVG(salario) AS media_salarial
       FROM funcionario 
       GROUP BY numero_departamento;

/* 2: */
SELECT sexo, AVG(salario) AS media_por_sexo
FROM funcionario
GROUP BY sexo;

/* 3: */
SELECT CONCAT(primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo, 
              data_nascimento, 
       AGE   (data_nascimento, current_date)               AS idade, 
              salario                                      AS relatorio_funcionario
       FROM   funcionario; 

/* 4: */
SELECT CONCAT(primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo, 
       AGE   (data_nascimento, current_date)               AS idade, 
              salario                                      AS salario_atual,
       CASE  
            WHEN salario < 35000 THEN salario * 1.2
            ELSE salario * 1.15
            END                                            AS reajuste
       FROM      funcionario;

/* 5 */
SELECT     nome_departamento,
CASE   
     WHEN      departamento.cpf_gerente = funcionario.cpf THEN 'Gerente'
     ELSE      'Funcionario'
END            Cargo,
     CONCAT    (primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo,
               salario
     FROM      funcionario, departamento
     WHERE     funcionario.numero_departamento = departamento.numero_departamento
     ORDER BY  nome_departamento ASC,
               salario DESC;

/* 6: */
SELECT DISTINCT     
CONCAT(primeiro_nome,' ',nome_meio,' ',ultimo_nome)             AS funcionario,
       numero_departamento,
CONCAT(dependente.nome_dependente,' ',nome_meio,' ',ultimo_nome)AS nome_completo_dependente,                                                                                                  
   AGE(dependente.data_nascimento, current_date)                AS idade,                                  
   CASE                      
       WHEN 'F' THEN 'Feminimo'
       ELSE 'Masculino'
   END "sexo_dependente"
       FROM                  funcionario
       INNER JOIN            dependente     ON (funcionario.cpf = dependente.cpf_funcionario);


/* 7: */
SELECT DISTINCT CONCAT      (primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo,
                            numero_departamento,
                            salario                       
       FROM                 funcionario
       EXCEPT
SELECT DISTINCT CONCAT      (primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo,
                            numero_departamento,
                            salario                       
       FROM                 funcionario
       INNER JOIN           dependente     ON(funcionario.cpf = dependente.cpf_funcionario);

/* 8: */
SELECT         numero_departamento, 
               numero_projeto, 
CONCAT        (primeiro_nome,' ', nome_meio,' ',ultimo_nome) AS nome_completo, 
               horas 
FROM           funcionario
INNER JOIN     trabalha_em      ON(funcionario.cpf = trabalha_em.cpf_funcionario);
                     
/* 9: */           
SELECT             nome_projeto, nome_departamento,
SUM(horas)  AS     horas_totais  
FROM               trabalha_em, projeto,departamento
WHERE              trabalha_em.numero_projeto = projeto.numero_projeto
AND                departamento.numero_departamento = projeto.numero_departamento
GROUP BY           projeto.nome_projeto, departamento.numero_departamento;

/* 10: */ 
SELECT       numero_departamento,
AVG         (salario) AS media_salarial 
FROM         funcionario
GROUP BY     numero_departamento;

/* 11: */                
SELECT DISTINCT CONCAT (primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo,
                       nome_projeto,
                       horas * 50  AS tem_dinheiro   
FROM                   projeto, funcionario, trabalha_em
WHERE                  trabalha_em.cpf_funcionario = funcionario.cpf
AND                    trabalha_em.numero_projeto = projeto.numero_projeto;

/* 12: */    
SELECT         nome_departamento,
               nome_projeto, 
               primeiro_nome, 
               horas
FROM           funcionario
INNER JOIN     departamento
ON             funcionario.numero_departamento = departamento.numero_departamento
INNER JOIN     projeto
ON             departamento.numero_departamento = projeto.numero_departamento
INNER JOIN     trabalha_em
ON             projeto.numero_projeto = trabalha_em.numero_projeto
WHERE          horas = 0;

/* 13: */
SELECT DISTINCT        nome_dependente AS aniversariantes,                     
                       sexo,
                   AGE (data_nascimento, current_date)        AS idade
FROM                    dependente
UNION 
SELECT DISTINCT         primeiro_nome AS aniversariantes,
                        sexo,
                   AGE (data_nascimento, current_date)        AS idade
FROM                    funcionario
ORDER BY           idade DESC;

/* 14: */
SELECT     numero_departamento,
           COUNT (cpf) AS funcionarios
FROM       funcionario
WHERE      funcionario.numero_departamento <> 0
GROUP BY   numero_departamento;

/* 15: */
SELECT     CONCAT (primeiro_nome,' ',nome_meio,' ',ultimo_nome) AS nome_completo,
                   funcionario.numero_departamento,
                   projeto.nome_projeto
FROM               funcionario, projeto
WHERE              funcionario.numero_departamento = projeto.numero_departamento
ORDER BY           nome_projeto;

     



        

       