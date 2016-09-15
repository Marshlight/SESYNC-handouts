## Libraries and data

library(dplyr)
library(ggplot2)
surveys <- read.csv('data/surveys.csv', na.strings = "") %>%
  filter(!is.na(species_id), !is.na(sex), !is.na(weight)) #na.strings interprets blanks as NA

## Constructing layered graphics in ggplot

ggplot(data = surveys, aes(x=species_id, y=weight)) +
       geom_point()
#OR
ggplot(surveys, aes(species_id, weight)) + geom_boxplot() 
#ggplot does not plot anything until we add a geom layer such as geom_point

ggplot(data = surveys,
       aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_point(stat = "summary", #what kind of stat do you want
             fun.y = "mean",   #where/which?
             color = "red")    #has to go last otherwise red dots will be buried!
# ggplot(data = surveys,
#        aes(x = species_id, y = weight)) +
#   geom_point(stat = "summary",
#              fun.y = "mean",
#              color = "red") +
#   geom_boxplot()

qplot(x = species_id, y = weight, data = surveys, geom = "boxplot")

## Exercise 1
#Using dplyr and ggplot show how the mean weight of individuals of the species DM 
#varies across years and between males and females.

# ggplot(data = filter(surveys, species_id == 'DM'), aes(x=year, y=weight)) + geom_point()

surveys_DM_M = filter(surveys, species_id == 'DM', sex == 'M')
surveys_DM_F = filter(surveys, species_id == 'DM', sex == 'F')

ggplot() +
  geom_point(data = surveys_DM_M, aes(x=year, y=weight),
             stat = "summary",
             fun.y = "mean",
             color = 'red') +
  geom_point(data = surveys_DM_F, aes(x=year, y=weight),
            stat = "summary",
            fun.y = "mean",
            color = 'blue')

#OR elegant way
surveys_DM = filter(surveys, species_id == 'DM')
ggplot(surveys_DM, aes(year, weight))+
  geom_point(stat="summary",
             fun.y = "mean",
             aes(color=factor(sex))) #factor(sex) can also just be sex
#OR
filter(surveys, species_id == "DM") %>%
  ggplot(aes(x = year, y = weight, color = sex)) +
  geom_line(stat = "summary", fun.y = "mean")

## Adding a regression line

levels(surveys$sex) <- c("Female", "Male")
surveys_DM = filter(surveys, species_id == 'DM')
ggplot(surveys_DM,
       aes(x = year, y = weight, color = sex)) + #color=sex will be consistent for all layers
  geom_point(aes(shape=sex),                     #or can specify individually in point/smooth
             size = 3,
             stat = "summary",
             fun.y = "mean") +
  geom_smooth(aes(group=sex),method = 'lm') #linear model

# Storing and re-plotting

year_wgt <- ggplot(data = surveys_DM,
                   aes(x = year,
                       y = weight,
                       color = sex)) +
            geom_point(aes(shape = sex),
                       size = 3,
                       stat = "summary",
                       fun.y = "mean") +
            geom_smooth(method = "lm")
               
year_wgt <- year_wgt +
  scale_color_manual(values = c("darkblue", "orange")) #store new info
year_wgt

## Exercise 2
#Create a histogram, using a geom_histogram() layer, of the weights of individuals of 
#species DM and divide the data by sex. Note that instead of using color in the aesthetic, 
#you’ll use fill to distinguish the sexes. Also look at the documentation and determine 
#how to explicitly set the bin width.

  ggplot(data = surveys_DM,
                aes(x = weight,
                    fill = sex)) +
  geom_histogram(binwidth = 3) #optional ' stat = "bin" '

## Axes, labels and themes

histo = ggplot(data = surveys_DM,
                aes(x = weight, fill = sex)) +
  geom_histogram(binwidth = 3, color = "white")
histo

histo <- histo + 
  labs(title = "Dipodomys merriami weight distribution",
       x = "Weight (g)",
       y = "Count") +
  scale_x_continuous(limits = c(20, 60),
                     breaks = c(20, 30, 40, 50, 60))
histo

histo <- histo +
  theme_bw() +
  theme(legend.position = c(0.2, 0.5),
        plot.title = element_text(face = "bold", vjust = 2),
        axis.title.y = element_text(size = 13, vjust = 1), 
        axis.title.x = element_text(size = 13, vjust = 0))
histo

## Facets
surveys_DM$month <- as.factor(surveys_DM$month)
levels(surveys_DM$month) <- c("January", "February", "March", "April", "May", "June",
                              "July", "August", "September", "October", "November", "December")

ggplot(data = surveys_DM,
       aes(x = weight)) +
  geom_histogram() +
  facet_wrap( ~ month)
  labs(title = "DM weight distribution by month",
       x = "Count",
       y = "Weight (g)")

ggplot(data = surveys_DM,
       aes(x = weight, fill = month)) +
  ...
  facet_wrap( ~ month) +
  labs(title = "DM weight distribution by month",
       x = "Count",
       y = "Weight (g)") +
  guides(fill = FALSE)

## Exercise 3

...

