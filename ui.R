library(shiny)
shinyUI (fluidPage(
  titlePanel("This app was developed This application predicts the weight of a car (1000 lbs) given the fuel efficiency in miles per gallon for the car (MPG)"),
  sidebarLayout (
    sidebarPanel(
      sliderInput("sliderMPG", "What is the MPG of the car?", 10, 35, value = 10),
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Weight (1000 lbs) from Model 1:"),
      textOutput("pred1"),
      h3("Predicted  Weight (1000 lbs) from Model 2:"),
      textOutput("pred2")
    )
  )
))