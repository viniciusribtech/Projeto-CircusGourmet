/*==========================================
                Consultas
  ==========================================*/

/*1. Liste os eventos que ainda não pagaram o sinal (taxa de agendamento), mas a data está a menos de 10 dias de distância.*/
SELECT data_evento
FROM Evento
WHERE status = 'Pendente'
AND data_evento BETWEEN CURDATE() 
                      AND DATE_ADD(CURDATE(), INTERVAL 10 DAY);

/*2. Quais cidades concentram o maior volume de eventos contratados para os próximos 30 dias?*/
SELECT C.id_cidade, COUNT(E.id_evento) AS total_eventos
FROM Cidade C
JOIN Evento E
ON C.id_cidade = E.fk_Cidade_id_cidade
WHERE E.data_evento BETWEEN CURDATE()
                        AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
GROUP BY C.id_cidade
ORDER BY total_eventos DESC
LIMIT 1;

/*3. Qual o volume total de orçamentos gerados para eventos com o status de “cancelado”?*/
SELECT SUM(O.valor_total) AS TotalOrcamentosCancelados
FROM Evento E
JOIN Orcamento O
ON E.id_evento = O.fk_Evento_id_evento
WHERE E.status = 'Cancelado';

/*4. Dos tipos de serviços oferecidos, quais estiveram presentes em mais de 70% dos eventos realizados no ano, sendo os ‘carros-chefes’ da empresa? */
SELECT ES.FK_Servico_id_servico,
       COUNT(DISTINCT ES.FK_Evento_id_evento) AS eventos_com_servico
FROM EVENTO_SERVICO ES
JOIN Evento E
ON ES.FK_Evento_id_evento = E.id_evento
WHERE YEAR(E.data_evento) = 2026
GROUP BY ES.FK_Servico_id_servico
HAVING COUNT(DISTINCT ES.FK_Evento_id_evento) > (
    SELECT COUNT(*) * 0.7
    FROM Evento
    WHERE YEAR(data_evento) = 2026
);

/*5.  Quais produtos (ex: Açaí vs Pipoca) foram os mais solicitados nos últimos 6 meses?*/
SELECT P.id_produto,
       P.nome,
       SUM(SP.quantidade_insumo) AS total_solicitado
FROM Produto P
JOIN SERVICO_PRODUTO SP
ON P.id_produto = SP.FK_Produto_id_produto
JOIN Servico S
ON SP.FK_Servico_id_servico = S.id_servico
JOIN EVENTO_SERVICO ES
ON S.id_servico = ES.FK_Servico_id_servico
JOIN Evento E
ON ES.FK_Evento_id_evento = E.id_evento
WHERE E.data_evento >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY P.id_produto, P.nome
ORDER BY total_solicitado DESC;