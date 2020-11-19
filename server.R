library(shiny)
library(ggplot2)
library(dplyr)

# Read the required subset of the dataset.

diam <- diamonds[, c(1, 2, 3, 4, 7)]

# Program the application server.

shinyServer(
    function(input, output){
        output$outplot <- renderPlot({
            
            # Subset the dataset depending on the specified features for the regression.
            
            diam <- filter(diam,
                           grepl(input$clar, clarity),
                           grepl(input$cut, cut),
                           grepl(input$col, color))
            
            # Linear regression model.
            
            fit <- lm(price ~ carat, diam)
            
            # Predict the price of the diamond.
            
            pred <- predict(fit, newdata = data.frame(carat = input$car,
                                                       clarity = input$clar,
                                                       color = input$col,
                                                       cut = input$cut))
            pred
            
            # Price vs. Carat plot of the dataset containing the regression line.
            
            plt <- ggplot(data = diam, aes(x = carat, y = price)) +
                geom_point(aes(color = "red"), alpha = 0.5) +
                geom_smooth(method = "lm") +
                geom_vline(xintercept = input$car, color = "green") +
                geom_hline(yintercept = pred, color = "green") +
                labs(x = "Carat", y = "Price", title = "Price vs. Carat") +
                theme(plot.title = element_text(hjust = 0.5)) +
                theme(legend.position = "none")
            plt
            })
        
        output$result <- renderText({
            
            # Subset the dataset depending on the specified features for the regression.
            
            diam <- filter(diam,
                           grepl(input$clar, clarity),
                           grepl(input$cut, cut),
                           grepl(input$col, color))
            
            # Linear regression model.
            
            fit <- lm(price ~ carat, diam)
            
            # Predict the price of the diamond.
            
            pred <- predict(fit, newdata = data.frame(carat = input$car,
                                                       clarity = input$clar,
                                                       color = input$col,
                                                       cut = input$cut))
            pred
            
            # Prediction result.
            
            predres <- paste(round(pred, digits = 2), "USD")
            predres
            })
        })
