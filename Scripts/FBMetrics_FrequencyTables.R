# Analise Descritiva ---------------------------------------------------------------------

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
(freq_hour <- calc_freq_df(calc_custom_classes(Posts$Hour, c(0, 7, 13, 18, 23), c("Madrudaga", "Manhã", "Tarde", "Noite"))))

## Total Reach (Quantitativa discreta) (mas temos que estudar como continua)
(freq_reach <- calc_freq_df(calc_classes(Posts$Total_Reach)))

## Reach by Followers (Quantitativa discreta)
(freq_reach_followers <- calc_freq_df(calc_classes(Posts$Reach_by_Followers)))

## Comments (Quantitativa discreta) (mas temos que estudar como continua)
(freq_comments <- calc_freq_df(calc_classes(Posts$Comments)))

## Likes (Quantitativa discreta) (mas temos que estudar como continua)
(freq_likes <- calc_freq_df(calc_classes(Posts$Likes)))

# Shares (Quantitativa discreta) (mas temos que estudar como continua)
(freq_shares <- calc_freq_df(calc_classes(Posts$Shares)))
