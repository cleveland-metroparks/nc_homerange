library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Hello Shiny!"),

  # Sidebar with a slider input for the number of bins
   sidebarLayout(
     sidebarPanel(
       sliderInput("coy",
                   "Slide to get range of dates",
                   min = 1,
                   max = 1754, 
                   value = c(1,100)
     )),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
