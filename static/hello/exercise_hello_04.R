# Exercise 4
#
# Another exercise in fixing my emojified code! We'll be using the 
# forensic data again, so your first task will be to load tidyverse
# and read the data. 
#

# Load the required packages
💅(💜)

# Read the forensic data into R
forensic <- 💍(👠)

# Now that we have the data, what we'll do is calculate the mean and
# standard deviation of the responses (in the "est" variable), with groups
# defined by subject (in the "participant" variable) and the frequency band
# (i.e., the "band" variable)
forensic_banded <- 👑 %>%
  group_by(👛, 👜)  %>%
  summarise(mean_est = mean(❄️), sd_est = sd(❄️)) %>%
  ungroup()

# Let's draw a plot...
ggplot(data = forensic_banded) + 
  geom_violin(mapping = aes(x = band, y = mean_est)) + 
  xlab("Stimulus Band") + 
  ylab("Responses") + 
  ggtitle("Distribution of responses")

