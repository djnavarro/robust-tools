# Exercise 5
#
# Luckily for us, there is an upside to my daughter's emoji terrorism. 
# What we now have is a kind of "template" that we can use to draw quite
# a lot of new plots. Let's see if we can apply it to some real data! 
#
# The "data_forensic.csv" file contains data published by Kristy Martire,
# Bethany Growns and myself, looking at expert and non expert judgments 
# about handwriting (which is related to Kristy & Bethany's work in 
# forensic science). Let's take a look.


# Getting started ---------------------------------------------------------

# The first part of the exercise is just to look at the data. Select these 
# three lines of code (e.g., by clicking and dragging withe mouse, the usual
# way) and then run JUST THE SELECTED LINES. Look in the "Code" menu above
# and choose "Run selected line(s)". Also notice that there is a keyboard 
# shortcut to do this... CTRL-ENTER (or COMMAND-ENTER on a Mac). 

library(tidyverse)
forensic <- read_csv("data_forensic.csv")
print(forensic)

# There's a good chance R will tell you (in grey at the bottom) that it's 
# only showing you some of the columns. If you want to look at the data a
# different way, try using the glimpse() fuction. Again, highlight the line
# and then run JUST THIS LINE

glimpse(forensic)


# Scatterplot: true (x-axis) versus est (y-axis) --------------------------

# Okay, now we can see what all the variables are. Now what we want to do
# is create a scatter plot. The plot we want should be the exact same 
# style as the one we drew for the dino data, but we want to use
# the forensic data instead. On the x-axis we want to plot the true value
# (true frequency of a feature), and on the y-axis we want to plot what 
# the participant guessed:

picture <- 🎨(🙂 = 💖) + 
  🎨(🙂 = 🎨(🙂 = 💖, 🙂 = 💖))

plot(picture)


