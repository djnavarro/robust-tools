
participant10 <- forensic %>% 
  filter(participant == 10) %>%
  select(est, true, band) %>%
  mutate(error = abs(est - true)) %>%
  arrange(error)

ggplot(
  data = participant10, 
  mapping = aes(x = error, fill = band)
) + 
geom_histogram() 

