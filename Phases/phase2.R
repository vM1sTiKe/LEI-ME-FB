# Abrir o projeto utiliando o "FBMetrics.Rproj
# SETUP ------------------------------------------------------------------------

# install.packages("here")
library(here)

# Carrega métodos e dataset
source(here("scripts", "FBMetrics_Dataset.r"))
source(here("scripts", "FBMetrics_Functions.r"))

# Palete de cores
palette(c("#b30000", "#7c1158", "#4421af", "#1a53ff", "#0d88e6", "#00b7c7", "#5ad45a", "#8be04e", "#ebdc78", "lightgray"))


# ESTUDO -----------------------------------------------------------------------

# Type
calc_freq_df(Posts$Type, cumulative = FALSE)
draw_bar(
  data = table(Posts$Type),
  main = "Posts por Type",
  xlab = "Type",
  ylab = "# Posts",
  col = rep(palette(), length.out = length(table(Posts$Type))),
)

# Category
calc_freq_df(Posts$Category, cumulative = FALSE)
draw_bar(
  data = table(Posts$Category),
  main = "Posts por Category",
  xlab = "Category",
  ylab = "# Posts",
  col = rep(rev(palette()), length.out = length(table(Posts$Category))),
)

# Paid
calc_freq_df(Posts$Paid, cumulative = FALSE)
draw_pie(
  data = table(Posts$Paid),
  main = "Posts Patrocinados",
  col = palette()[c(4, 7)],
  labels = paste0(round(table(Posts$Paid) / sum(table(Posts$Paid)) * 100, 1), "% (", table(Posts$Paid), ")")
)

# Hour
calc_freq_df(calc_custom_classes(Posts$Hour, c(0, 6, 12, 18, 23), c("Madrudaga", "Manhã", "Tarde", "Noite")))
draw_hist(
  data = Posts$Hour,
  breaks = c(0, 6, 12, 18, 23),
  ylab = "# Posts",
  xlab = "Periodo do dia",
  main = "Posts por periodo do dia",
  col = palette()[4]
)

# Comments
calc_mmm_df(Comments = Posts$Comments)
calc_freq_df(calc_classes(Posts$Comments))
draw_boxplot(
  data = Posts$Comments,
  main = "Diagrama bigodes dos Comentários",
  ylab = "# Comentários por Post",
  col = palette()[10],
)
# Comments Classe modal [0, 42)
calc_freq_df(calc_classes(Posts[Posts$Comments < 42,]$Comments))
draw_boxplot(
  data = Posts[Posts$Comments < 42,]$Comments,
  main = "Diagrama bigodes da Classe Modal dos Comentários",
  ylab = "# Comentários por Post",
  col = palette()[10],
)

# Likes
calc_mmm_df(Likes = Posts$Likes)
calc_freq_df(calc_classes(Posts$Likes))
draw_boxplot(
  data = Posts$Likes,
  main = "Diagrama bigodes dos Likes",
  ylab = "# Likes por Post",
  col = palette()[6],
)
# Likes Classe modal [0,575)
calc_freq_df(calc_classes(Posts[Posts$Likes < 575,]$Likes))
draw_boxplot(
  data = Posts[Posts$Likes < 575,]$Likes,
  main = "Diagrama bigodes da Classe Modal dos Likes",
  ylab = "# Likes por Post",
  col = palette()[6],
)

# Shares
calc_mmm_df(Shares = Posts$Shares)
calc_freq_df(calc_classes(Posts$Shares))
draw_boxplot(
  data = Posts$Shares,
  main = "Diagrama bigodes dos Shares",
  ylab = "# Shares por Post",
  col = palette()[3],
)
# Shares Classe modal [0,88)
calc_freq_df(calc_classes(Posts[Posts$Shares < 88,]$Shares))
draw_boxplot(
  data = Posts[Posts$Shares < 88,]$Shares,
  main = "Diagrama bigodes da Classe Modal dos Shares",
  ylab = "# Shares por Post",
  col = palette()[3],
)
