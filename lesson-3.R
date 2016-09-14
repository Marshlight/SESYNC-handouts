# Database connections from R

library(RSQLite)
con <- dbConnect(SQLite(), "data/portal.sqlite")
dbGetQuery(con, "pragma foreign_keys = on")
dbListTables(con)

# Two ways to access data

plots <- dbReadTable(con, "plots")
species = dbReadTable(con, "species")
surveys <- dbReadTable(con,"surveys")

dbGetQuery(con, "select species_id, weight
                 from surveys
                 where plot_id = 1 limit 5") #MAGIC~!!!

# Exercise 1
#Use dbGetQuery() to select the “species_id”, and two other fields from the “species” table. 
#Hint: use dbListFields() to check field names. 
# > dbListFields(con,"species")
# [1] "species_id" "genus"      "species"    "taxa"  
dbGetQuery(con, "select species_id, genus, species, taxa
                 from species
                 limit 5")

# Primary keys

dbGetQuery(con, "insert into plots
          (plot_id, plot_type)
          values (1, 'Control')")
# Error in sqliteSendQuery(con, statement, bind.data) : 
#   rsqlite_query_send: could not execute1: UNIQUE constraint failed: plots.plot_id

# Foreign keys

dbGetQuery(con, "insert into surveys
                 (record_id, plot_id, species_id, sex)
                 values (35549, 1, '00', 'M')")
# Error in sqliteSendQuery(con, statement, bind.data) : 
#   rsqlite_query_send: could not execute1: FOREIGN KEY constraint failed

# One-to-Many Relationship

df <- dbGetQuery(con, "select weight, month, plot_type
                       from surveys
                       join plots on surveys.plot_id = plots.plot_id
                       where weight is not null")
str(df)

## Exercise 2
#Construct a data frame that you could use to fit the regression model 
#“weight ~ month + plot_type + taxa”.
...
