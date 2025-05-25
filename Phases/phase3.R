# SETUP ------------------------------------------------------------------------
library(here)
library(nortest)
source(here("scripts", "FBMetrics_Dataset.r"))
source(here("scripts", "FBMetrics_Functions.r"))

# METHODS ----------------------------------------------------------------------
chi.squared.exp.classed <- function(data_column) {
  # Get frequency table using sturges cuts
  df = calc_freq_df(calc_classes(data_column, right = TRUE), cumulative = FALSE)
  # Remove fi column
  df = df[, -3]
  # Get the mean of the given data
  mean = mean(data_column)
  # Create vector to hold the % information
  pi = c()
  
  # Goes to every
  iteration_counter = 1
  for(iteration in df$xi) {
    # Start class values splitting
    iteration_split = strsplit(iteration, ",")
    
    # Split values to be able to access them
    left_val = as.integer(names(table(strsplit(names(table(iteration_split))[1], "[([]+")))[2])
    right_val = as.integer(names(table(strsplit(names(table(iteration_split))[2], "[]]+")))[1])
    
    if(iteration_counter == 1) pi[iteration_counter] = round(pexp(right_val, 1/mean), digits = 2)
    else if(iteration_counter == nrow(table(df$xi))) pi[iteration_counter] = round(1- pexp(left_val, 1/mean), digits = 2)
    else pi[iteration_counter] = round(pexp(right_val, 1/mean)-pexp(left_val, 1/mean), digits = 2)
    
    # Increment counter
    iteration_counter = iteration_counter + 1
  }
  
  # Add the % into the data frame
  df$pi = pi
  
  print("-- Freq. Table --")
  print(df)
  print("")
  # Execute the Chi Square test
  chisq.test(x = df$ni, p = df$pi)
}
chi.squared.u <- function(data_column) {
  # Get frequency table using sturges cuts
  df = calc_freq_df(data_column, cumulative = FALSE)
  # Remove fi column
  df = df[, -3]
  # Amount of rows on the data frame
  n = nrow(df)
  # Create vector to hold the %'s
  pi = c()
  
  # Goes to every
  iteration_counter = 1
  for(iteration in df$xi) {
    # Calculate the %
    pi[iteration_counter] = 1/n
    
    # Increment counter
    iteration_counter = iteration_counter + 1
  }
  
  # Add the % into the data frame
  df$pi = pi
  
  print("-- Freq. Table --")
  print(df)
  print("")
  # Execute the Chi Square test
  chisq.test(x = df$ni, p = df$pi)
}

### Informação para os testes de ajustamento ###
# Nível de significância está definido para 10%. Ou seja alpha = .1

# TESTE DE AJUSTAMENTO Likes --------------------------------------------------
# H0 ~ Exp
# H1 !~ Exp

# Likes
mean(Posts$Likes)
median(Posts$Likes)
draw_hist(Posts$Likes)

chi.squared.exp.classed(Posts$Likes)

# Likes < 575
mean(Posts[Posts$Likes < 575,]$Likes)
# Calculo da média da amostra para fazer o teste = 125.7941
median(Posts[Posts$Likes < 575,]$Likes)
draw_hist(Posts[Posts$Likes < 575,]$Likes)

chi.squared.exp.classed(Posts[Posts$Likes < 575,]$Likes)

# Validação dos resultados do Teste do Qui-Quadrado
# p-value = .0000657
# df = 8
# Como a média da amostra teve que ser estimada, temos que corrigir o df, ficando df = 7
1-pchisq(32.844, 7) # pvalue = .0000283
# R: Rejeitar H0, pois p-value < alpha

# TESTE DE AJUSTAMENTO Mês - Normal---------------------------------------------
# H0 ~ N
# H1 !~ N

month.to.int = as.integer(factor(Posts$Month))
mean(month.to.int)
median(month.to.int)
draw_boxplot(month.to.int)
draw_hist(month.to.int, breaks = c(1,2,3,4,5,6,7,8,9,10,11,12,13))
lillie.test(month.to.int)
# Rejeitar H0 pois p-value < alpha

# TESTE DE AJUSTAMENTO Mês - Uniforme ------------------------------------------
# H0 ~ U(12)
# H1 !~ U(12)

chi.squared.u(Posts$Month)
# Rejeitar H0 pois p-value = .0008997 < alpha

# TESTE DE AJUSTAMENTO Dia-Semana ----------------------------------------------
# H0 ~ U(7)
# H1 !~ U(7)

weekday.to.int = as.integer(factor(Posts$Weekday))
draw_hist(weekday.to.int, , breaks = c(1,2,3,4,5,6,7,8))

chi.squared.u(Posts$Weekday)
# Ñ Rejeitar H0, pois p-value = .6125 > alpja
