# Calcula a distribuição de frequências como uma dataframe,
# com frequências absolutas e relativas, e opcionalmente as acumuladas.
# Qualitativa nominal Ñ tem acumulada
calc_freq_df <- function(data_column, cumulative = TRUE) {
  # Calcula as frequências absolutas e relativas
  ni <- table(data_column)
  fi <- round(prop.table(ni), digits = 4)

  # Cria uma dataframe com os dados de frequência
  df_freq <- data.frame(
    xi = names(ni),
    ni = as.vector(ni),
    fi = round(as.vector(fi), 4)
  )

  # Adiciona as frequências acumuladas (absolutas e relativas)
  if (cumulative) {
    df_freq$NI <- cumsum(ni)
    df_freq$FI <- round(cumsum(fi), digits = 3)
  }

  return(df_freq)
}


# Calcula os pontos de corte para as classes usando a regra de Sturges.
calc_breaks <- function(data_column) {
  # Dimensão da Amostra
  n <- length(data_column)

  # Número de classes
  k <- trunc(1 + log(n, 2))

  # Amplitude das classes
  h <- ceiling((max(data_column) - min(data_column)) / k)

  # Limite Inferior
  limite_inf <- min(data_column)

  # Limite Superior
  limite_sup <- max(data_column) + h

  # Breaks
  breaks <- seq(from = limite_inf, to = limite_sup, by = h)

  return(breaks)
}

# Calcula as classes utilizando a regra de Sturges
calc_classes <- function(data_column, right = FALSE) {
  # Calc breaks
  breaks <- calc_breaks(data_column)

  # Cut classes
  cuts <- cut(data_column, breaks = breaks, right = right, include.lowest = TRUE, dig.lab = 20)

  return(cuts)
}


# Calcula classes de acordo com o vector fornecido
calc_custom_classes <- function(data_column, breaks, labels = NULL) {
  # Cut classes
  if( missing(labels) == FALSE ) {
    cuts <- cut(data_column, breaks = breaks, right = FALSE, include.lowest = TRUE, dig.lab = 20)
    # Cola as labels aos cortes, assim concactena as labels enviadas aos varios niveis dos valores dos cuts
    labels <- paste(labels, levels(cuts))
    levels(cuts) <- labels
    return(cuts)
  }
  cuts <- cut(data_column, breaks = breaks, right = FALSE, include.lowest = TRUE, dig.lab = 20)
  return(cuts)
}


# Calcula a moda (o valor que aparece com mais frequência) num vetor numérico.
calc_mode <- function(data_column) {
  # Identifica os valores únicos do vetor
  unique_values <- unique(data_column)

  # Calcula a frequência de cada valor único e encontra o índice da maior frequência
  mode_index <- which.max(tabulate(match(data_column, unique_values)))

  # Retorna o valor que aparece com mais frequência (a moda)
  return(unique_values[mode_index])
}



# Calcula a média, a mediana e a moda de um vetor numérico,
calc_mmm <- function(data_column) {
  # Calcula a média e a mediana, ignorando valores NA se existirem
  mean_value <- round(mean(data_column, na.rm = TRUE), 2)
  med_value <- median(data_column, na.rm = TRUE)
  mode_value <- calc_mode(data_column)

  # Retorna um vetor com a média, a mediana e a moda
  mmm <- c(
    mean = mean_value,
    median = med_value,
    mode = mode_value
  )

  return(mmm)
}



# Calcula a média, a mediana e a moda para vários vetores numéricos nomeados.
calc_mmm_df <- function(...) {
  # Obtém a lista de vetores a partir dos argumentos
  vectors <- list(...)

  # Garante que todos os argumentos estão nomeados
  if (is.null(names(vectors)) || any(names(vectors) == "")) {
    stop("Erro: Todos os argumentos devem ser vetores nomeados.")
  }

  # Inicializa uma dataframe vazia para guardar os resultados
  df_mmm <- data.frame(
    variable = character(),
    mean = numeric(),
    median = numeric(),
    mode = numeric()
  )

  # Processa cada vetor
  for (name in names(vectors)) {
    vec <- vectors[[name]]

    # Calcula a média, a mediana e a moda usando a função calc_mmm
    stats <- calc_mmm(vec)

    # Acrescenta os resultados à dataframe.
    df_mmm <- rbind(
      df_mmm,
      data.frame(
        variable = name,
        mean = unname(stats["mean"]),
        median = unname(stats["median"]),
        mode = unname(stats["mode"]),
        stringsAsFactors = FALSE
      )
    )
  }

  return(df_mmm)
}

# Cria gráfico de barras e adiciona as os textos em cima
draw_bar <- function(data, main = NULL, xlab = NULL, ylab = NULL, col = NULL, ylim = NULL, xlim = NULL, labels = TRUE) {
  # No caso de não ser enviado ylim cria um default
  if( missing(ylim) == TRUE) {
    ylim = c(0, max(data) * 1.2)
  }
  
  # Cria gráfico
  graph <- barplot(
    data,
    ylab = ylab,
    ylim = ylim,
    xlab = xlab,
    xlim = xlim,
    col = col,
    main = main
  )
  
  if( labels == FALSE) return(invisible())
  # Cria labels em cima das colunas
  text(
    x = graph,
    y = data,
    labels = data,
    pos = 3,
    cex = 1.2
  )
}

# Cria gráfico pie e adiciona as legendas
draw_pie <- function(data, col = NULL, main = NULL, labels = names(data)) {
  # Cria gráfico
  pie(
    x = data,
    col = col,
    main = main,
    labels = labels,
    cex = 1.2
  )
  
  # Adiciona legenda
  legend(
    "topright",
    legend = names(data),
    fill = col,
    cex = 1.2
  )
}

draw_hist <- function(data, breaks = "Sturges", col = "lightgray", main = NULL, ylab = NULL, xlab = NULL) {
  hist(
    x = data,
    breaks = breaks,
    ylab = ylab,
    xlab = xlab,
    main = main,
    labels = TRUE,
    freq = TRUE,
    right = FALSE,
    include.lowest = TRUE,
    col = col
  )
}

draw_boxplot <- function(data, col = "lightgray", range = 3, outline = FALSE, main = NULL, ylab = NULL) {
  boxplot(
    x = data,
    col = col,
    main = main,
    ylab = ylab,
    range = range,
    outline = outline
  )
}
