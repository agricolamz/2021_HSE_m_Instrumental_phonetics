library(ggplot2)
df <- read.csv(file.choose(), sep = "\t", header = FALSE)

ggplot(data = df, aes(V1, V2)) +
  geom_point()+
  ggtitle("My title")
