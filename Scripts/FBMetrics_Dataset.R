# Carregar Dataset "Posts" ignorando linhas com NA's
Posts <- na.omit(read.csv("./Data/dataset.csv"))

# Type - Qualitativa Nominal
# Category - Qualitativa Nominal
# Paid - Qualitativa Nominal
# Month - Qualitativa Ordinal
# Weekday - Qualitativa Ordinal
# Hour - Quantitativa discreta
# Reach - Quantitativa discreta (mas temos que estudar como continua)
# ReachFollowers Quantitativa discreta (mas temos que estudar como continua)
# Comments - Quantitativa discreta (mas temos que estudar como continua)
# Likes - Quantitativa discreta (mas temos que estudar como continua)
# Shares - Quantitativa discreta (mas temos que estudar como continua)

# Define a ordem do meses
Posts$Month <- factor(Posts$Month, levels = c(
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
), ordered = TRUE)

# Define a ordem do dia-da-semana (de Domingo a Sábado)
Posts$Weekday <- factor(Posts$Weekday, levels = c(
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday"
), ordered = TRUE)