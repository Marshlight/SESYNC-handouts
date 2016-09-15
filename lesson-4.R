## Tidy data concept

counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20, 25, 30),
  fox = c(4, 4, 4)
)

## Reshaping multiple columns in category/value pairs

library(tidyr)
counts_gather <- gather(counts_df,
                        key = 'species',
                        value = 'count', 
                        wolf:fox)

counts_spread <- spread(counts_gather, key = 'species', value = 'count')
counts_spread <- spread(counts_gather, key = species, value = count) #also works, names in df

## Exercise 1
# Try removing a row from counts_gather (e.g. counts_gather <- counts_gather[-8, ]). 
# How does that affect the outcome of spread? Let’s say the missing row means that no 
# individual of that species was recorded on that day. How can you reflect that assumption 
# in the outcome of spread?

counts_gather2 = counts_gather[-8,]
counts_spread2 <- spread(counts_gather2, key = species, value = count) #Tuesday fox count is NA
counts_spread2 <- spread(counts_gather2, key = species, value = count, fill = 0) #0 vs NA

## Read comma-separated-value (CSV) files

surveys <- read.csv("data/surveys.csv",na.strings='')
str(surveys)

## Subsetting and sorting

library(dplyr)
surveys_1990_winter <- filter(surveys,
                              year == 1990,
                              month %in% 1:3)

surveys_1990_winter <- select(surveys_1990_winter, record_id, 
                              month, day, plot_id, species_id, 
                              sex, hindfoot_length, weight)
#OR
surveys_1990_winter <- select(surveys_1990_winter, -year)

sorted = arrange(surveys_1990_winter, species_id, desc(weight))

## Exercise 2
#Write code that returns the record_id, sex and weight of all 
#surveyed individuals of Reithrodontomys montanus (RO).
surveys_RO = filter(surveys, species_id == 'RO')
surveys_RO <- select(surveys_RO, record_id, sex, weight)
#OR
surveys_RO = select(filter(surveys, species_id == 'RO'), record_id, sex, weight)

## Grouping and aggregation

surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id)
counts_1990_winter <- summarize(surveys_1990_winter_gb, count = n())

## Exercise 3
#Write code that returns the average weight and hindfoot length of Dipodomys merriami (DM) 
#individuals observed in each month (irrespective of the year). Make sure to exclude NA values.
surveys_DM = filter(surveys, species_id == 'DM')
# surveys_DM = select(surveys_DM, month, hindfoot_length, weight) #unneeded I guess
surveys_DM_gb = group_by(surveys_DM, month) #what does this really do?????????
summarize(surveys_DM_gb, avg_wt = mean(weight, na.rm = TRUE),
                         avg_hf = mean(hindfoot_length, na.rm = TRUE))

## Pivto tables through aggregate and spread

surveys_1990_winter_gb <- group_by(surveys_1990_winter, ...)
counts_by_month <- ...(surveys_1990_winter_gb, ...)
pivot <- ...

## Transformation of variables

prop_1990_winter <- mutate(...)

## Exercise 4

...

## Chaining with pipes

#both are equivalent: 
c(1, 3, 5) %>% sum()
# [1] 9
sum(c(1,3,5))
# [1] 9
#but
c(1, 3, 5, NA) %>% sum(na.rm=TRUE) #is more convenient

prop_1990_winter_piped <- surveys %>%
  filter(year == 1990, month %in% 1:3) %>% 
  select(-year) %>%                 # select all columns but year
  group_by(species_id) %>%          # group by species_id 
  summarize(count = n()) #%>%       # summarize with counts 
#  mutate(prop = count / sum(count)) # mutate into proportions
