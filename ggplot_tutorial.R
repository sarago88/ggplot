################################################################################
###
### Introduction to ggplot2
###
### Sara Gottlieb-Cohen, Manager of Statistical Support Services
### Center for Science and Social Science Information
### Yale University
###
################################################################################

library(tidyverse)

########################################################################
## Scatterplots ##
########################################################################

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Play around with size, shape and color. You can see a list of shapes here: 
# https://www.datanovia.com/en/blog/ggplot-point-shapes-best-tips/. 

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(shape = ___)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(size = ___)

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(color = ___)

# Note that you can write the color itself, or pick more specific colors using
# color codes. There is a handy chart at the bottom of this page:
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

# Put all three (size, shape, color) together to create your preferred plot:

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point(size = ___, shape = ___, color = ___)

# We can add extra variables to our plot, too. Horsepower (hp) is a continuous 
# variable; we can map either size or color onto it. But because we are calling a 
# variable, we have to specify color in the "aesthetics" layer of our plot.

# Play around with color first:

ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point()

# What if we don't want the color gradient to be red instead? Try
# running the following code: 

ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point(color = "red")

# Why doesn't this work? It looks like the second line is overwriting the first
# line.

# To change the color gradient, we add additional code:

ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point() +
  scale_color_gradient(low = "blue", high = "red")

# Or we can use pre-made palettes. I like the viridis package:

install.packages("viridis")
library(viridis)

ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point() +
  scale_color_viridis()

# That displayed the default color gradient But we can change it, too: 

