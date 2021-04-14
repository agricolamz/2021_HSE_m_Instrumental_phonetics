# Moroz 2021
# based on https://docs.ropensci.org/phonfieldwork/articles/phonfieldwork.html

setwd("~/Desktop/4_inst_phonetics/")
df <- read.csv("stimuli_list.csv")
df

#install.packages("phonfieldwork")
library(phonfieldwork)

rename_soundfiles(stimuli = df$stimuli,
                  prefix = "d1_",
                  path = "d1/")

rename_soundfiles(stimuli = df$stimuli,
                  prefix = "d2_",
                  path = "d2/")

concatenate_soundfiles(path = "d1/",
                       result_file_name = "d1_all")

concatenate_soundfiles(path = "d2/",
                       result_file_name = "d2_all")

annotate_textgrid(annotation =  df$stimuli,
                  textgrid = "d1/d1_all.TextGrid",
                  backup = FALSE)

annotate_textgrid(annotation =  df$stimuli,
                  textgrid = "d2/d2_all.TextGrid",
                  backup = FALSE)

create_subannotation(textgrid = "d1/d1_all.TextGrid",
                     tier = 1,
                     n_of_annotations = 9)

create_subannotation(textgrid = "d1/d1_all.TextGrid",
                     tier = 1,
                     n_of_annotations = 9)

create_subannotation(textgrid = "d2/d2_all.TextGrid",
                     tier = 1,
                     n_of_annotations = 9)

create_subannotation(textgrid = "d2/d2_all.TextGrid",
                     tier = 1,
                     n_of_annotations = 9)

annotate_textgrid(annotation = rep(c("", "u1", "", "u2", "", "u3", "", "cf", ""), nrow(df)),
                  textgrid = "d1/d1_all.TextGrid",
                  tier = 2,
                  backup = FALSE)

annotate_textgrid(annotation = rep(c("", "u1", "", "u2", "", "u3", "", "cf", ""), nrow(df)),
                  textgrid = "d2/d2_all.TextGrid",
                  tier = 2,
                  backup = FALSE)

vowel_annotation <- unlist(lapply(df$vowel, function(x) c(rep(c("", x), 4), "")))

annotate_textgrid(annotation = vowel_annotation,
                  textgrid = "d1/d1_all.TextGrid",
                  tier = 3,
                  backup = FALSE)

vowel_annotation2 <- unlist(lapply(c(df$vowel, "e"), function(x) c(rep(c("", x), 4), "")))
annotate_textgrid(annotation = vowel_annotation2,
                  textgrid = "d2/d2_all.TextGrid",
                  tier = 3,
                  backup = FALSE)

draw_sound(file_name = "d1/d1_all.wav", 
           annotation = "d1/d1_all.TextGrid",
           zoom = c(0, 10))

draw_sound(file_name = "d2/d2_all.wav", 
           annotation = "d2/d2_all.TextGrid",
           zoom = c(0, 10))

d1_df <- textgrid_to_df("d1/d1_all.TextGrid")
d2_df <- textgrid_to_df("d2/d2_all.TextGrid")

#install.packages("tidyverse")
library(tidyverse)
rbind(d1_df, d2_df) %>% 
  filter(content != "",
         tier == 3) %>% 
  mutate(speaker = str_extract(source, "d\\d"),
         duration = time_end - time_start) %>% 
  select(content, speaker, duration) %>% 
  ggplot(aes(duration))+
  geom_dotplot()+
  facet_grid(speaker~content)+
  theme_bw()
