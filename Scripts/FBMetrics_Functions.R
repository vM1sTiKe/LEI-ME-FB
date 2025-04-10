# Calcula a distribuição de frequências como uma dataframe,
# com frequências absolutas e relativas, e opcionalmente as acumuladas.
calc_freq_df <- function(data_column, cumulative = TRUE) {
  # Calcula as frequências absolutas e relativas
  ni <- table(data_column)
  fi <- round(prop.table(ni), digits = 3)

  # Cria uma dataframe com os dados de frequência
  df_freq <- data.frame(
    xi = names(ni),
    ni = as.vector(ni),
    fi = round(as.vector(fi), 3)
  )

  # Adiciona as frequências acumuladas (absolutas e relativas)
  if (cumulative) {
    df_freq$NI <- cumsum(ni)
    df_freq$FI <- round(cumsum(fi), digits = 3)
  }

  return(df_freq)
}



# Calcula os pontos de corte para as classes usando a regra de Sturges.
calc_classes <- function(data_column) {
  # Dimensão da Amostra
  n <- length(data_column)

  # Número de classes
  k <- trunc(1 + log(n, 2))
  

  # Amplitude das classes
  h <- ceiling((max(data_column) - min(data_column)) / k)
  

  # Limite Inferior
  limite_inf <- min(data_column)

  # Limite Superior
  limite_sup <- (limite_inf + h * k)

  # Breaks
  breaks <- seq(from = limite_inf, to = limite_sup, by = h)
  
  # Cut classes
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