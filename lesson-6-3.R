# Libraries
library(dplyr)
library(ggplot2)

# Data
species <- read.csv("data/species.csv", stringsAsFactors = FALSE)
surveys <- read.csv("data/surveys.csv", na.strings = "", stringsAsFactors = FALSE)

# User Interface
in1 <- selectInput("pick_species",
                   label = "Pick a species",
                   choices = unique(species[["species_id"]]))
out1 = textOutput('species_name')
out2 = plotOutput('species_plot')
tab <- tabPanel("Species", in1, out1, out2)
ui <- navbarPage(title = "Portal Project", tab)

# Server
server <- function(input, output) {
  output[["species_name"]] <- renderText( 
#     out1 = filter(species, species_id == input[["pick_species"]]) #theoretical but command 
#     out1 = paste(out1[2:3], collapse = ' ')                       #line doesn't work in shiny!
    species %>%
      filter(species_id == input[["pick_species"]]) %>%
      select(genus, species) %>%
      paste(collapse = ' ')
  )
  output[["species_plot"]] <- renderPlot(
    surveys %>%
      filter(species_id == input[["pick_species"]]) %>%
      ggplot(aes(year)) + 
      geom_bar()
  ) 
}

# Create the Shiny App
shinyApp(ui = ui, server = server)