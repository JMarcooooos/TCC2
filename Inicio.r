# Instale os pacotes caso não os tenha:
# install.packages(c("dagitty", "ggdag", "ggplot2", "dplyr"))

library(dagitty)
library(ggdag)
library(ggplot2)
library(dplyr)

# 1. Definindo a estrutura do DAG Causal com coordenadas para um layout perfeito
dag_enem_string <- 'dag {
  Espacial [pos="1,8"]
  Demografico [pos="1,5"]

  Escolaridade_Pais [pos="3,6"]
  Renda_Familiar [pos="3,4"]

  Infra_Escolar [pos="5,8"]
  Acesso_Internet [pos="5,2"]
  Cap_Cultural [latent, pos="5,5"]

  Hab_Cognitiva [latent, pos="7,7"]

  Barreira_Zero [outcome, pos="8,3"]
  Nota_Redacao [outcome, pos="9,5"]
  Notas_TRI [pos="9,8"]

  Espacial -> Infra_Escolar
  Espacial -> Renda_Familiar
  Demografico -> Escolaridade_Pais
  Demografico -> Renda_Familiar

  Escolaridade_Pais -> Renda_Familiar
  Escolaridade_Pais -> Cap_Cultural

  Renda_Familiar -> Infra_Escolar
  Renda_Familiar -> Acesso_Internet

  Infra_Escolar -> Hab_Cognitiva
  Infra_Escolar -> Nota_Redacao
  Cap_Cultural -> Hab_Cognitiva

  Acesso_Internet -> Barreira_Zero
  Cap_Cultural -> Barreira_Zero

  Hab_Cognitiva -> Notas_TRI
  Hab_Cognitiva -> Nota_Redacao
  Cap_Cultural -> Nota_Redacao
}'

# 2. Convertendo a string para um objeto dagitty
dag_enem <- dagitty(dag_enem_string)

# 3. Preparando o objeto para o ggdag e definindo os status dos nós
dag_tidy <- tidy_dagitty(dag_enem) %>%
  mutate(
    status = case_when(
      name %in% c("Nota_Redacao", "Barreira_Zero") ~ "Outcome (Resultado)",
      name %in% c("Cap_Cultural", "Hab_Cognitiva") ~ "Latent (Não Observada)",
      name %in% c("Demografico", "Espacial") ~ "Exposure (Base)",
      TRUE ~ "Mediator (Observada)"
    )
  )

# 4. Plotando o DAG com qualidade de publicação
ggdag(dag_tidy, text = FALSE, use_labels = "name") +
  geom_dag_point(aes(color = status), size = 18) +
  geom_dag_text(color = "white", size = 2.5, fontface = "bold") +
  geom_dag_edges(
    edge_color = "gray30",
    arrow_directed = grid::arrow(length = grid::unit(10, "pt"), type = "closed")
  ) +
  theme_dag() +
  scale_color_manual(
    values = c(
      "Exposure (Base)" = "#2c3e50",
      "Mediator (Observada)" = "#2980b9",
      "Latent (Não Observada)" = "#e67e22",
      "Outcome (Resultado)" = "#c0392b"
    ),
    name = "Tipo de Variável"
  ) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5, color = "gray40")
  ) +
  labs(
    title = "DAG Causal: Desempenho na Redação do ENEM",
    subtitle = "Abordagem em Duas Partes (Hurdle) com Variáveis Latentes e Erro de Medida"
  )
