# Data
species <- read.csv("data/species.csv", stringsAsFactors = FALSE)
surveys <- read.csv("data/species.csv", na.strings = "", stringsAsFactors = FALSE)

# User Interface
in1 <- selectInput("pick_species",              #inputId =
                   label = "Pick a species",
                   choices = unique(species[["species_id"]]))
out1 <- textOutput("species_id")
tab <- tabPanel("Species", in1, out1)
ui <- navbarPage(title = "Portal Project", tab)

# Server
server <- function(input, output) {
  output[["species_id"]] <- renderText(input[["pick_species"]])
}

# Create the Shiny App
shinyApp(ui = ui, server = server)