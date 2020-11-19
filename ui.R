library(shiny)

# Program the application UI.

shinyUI(
    fluidPage(
        titlePanel("Diamond Price Prediction"),
        sidebarLayout(
            sidebarPanel(
                helpText("Specify the 4Cs of the diamond to predict its price."),
                sliderInput("car", label = h4("Carats"), min = 0.2, max = 5.0,
                             step = 0.01, value = 1, ticks = FALSE),
                selectInput("clar", label = h4("Clarity"),
                            choices = list("Select" = "*", "I1" = "I1",
                                           "SI2" = "SI2", "SI1" = "SI1",
                                           "VS2" = "VS2", "VS1" = "VS1",
                                           "VVS2" = "VVS2", "VVS1" = "VVS1",
                                           "IF" = "IF" )),
                selectInput("col", label = h4("Color"),
                            choices = list("Select" = "*", "D" = "D",
                                           "E" = "E", "F" = "F",
                                           "G" ="G", "H" = "H",
                                           "I" = "I", "J" = "J")),
                selectInput("cut", label = h4("Cut"),
                            choices = list("Select" = "*", "Fair" = "Fair",
                                           "Good" = "Good", "Very Good" = "Very Good",
                                           "Premium" = "Premium", "Ideal" = "Ideal"))
                ),
            
            # Price vs. Carat plot of the dataset containing the regression line.
            
            mainPanel(
                plotOutput("outplot"),
                h3("Predicted Price: "),
                h3(textOutput("result"))
                )
            )
        )
    )
