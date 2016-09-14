## The Editor

vals <- seq(1,100)
vals <- seq(from=1, to=100)
vals <- seq(to=100, from=1)
vals <- seq(100,1)
vals <- 1:100

## Vectors

counts ...

## Lists

... <- list(...)
... <- ...(list(1, 2), c(3, 4))

## Factors

education <- ...(c("college", "highschool", "college", "middle"),
                 ... = c("middle", "highschool", ...),
                 ...)

## Data Frames

... data.frame(...)

## Exercise 1

...

## Names

names(...) <- ...

## Subsetting ranges

days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
weekdays <- ...
...

## Exercise 2

...

## Anatomy of a function

function(...) {
  ...
  return(...)
}

## Exercise 3

...

## Distributions and statistics

x <- rnorm(..., mean = .., sd = ...)
y <- r...(n = 100, size = 50, ...)

fit <- ...

## Exercise 4

...

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
missing <- setdiff(...,
                   rownames(installed.packages()))

if (...) {
  install.packages(missing)
}
