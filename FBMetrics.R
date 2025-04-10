# SETUP ------------------------------------------------------------------------

# install.packages("here")
# install.packages("rstudioapi")
library(here)

# Usando a API do RStudio recolhe o caminho do ficheiro atual
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source("./Scripts/FBMetrics_Dataset.r")
source("./Scripts/FBMetrics_Functions.r")

# CALCULOS ---------------------------------------------------------------------

# Analise Descritiva
## Type (Qualitativa Nominal)
(freq_type <- calc_freq_df(Posts$Type, cumulative = FALSE))
## Category (Qualitativa Nominal)
(freq_category <- calc_freq_df(Posts$Category, cumulative = FALSE))
## Paid (Qualitativa Nominal)
(freq_paid <- calc_freq_df(Posts$Paid, cumulative = FALSE))
## Month (Qualitativa Ordinal)
(freq_month <- calc_freq_df(Posts$Month))
## Weekday (Qualitativa Ordinal)
(freq_weekday <- calc_freq_df(Posts$Weekday))
## Hour (Quantitativa discreta)
(freq_hour <- calc_freq_df(Posts$Hour))
## Total Reach (Quantitativa discreta) (mas temos que estudar como continua)
(freq_reach <- calc_freq_df(Posts$Total.Reach))
## Reach by Followers (Quantitativa discreta)
(freq_reach_followers <- calc_freq_df(Posts$ReachFollowers))
## Comments (Quantitativa discreta)
(freq_comments <- calc_freq_df(Posts$Comments))
## Likes (Quantitativa discreta)
(freq_likes <- calc_freq_df(Posts$Likes))
# Shares (Quantitativa discreta)
(freq_shares <- calc_freq_df(Posts$Shares))

# Estatísticas (mediana, média, moda) de interacções
(mmm_interactions <- calc_mmm_df(Comments = Posts$Comments, Likes = Posts$Likes, Shares = Posts$Shares))


# GRÁFICOS ---------------------------------------------------------------------


boxplot(Posts$Comments, Posts$Likes, Posts$Shares,
  names = c("Comments", "Likes", "Shares"),
  main = "Boxplot of Comments, Likes, and Shares",
  ylab = "Values",
  range = 3,
  col = c("lightblue", "lightgreen", "lightcoral")
)
