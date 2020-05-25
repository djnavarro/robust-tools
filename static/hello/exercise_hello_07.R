# Exercise 7

# Load the required packages
library(tidyverse)

# Read the forensic data into R
forensic_banded <- read_csv("summary_forensic_banded.csv")

# Create a plot!
pic <- ggplot(data = forensic_banded) + 
  geom_violin(mapping = aes(x = band, y = mean_est)) + 
  xlab("Stimulus Band") + 
  ylab("Responses") + 
  ggtitle("Distribution of responses")

# As usual, let's plot the picture...
plot(pic)

# Suppose we want to save the picture to a file instead of plotting it 
# to the plot pane. How do we do this? There are several ways, but the
# simplest one is to use the ggsave() function
ggsave(
  filename = "forensic_banded.png",
  plot = pic
)


# Your job:
# 
# - First, run this script and see what it does
#
# - Second, try getting it to save to a "jpeg" or a "pdf" just by changing
#   the file extension from ".png" to something else...
#
# - Third, the ggsave() function has arguments `width` and `height`, which
#   specify the size of the final image in inches. Try playing around with
#   different output sizes
  