setwd("...") # put your path here
library(tidyverse)
n <- read_csv("n.csv")
n$sound_type <- "n"
m <- read_csv("m.csv")
m$sound_type <- "m"

n %>% 
  bind_rows(m) %>% 
  filter(`freq(Hz)` < 5000) %>% 
  ggplot(aes(`freq(Hz)`, `pow(dB/Hz)`, color = sound_type))+
  geom_line()
