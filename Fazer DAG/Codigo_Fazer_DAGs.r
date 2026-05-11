library(ggdag)
library(ggplot2)
library(dplyr)
library(dagitty)

# coords <- list(
#   x = c(X = 0, Y = 2, Z = 1),
#   y = c(X = 0, Y = 0, Z = 1)
# )

# dag_data <- dagify(
#   Y ~ X + Z,
#   X ~ Z,
#   coords = coords
# ) %>%
#   tidy_dagitty()

# ou

# dag_string <- 'dag {
#   A [selected,pos="-2.200,-1.520"]
#   B [pos="1.400,-1.460"]
#   D [outcome,pos="0.653,1.293"]
#   E [exposure,pos="-1.502,1.005"]
#   Z [adjusted,pos="0.564,-0.748"]
#   A -> E [pos="-2.322,0.141"]
#   A -> Z [pos="-1.394,1.822"]
#   B -> D [pos="1.530,0.429"]
#   B -> Z [pos="-2.153,-1.168"]
#   E -> D [pos="-0.381,1.862"]
# }'

dag_enem_redacao <- dagitty(
  'dag {
bb="-10,-10,10,10"

SES [latent,pos="-8,0"]
CapCult [latent,pos="-4,-2"]
Cognicao [latent,pos="0,4"]

Raca [exposure,pos="-10,0"]
Mae [pos="-6,3"]
Renda [pos="-6,1"]
PC [pos="-6,-3"]
Sexo [pos="0,-4"]

CH [pos="0,7"]
CN [pos="3,7"]
LC [pos="-3,7"]
MT [pos="-6,7"]

Zero [pos="5,3"]
NotaLat [pos="5,-3"]
Redacao [outcome,pos="9,0"]

Raca -> SES
SES -> Mae
SES -> Renda
SES -> PC
SES -> CapCult
SES -> Cognicao

CapCult -> Zero
CapCult -> NotaLat
Cognicao -> Zero
Cognicao -> NotaLat
Sexo -> NotaLat

Cognicao -> CH
Cognicao -> CN
Cognicao -> LC
Cognicao -> MT

Zero -> Redacao
NotaLat -> Redacao
}'
)

dag_data <- dagitty(dag_enem_redacao) %>%
  tidy_dagitty()

edges_config <- dag_data$data %>%
  filter(!is.na(to)) %>%
  mutate(
    curva = ifelse(name == "Z" & to == "Y", 0.7, 0),
    estilo = ifelse(name == "Z" & to == "Y", "dashed", "solid"),
    ponta = ifelse(name == "Z" & to == "Y", "both", "last")
  )

criar_circulo <- function(x, y, r = 0.18) {
  angle <- seq(0, 2 * pi, length.out = 101)
  data.frame(x = x + r * cos(angle), y = y + r * sin(angle))
}

p <- ggplot(dag_data$data, aes(x = x, y = y, xend = xend, yend = yend)) +
  theme_void() +
  coord_fixed()

for (i in 1:nrow(edges_config)) {
  p <- p +
    geom_dag_edges_arc(
      data = edges_config[i, ],
      curvature = edges_config$curva[i],
      edge_linetype = edges_config$estilo[i],
      edge_width = 1,
      arrow = grid::arrow(
        length = grid::unit(8, "pt"),
        type = "closed",
        ends = edges_config$ponta[i]
      ),
      show.legend = FALSE
    )
}

for (i in 1:nrow(dag_data$data)) {
  node_name <- dag_data$data$name[i]
  node_x <- dag_data$data$x[i]
  node_y <- dag_data$data$y[i]

  p <- p +
    geom_point(
      x = node_x,
      y = node_y,
      color = "white",
      size = 12,
      inherit.aes = FALSE
    )

  if (node_name == "SES" | node_name == "CapCult" | node_name == "Cognicao") {
    circ_data <- criar_circulo(node_x, node_y, r = 1)
    p <- p +
      geom_path(
        data = circ_data,
        aes(x = x, y = y),
        linetype = "dashed",
        color = "black",
        linewidth = 0.5,
        inherit.aes = FALSE
      )
  }
}

p <- p +
  geom_dag_text(color = "black", family = "serif", size = 4) +
  scale_x_continuous(expand = expansion(c(0.2, 0.2))) +
  scale_y_continuous(expand = expansion(c(0.2, 0.2)))

p
