# SETUP ------------------------------------------------------------------------
library(here)
library(DescTools)
source(here("scripts", "FBMetrics_Dataset.r"))
source(here("scripts", "FBMetrics_Functions.r"))


# Teste de Independência do Qui-Quadrado

# H0: As variáveis são independentes
# H1: As variáveis ñ são independentes

# Variáveis e verificar hipótese: Paid; Total_Reach (Classes)



paid = Posts$Paid
total_reach =  calc_classes(Posts$Total_Reach)

tcontigencia = table(paid, total_reach)
chisq.test(tcontigencia)

# Estudo da associação
ContCoef(tcontigencia) # 0.1942 - associação fraca
CramerV(tcontigencia) # k = 2; 0.1980 - associção fraca




# 2nd estudo, estudando classe modal do total reach

total_reach.modal = calc_classes(Posts[Posts$Total_Reach < 80500,]$Total_Reach)
paid.modal = Posts[Posts$Total_Reach < 80500,]$Paid

tcontigencia.modal = table(paid.modal, total_reach.modal)
chisq.test(tcontigencia.modal)

# Estudo da associação
ContCoef(tcontigencia.modal) # 0.1890 - associação fraca
CramerV(tcontigencia.modal) # k = 2; 0.1925 - associção fraca


