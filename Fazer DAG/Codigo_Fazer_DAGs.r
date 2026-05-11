library(ggdag)
library(ggplot2)
library(dplyr)

coords <- list(
  x = c(X = 0, Y = 2, Z = 1),
  y = c(X = 0, Y = 0, Z = 1)
)

dag_data <- dagify(
  Y ~ X + Z,
  X ~ Z,
  coords = coords
) %>%
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

  if (node_name == "Z" | node_name == "Y") {
    circ_data <- criar_circulo(node_x, node_y, r = 0.08)
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
  geom_dag_text(color = "black", family = "serif", size = 8) +
  scale_x_continuous(expand = expansion(c(0.2, 0.2))) +
  scale_y_continuous(expand = expansion(c(0.2, 0.2)))

p
