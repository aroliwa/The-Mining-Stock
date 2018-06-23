library(shiny)
library(ggplot2)
library(DT)
library(shinythemes)
library(dplyr)

shinyServer(function(input, output, session) {

   
      dataProject <- read.csv(file = "data_project.csv", header = TRUE, sep = ";")
      attach(dataProject)
      
      dataProcessed <- reactive({
            dataProject %>%
                  mutate(MiningStockEvaluation = input$weightG1 * G1 + input$weightG2 * G2 + input$weightG3 * G3)
      })
      
      output$Plot <- renderPlot({
            dataProcessed() %>%
                  ggplot(aes(x = MiningStockEvaluation, y = MarketCap.in.M)) +
                  geom_point() +
                  geom_smooth(method = "lm") +
                  xlab("Your Calculated Score") + 
                  ylab("Market Capitalization in Million USD")
      })
      
      myNewData <- reactive({
            user_brush <- input$user_brush
            mysel <- brushedPoints(dataProcessed(), user_brush)
            return(mysel)
      })
      
      output$Table <- DT::renderDataTable(DT::datatable(myNewData()))
      
      output$download <- downloadHandler(
            filename = "data.csv",
            content = function(file){
                  write.csv(x = dataProj(), file)
            })
  
})
