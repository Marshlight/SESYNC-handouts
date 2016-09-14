## The Editor

vals <- seq(1,100)
vals <- seq(from=1, to=100)
vals <- seq(to=100, from=1)
vals <- seq(100,1)
vals <- 1:100

## Vectors

counts <- c(4,3,7,5) #to make vector

## Lists

x <- list(list(1,2),c(3,4))
y <- c(list(1, 2), c(3, 4))

## Factors

education <- factor(c("college", "highschool", "college", "middle"),
                 levels = c("middle", "highschool", "college"),
                 ordered=TRUE)

## Data Frames

df <- data.frame(education, counts)

## Exercise 1

species <- c("frogs","dogs","cats","ravens")
count <- c(3, 10, 5, 2)
df2 <- data.frame(species,count)

## Names

names(df) <- c('ed','ct')

## Subsetting ranges

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
weekdays <- days[2:6]
weekends <- days[c(1,7)]

## Exercise 2

weekdays2 <- days[c(-1,-7)]
MWF <- days[seq(2,6,2)]    #from, to, by
MWF <- days[seq(-1,-7,-2)]

## Anatomy of a function

first = function(x) {
  result = x[1,1]
  return(result)
}

## Exercise 3

> df[2:3,1]
[1] highschool college   
Levels: middle < highschool < college

## Distributions and statistics

x <- rnorm(n = 100, mean = 25, sd = 7)
y <- rbinom(n = 100, size = 50, prob = .85)
t.test(x, y)

fit <- lm(y ~ x)
summary(fit)

## Exercise 4
df4 <- data.frame(
  size = 1:5,
  year = factor(
    c(2014, 2014, 2013, 2015, 2015),
    levels = c(2013, 2014, 2015),
    ordered = TRUE),
  prop = runif(n = 5))
fit <- lm(prop ~ size + year, data = df4)

## Install missing packages

requirements <- c('dplyr',
                  'ggplot2',
                  'leaflet',
                  'RSQLite',
                  'rgdal',
                  'rgeos',
                  'raster',
                  'shiny',
                  'sp',
                  'tidyr',
                  'tmap')
missing <- setdiff(requirements,
                   rownames(installed.packages()))

if (length(missing) != 0) {
  install.packages(missing)
}
