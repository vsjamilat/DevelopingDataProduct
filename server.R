# server.R file for the shiny app
# This app was developed to predict the weight of a car (in 1000 lbs) given the fuel efficiency in miles per gallon for the car
# using mtcars dataset from [R]

library(shiny)
shinyServer(function(input, output) {
  mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
  model1 <- lm(wt ~ mpg, data = mtcars)
  model2 <- lm(wt ~ mpgsp + mpg, data = mtcars)
  
  model1pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model1, newdata = data.frame(mpg = mpgInput))
  })
  
  model2pred <- reactive({
    mpgInput <- input$sliderMPG
    predict(model2, newdata =
              data.frame(mpg = mpgInput,
                         mpgsp = ifelse(mpgInput - 20 > 0,
                                        mpgInput - 20, 0)))
  })
  
  output$plot1 <- renderPlot ({
    mpgInput <- input$sliderMPG
    plot(mtcars$mpg, mtcars$wt, xlab = "Miles Per Gallon",
         ylab = "Weight (1000 lbs)", bty = "n", pch = 24,
         xlim = c(9, 35), ylim = c(1, 6))
    if(input$showModel1){
      abline(model1, col = "red", lwd = 2)
    }
    if(input$showModel2){
      model2lines <- predict(model2, newdata = data.frame(
        mpg = 9:35, mpgsp = ifelse(9:35 - 20 > 0, 9:35 - 20, 0)
      ))
      lines(9:35, model2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16,
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(mpgInput, model1pred(), col = "red", pch = 17, cex = 2)
    points(mpgInput, model2pred(), col = "blue", pch = 17, cex = 2)
    
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})
