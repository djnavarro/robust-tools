
library(tidyverse)

# Read the forensic data into R
forensic <- read_csv("data_forensic.csv")

# Aggregate the data: this time, what you need to do is 
# calculate the mean confidence and the mean estimate:
forensic_collapsed <- forensic %>%
  mutate(error = abs(est - true)) %>%
  drop_na(error, confidence) %>% # OR: filter(!is.na(error), !is.na(confidence))
  group_by(participant, handwriting_expert, confidence) %>%
  summarise(error = mean(error)) %>%
  ungroup() %>%
  arrange(participant)

# take a look
print(forensic_collapsed)

# create a plot of the data
pic <- ggplot(
  data = forensic_collapsed, 
  mapping = aes(
    x = confidence, 
    y = error, 
  )) + 
  geom_point() + 
  geom_smooth(method = "lm", formula = y ~ x) + # <- method = "lm" gives linear smoothing 
  facet_wrap(vars(handwriting_expert))
  
# display the plot
plot(pic)
