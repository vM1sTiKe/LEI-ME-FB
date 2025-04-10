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
(freq_type <- calc_freq_df(Posts$Type, cumulative = FALSE)) # Type (Qualitativa Nominal)
(freq_category <- calc_freq_df(Posts$Category, cumulative = FALSE)) # Category (Qualitativa Nominal)
(freq_paid <- calc_freq_df(Posts$Paid, cumulative = FALSE)) # Paid (Qualitativa Nominal)
(freq_month <- calc_freq_df(Posts$Month)) # Month (Qualitativa Ordinal)
(freq_weekday <- calc_freq_df(Posts$Weekday)) # Weekday (Qualitativa Ordinal)
(freq_hour <- calc_freq_df(Posts$Hour)) # Hour (Quantitativa discreta)
(freq_reach <- calc_freq_df(Posts$Reach)) # Total Reach (Quantitativa discreta) (mas temos que estudar como continua)
(freq_reach_followers <- calc_freq_df(Posts$ReachFollowers)) # Reach by Followers (Quantitativa discreta)
(freq_comments <- calc_freq_df(Posts$Comments)) # Comments (Quantitativa discreta)
(freq_likes <- calc_freq_df(Posts$Likes)) # Likes (Quantitativa discreta)
(freq_shares <- calc_freq_df(Posts$Shares)) # Shares (Quantitativa discreta)

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
