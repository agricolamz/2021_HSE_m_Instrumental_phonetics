library(tidyverse)
n <- read_csv("andi_nasals_0_897.Table")
n$sound_type <- "n"
m <- read_csv("m.Table")
m$sound_type <- "m"

n %>% 
  bind_rows(m) %>% 
  filter(`freq(Hz)` < 5000) %>% 
  ggplot(aes(`freq(Hz)`, `pow(dB/Hz)`, color = sound_type))+
  geom_line()
