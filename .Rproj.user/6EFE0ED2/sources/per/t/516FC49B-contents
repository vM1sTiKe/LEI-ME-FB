#' Função para criar uma tabela de frequencias
#' @param accumulate Se variavel Qualitativa Nominal -> FALSE
create_freq_table = function(data_column, accumulate = TRUE) {
  ni = table(data_column) # Absolute Frequency
  fi = round(prop.table(ni), digits = 3) # Relative Frequency
  NI = cumsum(ni) # Absolute Frequency accumulated
  FI = round(cumsum(fi), digits = 3) # Relative Frequency accumulated
  
  # Last position of FI vector cannot be bigger than 1
  ## If it is, because of rounding, force it to be 1
  if( FI[length(FI)] >= 1.001 ) FI[length(FI)] = 1
  
  if( accumulate == TRUE ) data.frame(row.names = NULL, xi = names(ni), ni = as.character(ni), fi = as.character(fi), NI, FI)
  else data.frame(row.names = NULL, xi = names(ni), ni = as.character(ni), fi = as.character(fi))
}

create_classe = function() {
  ks = trunc(1 + log(nrow(Atletas), 2) )
  
  # o k é 4, e vai começar no valor min dos dados
  # calcular amplitude "h"
  hs = ( max(Atletas$`Nível de ferro (mg)`) - min(Atletas$`Nível de ferro (mg)`)  ) / ks
  # no h de struges temos que arredondar por excesso
  seq(min(Atletas$`Nível de ferro (mg)`), max(Atletas$`Nível de ferro (mg)`), hs)
}

# Ler dataset
Posts = readr::read_csv("./proj/dataset.csv")

# Analise Descritiva 
# Type (Qualitativa Nominal)
type_freq = create_freq_table(Posts$Type, accumulate = FALSE)
# Category (Qualitativa Nominal)
category_freq = create_freq_table(Posts$Category, accumulate = FALSE)
# Paid (Qualitativa Nominal)
paid_freq = create_freq_table(Posts$Paid, accumulate = FALSE)
# Month (Qualitativa Ordinal)
month_freq = create_freq_table(Posts$Month)
# Weekday (Qualitativa Ordinal)
weekday_freq = create_freq_table(Posts$Weekday)
# Hour (Quantitativa discreta)
hour_freq = create_freq_table(Posts$Hour)
# Total Reach (Quantitativa discreta) (mas temos que estudar como continua)

total_reach_freq = create_freq_table(Posts$`Total\nReach`)
# Reach by Followers (Quantitativa discreta)
# Comments (Quantitativa discreta)
# Likes (Quantitativa discreta)
# Shares (Quantitativa discreta)


