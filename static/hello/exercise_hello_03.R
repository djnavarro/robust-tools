# Exercise 3
#
# Welcome to the pipe! In this exercise I'm going to give you some code that
# uses functions you've never seen before, and I want you to try to work out 
# what each one does. I'll use the forensic data to illustrate this, so the 
# first step is to load the tidyverse and the data...

library(tidyverse)
forensic <- read_csv("data_forensic.csv")


# Summarise participant 1 -------------------------------------------------

participant1 <- ungroup(
  summarise(
    group_by(
      filter(forensic, participant == 1),
      band
    ),
    mean = mean(est), 
    sd = sd(est)  
  )
)


# Summarise participant 2 -------------------------------------------------

x <- filter(forensic, participant == 2)
y <- group_by(x, band)
z <- summarise(y, mean = mean(est), sd = sd(est))
participant2 <- ungroup(z)



# Summarise participant 3 -------------------------------------------------

participant3 <- forensic %>%
  filter(participant == 3) %>%
  group_by(band) %>%
  summarise(mean = mean(est), sd = sd(est)) %>%
  ungroup()


# Check the results -------------------------------------------------------

print(participant1)
print(participant2)
print(participant3)



# Discussion (in pairs, as always!)
# 
# - All three "versions" of the code do the same thing, only with different
#   participants. Setting aside the fact that you haven't actually learned
#   what filter(), group_by(), etc does... can you work out what the code is
#   doing overall?
#
# - Which of these three versions is easiest to understand? Or are they all
#   equally easy/difficult? What makes it easy/hard?
#
# - What do you think the "pipe operator" %>% is doing here (hint: compare
#   the code for versions 2 and 3 to each other...) 
#
# - There is something weird about the "participant1" data. This has nothing
#   to do with my code... it's actually something that is in the "forensic"
#   data itself. What is the weird thing and what do you think it means?