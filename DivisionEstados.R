library(leaflet)
library(rgdal)
library(sp)

ogrInfo(".","dest_2012gw")
dest<-readOGR(".","dest_2012gw")  


b<- runif(32)

a<-c()

for(i in 1:32)
  
  a[i]=rgb(colorRamp(c("red","white"),space = "rgb")(b[i])[1],
         colorRamp(c("red","white"),space = "rgb")(b[i])[2],
         colorRamp(c("red","white"),space = "rgb")(b[i])[3],maxColorValue = 255)


m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  #addPolygons(data=dest,color = colorRampPalette(c("red","white"))(32),stroke = F,popup=dest$NOM_ENT)
  addPolygons(data=dest,color = a,stroke = F,popup=dest$NOM_ENT)
m 
