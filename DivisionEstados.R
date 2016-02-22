library(leaflet)
library(rgdal)
library(sp)
library(shiny)

#b<- runif(32)
#for(i in 1:32)
  
#  a[i]=rgb(colorRamp(c("red","white"),space = "rgb")(b[i])[1],
#         colorRamp(c("red","white"),space = "rgb")(b[i])[2],
#         colorRamp(c("red","white"),space = "rgb")(b[i])[3],maxColorValue = 255)

gama.red <- function(n){
  b<-runif(n)
  a<-c()
  for(i in 1:n)
    a[i]=rgb(colorRamp(c("red","white"),space = "rgb")(b[i])[1],
             colorRamp(c("red","white"),space = "rgb")(b[i])[2],
             colorRamp(c("red","white"),space = "rgb")(b[i])[3],maxColorValue = 255)
  return(a)
}

ogrInfo(".","dest_2012gw")
dest<-readOGR(".","dest_2012gw")  

a<-gama.red(32)

m <- leaflet() %>%
  addTiles() %>%  
  addPolygons(data=dest,color = a,stroke = F,popup=dest$NOM_ENT)
m 

#Implementado en shiny

ui <- fluidPage(
  leafletOutput("mymap"),
  p(),
  actionButton("recalc", "Nuevos colores")
)

server <- function(input, output, session) {
  
  a <- eventReactive(input$recalc, {
    gama.red(32)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addPolygons(data=dest,color = a(),stroke = F,popup=dest$NOM_ENT)
    
  })
}

shinyApp(ui, server)