ggplot(mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point() +
  scale_color_viridis(option = "magma")

# Here is a great resource on color palettes: 
# https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/

# Now try mapping hp onto size:

ggplot(mtcars, aes(x = wt, y = mpg, size = hp)) +
  geom_point() 

# Return to our basic plot of weight and mpg. But now add a factor variable - cyl. 
# A car has either 4, 6 or 8 cylinders. Try making
# each shape a different color, and also change the color palette:

ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() 

ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  scale_color_viridis(discrete = TRUE)

# Note that we had to specify that our color variable is discrete (continuous is
# the default).

# We are going to return again to our original plot. We can enhance
# data visualization in several ways. First, we are going to add a smoothing line:

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth()

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# How are these different? You can always learn more about a command:

?geom_smooth

# The last version drew a best fit line. What if we want separate best 
# fit lines for each level of the cyl variable?

ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
  geom_point() +
  geom_smooth(method = "lm")

# You have hopefully now gotten a sense of ggplot's flexibility and how we can build
# layers, add variables, and change default settings. In the next section, you will
# work through exercises to build additional types of plots.

########################################################################
## Do 4,6 and 8 cylinder cars get different mileage? ##
########################################################################

# There are many ways to plot a factor variable on the x-axis, and a 
# continuous variable on the y-axis. Work through the following
# examples to explore different types of visualizations.

# Create a box plot comparing the mpg of 4, 6 and 8 cylinder cars

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot()

# Add coord_flip() to flip the coordinates.

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  ___

# Change the color of the boxes to blue, but fill them red.

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot(color = ___, fill = ___)

# Change the y-axis to begin at 0.

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  scale_y_continuous(limits = c(___, ___))

# Give the plot a title, and change the axis labels to look publication-ready.

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  scale_y_continuous(limits = c(___, ___)) +
  labs(title = "___", x = "___", y = "___")

# That looks good, but the title isn't centered. Add a line of code to center it.

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  scale_y_continuous(limits = c(___, ___)) +
  labs(title = "___", x = "___", y = "___") +
  theme(plot.title = element_text(hjust = 0.5))

# Plot the same data, but this time as a bar chart.

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_bar(stat = "identity")

# Hmm, this looks wrong. That is because our data needs to be in a specific format for a bar
# graph to work: we need to have the statistic (mean) already calculated.

mtcars_mpg_data <- mtcars %>%
  group_by(cyl) %>%
  summarize(av_mpg = mean(mpg))

mtcars_mpg_data

# Now try again, changing the data:

ggplot(mtcars_mpg_data, aes(x = factor(cyl), y = av_mpg)) +
  geom_bar(stat = "identity")

# The reason we have to include stat = "identity" is because the default setting is
# to show counts (like a histogram) on the y-axis. We are instead telling ggplot to graph
# the actual data (mpg) on the y-axis because we have two variables of interest.

# Change the plot to make each bar a different color:

ggplot(mtcars_mpg_data, aes(x = factor(cyl), y = av_mpg, fill = ___)) +
  geom_bar(stat = "identity")

# Bar charts are really handy when we have two categorical variables, and we want to 
# visualize an interaction. For the next chart, plot mpg by two factor variables:
# cyl and am (automatic or manual). Note that you will have to make some changes to
# mtcars_mpg_data first.

ggplot(mtcars_mpg_data, aes(x = factor(cyl), y = mpg, fill = ___)) +
  geom_bar(stat = "identity")

# We don't usually want the bars stacked. To make them side by side, change the position.

ggplot(mtcars_mpg_data, aes(x = factor(cyl), y = mpg, fill = ___)) +
  geom_bar(stat = "identity", position = "dodge")

# Change the colors.

ggplot(mtcars_mpg_data, aes(x = factor(cyl), y = mpg, fill = ___)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c(___, ___))

# Now try plotting the original data (cyl and mpg from mtcars) as a line graph. 

ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_line() 

# Hmm, that doesn't look right either. For a geom_line(), our data needs to look a little
# bit different. We need a data frame that summarizes our data, like we did earlier.
# This time, calculate standard error of each group (in addition to average mpg).

mtcars_mpg_data2 <- mtcars %>%
  select(mpg, cyl) %>%
  group_by(cyl) %>%
  summarize(mean = mean(mpg),
            sd = sd(mpg),
            n = n()) %>%
  mutate(se = sd/sqrt(n))

# Examine our new data frame:

mtcars_mpg_data2

# We will now use the data summary to make a line graph. Plot cyl on the x-axis and mpg on 
# the y-axis. Include error bars to denote one standard error above and below the mean.

ggplot(mtcars_mpg_data2, aes(x = factor(cyl), y = mean, group = 1)) +
  geom_line() +
  geom_errorbar(aes(ymin = ___, ymax = ___), width = .1)

# We can again add am (automatic or manual), and plot separate lines for the types of cars.
# You can do this by mapping am onto group and color. We will need to first adapt our data frame to
# include the am variable:

mtcars3 <- mtcars %>%
  select(mpg, cyl, am) %>%
  group_by(cyl, ___) %>%
  summarize(mean = mean(mpg),
            sd = sd(mpg),
            n = n()) %>%
  mutate(se = sd/sqrt(n))

ggplot(mtcars3, aes(x = factor(cyl), y = mean, group = ___, color = ___)) +
  geom_line() +
  geom_errorbar(aes(ymin = ___, ymax = ___), width = .1)

# Use what you have learned throughout the tutorial to improve the look of this plot.

# 1. Add a title
# 2. Center the title
# 2. Lable the axes so they look more publication-ready.
# 3. Title the legend to say "car type", and make the levels "automatic" and 
#     manual (instead of 1 or 0). 
#     Hint: https://community.rstudio.com/t/ggplot2-change-legend-title-while-controlling-line-types-and-colors/14966
# 3. Change the y-axis scale to start at 0








########################################################################
## Challenge exercise 1: US arrests ##
########################################################################

?USArrests
head(USArrests)

# Make a line graph; the x-axis will represent the number of people living
# in urban areas, and the y-axis will represent arrests (per 100,000). Graph
# separate lines for murders, assaults and rapes.

# Note that your data must be in the right format in order to graph it. 
# Turn it into a long format with one row per observation. If you are not sure
# how to do this, please ask for assistance








########################################################################
## Challenge exercise 2: Titanic survivors ##
########################################################################

install.packages("carData")
library(carData)

?TitanicSurvival
head(TitanicSurvival)

# Create a bar graph showing the average age of passengers based on sex 
# and whether or not they survived. 

# Make sure to add error bars (+/1 one standard error). To do this, first 
# summarize your data. The code for error bars will be similar to the code
# you used to create error bars for your line graph.







########################################################################
## Challenge exercise 3: Covid-19 cases in CT and NY ##
########################################################################

counties <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")

head(counties)
str(counties)

# Filter the data set to only include observations from two states: CT and NY. Then create a line graph,
# with date on the x-axis and number of cases in that state on the y-axis. Plot CT and NY on separate lines.

# Remember to first filter the data, and then summarize across all counties on each day to get state totals 
# for each date. Line graphs will only work when we have ONLY one data point for each value on the x-axis.





