library(shiny)
library(ggplot2)
library(DT)
library(shinythemes)

shinyUI(fluidPage(
  
  titlePanel("The Mining Stock Scale"),
  
  sidebarLayout(
    sidebarPanel(
          sliderInput("weightG1", "weight G1:",
                      min = 0, max = 20,
                      value = 7),
          sliderInput("weightG2", "weight G2:",
                      min = 0, max = 20,
                      value = 6),
          sliderInput("weightG3", "weight G3:",
                      min = 0, max = 6,
                      value = 0.8, step = 0.2)
    ),
    mainPanel(
          tabsetPanel(
                tabPanel(title = "Adjust your mining stock",
                         plotOutput(outputId = "Plot", brush = "user_brush"),
                         DT::dataTableOutput(outputId = "Table"),
                         downloadButton(outputId = "download", label = "Download data")),
                tabPanel("Documentation")
                )
          )
    )
))
