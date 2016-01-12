library(XML)
library(RCurl)
library(ggmap)

# Get Table
theurl <- getURL("https://en.wikipedia.org/wiki/Overseas_Chinese",.opts = list(ssl.verifypeer = FALSE) )
tables <- readHTMLTable(theurl)
neededTable <- tables[4]
neededTable <- neededTable[1]
ChineseOverseas <- neededTable$`NULL`
ChineseOverseas <- ChineseOverseas[-c(1, 37, 38, 62, 63, 85, 86, 107,108), ]
ChineseOverseas <- ChineseOverseas[, -c(2)]

# Export to CSV
write.csv(ChineseOverseas, file = "~/Dropbox/ChineseOverseas.csv")
class(ChineseOverseas$Overseas.Chinese.population)

ChineseOverseas$Continent...country[6] <- "Reunion"

locations <- as.character(ChineseOverseas$Continent...country)
row_count <- length(locations)
lat <- c()
lon <- c()

for (i in 1 : row_count)
{
  print(i)
  location <- locations[i]
  geocodeRes <- geocode(location, output = "latlon", "google")
  lon <- rbind(lon, geocodeRes$lon)
  lat <- rbind(lat, geocodeRes$lat)
}
ChineseOverseas <- ChineseOverseas[, c(-1)]
ChineseOverseas2 <- cbind.data.frame(ChineseOverseas, lon, lat)

# Create map
mp <- NULL
mapWorld <- borders("world", colour="gray50") # create a layer of borders
mp <- ggplot() +   mapWorld

mp <- mp + 
  geom_point(aes(x=ChineseOverseas2$lon, y=ChineseOverseas2$lat, color = log(ChineseOverseas2$Overseas.Chinese.population)), size=5)+ 
  scale_color_continuous(name="Log of Overseas Chinese Population") +
  geom_text(aes(x=ChineseOverseas2$lon, y=ChineseOverseas2$lat,label=ifelse((ChineseOverseas2$Overseas.Chinese.population)>1000000,ChineseOverseas2$Continent...country,'')),hjust=1, vjust=0, size = 5, angle = 45) +
  labs(title = "Distribution of Chinese Overseas Globally")
mp
