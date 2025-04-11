# SETUP ------------------------------------------------------------------------

# install.packages("here")
library(here)

# Carrega métodos e dataset
source(here("scripts", "FBMetrics_Dataset.r"))
source(here("scripts", "FBMetrics_Functions.r"))

# TABELAS ----------------------------------------------------------------------

## Type (Qualitativa Nominal)
(freq_type <- calc_freq_df(Posts$Type, cumulative = FALSE))

## Category (Qualitativa Nominal)
(freq_category <- calc_freq_df(Posts$Category, cumulative = FALSE))

## Paid (Qualitativa Nominal)
(freq_paid <- calc_freq_df(Posts$Paid, cumulative = FALSE))

# GRÁFICOS ---------------------------------------------------------------------

palette(c("#b30000", "#7c1158", "#4421af", "#1a53ff", "#0d88e6", "#00b7c7", "#5ad45a", "#8be04e", "#ebdc78"))

# Barplot Type
data <- table(na.omit(Posts$Type))

# Barplot Type - Chart
bp_type <- barplot(
  data,
  main = "Posts por Type",
  xlab = "Type",
  ylab = "# Posts",
  col = rep(palette(), length.out = length(data)),
  ylim = c(0, max(data) * 1.2)
)

# Barplot Type - Frequency labels
text(
  x = bp_type,
  y = data,
  labels = data,
  pos = 3,
  cex = 1.2,
)

# Barplot Category
data <- table(na.omit(Posts$Category))

# Barplot Category - Chart
bp_category <- barplot(
  data,
  main = "Posts por Category",
  xlab = "Category",
  ylab = "# Posts",
  col = rep(rev(palette()), length.out = length(data)),
  ylim = c(0, max(data) * 1.2)
)

# Barplot Category - Frequency labels
text(
  x = bp_category,
  y = data,
  labels = data,
  pos = 3,
  cex = 1.2,
)

# Pie Paid
data <- table(na.omit(Posts$Paid))

# Pie Paid - Chart
pie_paid <- pie(
  data,
  main = "Posts Patrocinados",
  col = palette()[c(1, length(palette()))],
  labels <- paste0(round(data / sum(data) * 100, 1), "% (", data, ")"),
  cex = 1.2
)

# Pie Paid - Legend
legend(
  "topright",
  legend = names(data),
  fill = palette()[c(1, length(palette()))],
  cex = 1.2
)

