
# Exercise 5 is another "emoji replacement" problem. Our goal here is to create 
# new data set called `forensic_collapsed`, which should have only one row
# per subject. It should contain only four variables:
#
#   - `participant` is the participant ID
#   - `handwriting_expert` indicates whether they are an expert or not
#   - `confidence` is their self rated confidence
#   - `error` is the average error in their judgments
#
# To achieve this, we will still need to use `group_by()`, `summarise()` and
# `ungroup()` in the same way we did before, but we will now need to use some
# other functions:
#
#   - use `mutate()` to create a new column
#   - use `filter()` to decide which rows to keep
#   - use `arrange()` to sort the rows
#
# There are some discussion questions at the end!


# getting started ---------------------------------------------------------

library(tidyverse)

# Read the forensic data into R
forensic <- read_csv("data_forensic.csv")



# data wrangling ----------------------------------------------------------

# Aggregate the data: this time, what you need to do is 
# calculate the mean confidence and the mean estimate:
forensic_collapsed <- forensic %>%
  mutate(🥼 = abs(est - true)) %>%          # error is the absolute difference between true and estimated     
  filter(!is.na(🥼), !is.na(👗))  %>%       # filter out all the cases where error or confidence is missing
  group_by(💃🏻, handwriting_expert, 👗) %>%  # group...
  summarise(error = mean(🥼)) %>%           # summarise...
  ungroup() %>%                              # ... and ungroup
  arrange(💃🏻)                               # sort by participant number

# take a look
print(forensic_collapsed)



# data visualisation ------------------------------------------------------

# create a plot of the data
pic <- ggplot(
  data = forensic_collapsed, 
  mapping = aes(
    x = confidence, 
    y = error, 
  )) + 
  geom_point() + 
  geom_smooth(method = "lm", formula = y ~ x) + # noteice... method = "lm" gives linear smoothing 
  facet_wrap(vars(handwriting_expert))

# display the plot
plot(pic)



# discussion questions ----------------------------------------------------

# - on line 37, what do you think the `is.na()` function does? 
#
# - also on line 37, what do you think the `!` operator does?
#
# - also on line 37, wouldn't it be nice if there was a "short cut" that would
#   let you remove rows containing missing values without havint to use such 
#   a long and cumbersome command like:
#   
#       `filter(!is.na(error), !is.na(confidence))`
#
#   I mean, that's pretty annoying, right?
#
# - try replacing line 37 with `drop_na(error, confidence)`
#
# - look at the plot... are experts more accurate than novices? are they also
#   better calibrated than novices?