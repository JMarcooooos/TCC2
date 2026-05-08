<p align="center">
  <img src="www/icone.png" alt="Logo do Projeto" width="200">
</p>

# Redefinindo a Inflação de Zeros no ENEM: Uma Abordagem Bayesiana e Causal

Este projeto nasceu do desejo de revisitar meu Trabalho de Conclusão de Curso (TCC) sob uma nova ótica.
Meu tema de Trabalho de Conclusão de Curso foi: [Inflação de Zeros nas Notas da Redação do ENEM: Comparação entre o Modelo Beta Inflacionado em Zero e o Modelo de Barreira](https://repositorio.bc.ufg.br//handle/ri/29518), entretanto eu não curti muito como ficou o trabalho final, que, embora concluído com êxito, foi desenvolvido sob as pressões típicas do fim de graduação. Hoje, com maior maturidade estatística e novos interesses, meu objetivo é transformar aquele estudo em um artigo de alto nível.

---

## O Problema Original

Em grandes bases de dados educacionais, é comum observar uma concentração desproporcional de notas zero (devido a fugas ao tema, folhas em branco, etc.), o que exige modelos que não ignorem essa característica. No trabalho, conclui que era melhor utilizar modelos de barreira (hurdle) ao invés de inflacionados em zero devido a natureza do processo gerador de dados, e com base nos diagnosticos dos modelos, desde aquela época eu já me preocupava com as suposições de geração dos dados e não apenas com rodar o modelo. Hoje em dia, o grande trunfo que quero inserir neste trabalho é investigar as relações das variáveis do questionário socioeconômico com a ótica da Inferência Causal, desenhar o melhor modelo gerador possível para esses dados, e entender as causas e intensidades de aumento na Nota da Redação do ENEM de forma apropriada, robusta e transparente.

---

## O que muda agora?

A nova fase deste projeto abandona a abordagem puramente frequentista focada em `gamlss` e foca em duas frentes poderosas e flexíveis da estatística moderna.

### 1. Inferência Causal

O objetivo não é apenas descrever a inflação de zeros, mas entender o que a causa através de Gráficos Acíclicos Dirigidos (DAGs), o que não foi feito e é o maior erro no trabalho anterior, pois os coeficientes foram interpretados como efeitos causais unicamente com base em correlações que podem ter sofrido vieses. Pretendo desenhar um DAG Global robusto para mapear os caminhos causais e de confusão, permitindo investigar as relações de causa e efeito entre múltiplas variáveis socioeconômicas e a probabilidade de uma nota zero de forma unificada.

### 2. Modelagem Bayesiana

Em vez de estimativas pontuais, utilizarei distribuições a priori para incorporar conhecimento prévio e obter incertezas mais ricas sobre os parâmetros do modelo. As notas nas demais provas do ENEM, que na verdade são estimativas de um modelo TRI, serão tratadas com erro de medida latente através do pacote brms. Para viabilizar a convergência computacional do MCMC e manter o rigor metodológico, utilizarei uma Amostragem Estratificada Multiestágio no lugar do censo completo.

---

##  Objetivos do Projeto

- [ ] Selecionar as variáveis que desejo investigar impacto na Nota da Redação através de uma Análise Exploratória.

- [ ] Realizar uma Amostragem Estratificada Multiestágio dos dados do ENEM para garantir representatividade nacional e viabilidade computacional.

- [ ] Refazer o pré-processamento dos dados com técnicas mais eficientes.

- [ ] Elaborar o DAG Global estruturando as relações entre socioeconomia, infraestrutura, notas latentes e a barreira do zero.

- [ ] Implementar um único e robusto modelo Hurdle Beta em um framework Bayesiano que englobe o processo gerador de dados.

- [ ] Tratar as notas das demais provas do ENEM como variáveis latentes com erro de medida.

- [ ] Realizar a validação e diagnóstico do modelo Bayesiano utilizando o método PSIS.

- [ ] Aplicar o método de G-Computation para extrair predições contrafactuais e calcular o Efeito Causal Médio de cada variável socioeconômica na mesma métrica.

- [ ] Construir uma narrativa de inferência causal para explicar o fenômeno educacional.

- [ ] Redigir o artigo final para submissão.

---
