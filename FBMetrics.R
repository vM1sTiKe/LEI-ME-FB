# SETUP ------------------------------------------------------------------------

# install.packages("here")
# install.packages("rstudioapi")
library(here)

# Carrega métodos e dataset
source(here("scripts", "FBMetrics_Dataset.r"))
source(here("scripts", "FBMetrics_Functions.r"))

# Carrega tabelas de frequencia
source(here("scripts", "FBMetrics_FrequencyTables.r"))


# Estatísticas (mediana, média, moda) de interacções
(mmm_interactions <- calc_mmm_df(Comments = Posts$Comments, Likes = Posts$Likes, Shares = Posts$Shares))


# GRÁFICOS ---------------------------------------------------------------------
## Type
barplot( table(Posts$Type), xlab="Tipo", ylab="", main="Publicações por Tipo", col=c("red", "white"))
pie(freq_type$ni, labels=paste(freq_type$fi*100,"%"), main="Publicações por Tipo", col=2:5)
legend( "bottomleft", legend=names(table(Posts$Type)), fill=2:5)

# Category
barplot( table(Posts$Category), xlab="Categoria", ylab="", main="Publicações por Categoria", col=c("red", "white"))
pie(freq_category$ni, labels=paste(freq_category$fi*100,"%"), main="Publicações por Categoria", col=2:4)
legend( "bottomleft", legend=names(table(Posts$Category)), fill=2:4)

# Paid
barplot(  table(Posts$Paid), xlab="Pago", ylab="", main="Publicações por Pagamento", col=c("red", "white"))
pie(freq_paid$ni, labels=paste(freq_paid$fi*100,"%"), main="Publicações por Pagamento", col=2:3)
legend( "bottomleft", legend=names(table(Posts$Paid)), fill=2:3)

# Month
barplot(  table(Posts$Month), xlab="Mês", ylab="", main="Publicações por Mês", col=c("red", "white"))
pie(freq_month$ni, labels=paste(freq_month$fi*100,"%"), main="Publicações por Mês", col=2:13)
legend( "bottomleft", legend=names(table(Posts$Month)), fill=2:13)

# Weekday
barplot(  table(Posts$Weekday), xlab="Dia da Semana", ylab="", main="Publicações por Dia da Semana", col=c("red", "white"))
pie(freq_weekday$ni, labels=paste(freq_weekday$fi*100,"%"), main="Publicações por Dia da Semana", col=2:8)
legend( "bottomleft", legend=names(table(Posts$Weekday)), fill=2:8)

# Hour
barplot(  table(Posts$Hour), xlab="Hora", ylab="", main="Publicações por Hora", col=c("red", "white"))
pie(freq_hour$ni, labels=paste(freq_hour$fi*100,"%"), main="Publicações por Hora", col=2:23)
legend( "bottomleft", legend=names(table(freq_hour$xi)), fill=2:23)


boxplot(Posts$Hour,
  names = c("Hour"),
  main = "Boxplot of Hours",
  range = 1,
  col = c("lightblue")
)

hist(
  x = Posts$Hour,
  breaks = calc_breaks(Posts$Hour),
  right = FALSE,
  include.lowest = TRUE,
)



boxplot(Posts$Comments, Posts$Likes, Posts$Shares,
  names = c("Comments", "Likes", "Shares"),
  main = "Boxplot of Comments, Likes, and Shares",
  ylab = "Values",
  range = 3,
  col = c("lightblue", "lightgreen", "lightcoral")
)
