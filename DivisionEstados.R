library(leaflet)
library(rgdal)
library(sp)
library(shiny)

ogrInfo(".","dest_2012gw")
dest<-readOGR(".","dest_2012gw")  

a<-runif(32) 
a<-round(a*1000)
b<-colorRampPalette(c("red","white"))(1000)[a]

m <- leaflet() %>%
  addTiles() %>%  
  addPolygons(data=dest,color = b,stroke = F,popup=dest$NOM_ENT) %>% 
  addProviderTiles("CartoDB.Positron") %>%
  addLegend(pal = colorNumeric(palette = colorRampPalette(c("white","red"))(32),domain = c(1,0)),values =seq(0,1,length.out = 32),title = "Cantidad de Municipios")
m 

#Implementado en shiny

ui <- fluidPage(
  leafletOutput("mymap"),
  p(),
  actionButton("recalc", "Nuevos colores")
)

server <- function(input, output, session) {
  
  a <- eventReactive(input$recalc, {
    colorRampPalette(c("red","white"))(1000)[round(1000*runif(32))]
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addPolygons(data=dest,color = a(),stroke = F,popup=dest$NOM_ENT) %>%
      addProviderTiles("CartoDB.Positron")
  })
}

shinyApp(ui, server)
