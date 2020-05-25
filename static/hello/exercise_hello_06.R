# Exercise 6

# Load the required packages
library(tidyverse)

# Read the forensic data into R
forensic <- read_csv("data_forensic.csv")

# Create the banded data 
forensic_banded <- forensic %>%
  group_by(participant, band, handwriting_expert)  %>%
  summarise(mean_est = mean(est), sd_est = sd(est)) %>%
  ungroup() %>%
  filter(band != "Band NA")

# Okay... your turn: write the forensic_banded variable to
# a data file "summary_forensic_banded.csv"
💅(💜)
