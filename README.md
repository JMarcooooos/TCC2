<p align="center">
  <img src="www/icone.png" alt="Logo do Projeto" width="200">
</p>

# Redefinindo a Inflação de Zeros no ENEM: Uma Abordagem Bayesiana e Causal

Este projeto nasceu do desejo de revisitar meu Trabalho de Conclusão de Curso (TCC) sob uma nova ótica.
Meu tema de Trabalho de Conclusão de Curso foi: [`Inflação de Zeros nas Notas da Redação do ENEM: Comparação entre o Modelo Beta Inflacionado em Zero e o Modelo de Barreira`][1], entretanto eu não curti muito como ficou o trabalho final, que, embora concluído com êxito, foi desenvolvido sob as pressões típicas do fim de graduação. Hoje, com maior maturidade estatística e novos interesses, meu objetivo é transformar aquele estudo em um artigo de alto nível.

---

## O Problema Original
Em grandes bases de dados educacionais, é comum observar uma concentração desproporcional de notas zero (devido a fugas ao tema, folhas em branco, etc.), o que exige modelos que não ignorem essa característica. No trabalho, conclui que era melhor utilizar modelos hurdle ao invés de zero-inflated devido a natureza do processo gerador de dados, e com base nos diagnosticos dos modelos, desde aquela época eu já me preocupava com as suposições de geração dos dados e não apenas com rodar o modelo, mereço esse crédito, pois hoje em dia, é o grande trunfo que quero inserir neste trabalho, pensar em investigar as relações das variáveis do questionário socio-econômico com a ótica da Inferência Causal, e desenhar o melhor modelo gerador possível pra esses dados, e entender as causas e intensidades de aumento na Nota da Redação do ENEM de forma apropriada, robusta e transparente.



[1]:[https://repositorio.bc.ufg.br//handle/ri/29518]

---

## O que muda agora?

A nova fase deste projeto abandona a abordagem puramente frequentista, focada em `gamlss`, e foca em duas frentes poderosas e flexíveis da estatística moderna

### 1. Inferência Causal
O objetivo não é apenas descrever a inflação de zeros, mas entender o que a causa através de Gráficos Acíclicos Dirigidos (DAGs), o que não foi feito e é o maior erro no trabalho anterior, pois os coeficientes foram interpretados como efeitos causais unicamente com base em correlações que podem ou não terem sofrido viéses (De Seleção, Colisor, Mediador etc.), pretendo investigar as relações de causa e efeito entre variáveis socioeconômicas e a probabilidade de uma nota zero.

### 2. Modelagem Bayesiana
Em vez de estimativas pontuais, utilizarei distribuições a priori para incorporar conhecimento prévio e obter incertezas mais ricas sobre os parâmetros de inflação e da parte contínua, bem como tratar de forma apropriada as notas nas demais provas do ENEM, que na verdade são estimativas de um modelo TRI, com erro de medida, através da função `me()` do pacote `{brms}`. A modelagem através de um modelo bayesiano é infinitamente mais flexível, e as interpretações são extremamente mais informativas para sustentarem as conclusões da inferência causal, bem como vou focar bastante nos diagnósticos dos modelos assim como fiz no trabalho anterior.

---

##  Objetivos do Projeto

- [ ] Selecionar as Variáveis que desejo investigar impacto na Nota da Redação através de uma Análise Exploratória.
- [ ] Refazer o pré-processamento dos dados do ENEM com técnicas mais eficientes.
- [ ] Elaborar o DAG global.
- [ ] Segmentar as variáveis em Socio-Econômicas e Notas nas demais provas e modelar dentro desses blocos.
- [ ] Implementar o modelo BEZI em um framework Bayesiano para CADA variável de interesse.
- [ ] Validação de modelos e comparação (PSIS para substituir LOO-CV).
- [ ] Contra Factuais (do-calculus).
- [ ] Construir uma narrativa de inferência causal para explicar o fenômeno educacional.
- [ ] Redigir o artigo final para submissão.

---
