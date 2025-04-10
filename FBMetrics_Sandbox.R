# SETUP ------------------------------------------------------------------------

# install.packages("here")
library(here)

source(here("scripts", "FBMetrics_Dataset.r"))
source(here("scripts", "FBMetrics_Functions.r"))

(min(Posts$Hour))
(max(Posts$Hour))
(freq_hour <- calc_freq_df(Posts$Hour)) # Hour (Quantitativa discreta)

calc_classes(Posts$Hour)


calc_classes(Posts$Likes)
calc_classes(Posts$Comments)
calc_classes(Posts$Shares)
calc_classes(Posts$ReachFollowers)
calc_classes(Posts$Reach)
calc_classes(Posts$Hour)



hist(
  x = Posts$Reach,
  breaks = calc_classes_lab(Posts$Reach),
  right = TRUE,
  include.lowest = TRUE,
)



(length(Posts$Likes))
?nrow
