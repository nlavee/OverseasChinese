library(mosaic)
countries <- c("China", "U.S.", "Japan", "Germany", "U.K.", "France")
num <- c(228, 248, 171, 399, 129, 334)
df.world <- data.frame(countries, num)

barchart(num ~ countries, data = df.world,
         xlab = "Countries", ylab = "Count of Embassies", 
         main = "Number of Embassies Around The World")

asia <- c("China", "Japan", "India", "South Korea", "Indonesia", "Vietnam")
numAsia <- c(228, 171, 198, 139, 177, 78)
df.asia <- data.frame(asia, numAsia)

barchart(numAsia ~ asia, data = df.asia,
         xlab = "Countries", ylab = "Count of Embassies", 
         main = "Number of Embassies Around The World for Asian Countries")
