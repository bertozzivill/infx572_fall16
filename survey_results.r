################################################################################
## Author: Amelia Bertozzi-Villa
## 
## Prep survey results from Fall '16 class
################################################################################

library(data.table)
library(ggplot2)
library(grid)
library(gridExtra)

main_dir <- "C:/Users/abertozzivilla/ischool/"
data <- fread(paste0(main_dir, "welcome_survey.csv"))

# Plots by Sex
gender_df <- data[gender!=""]
gender_df[,gender_count:= 1]
gender_df[,gender_count:= sum(gender_count), by="gender"]
gender_df <- gender_df[order(gender)]
position <- unique(gender_df[, list(gender, gender_count)])
position[, position:= cumsum(gender_count)-0.5*gender_count]
gender_df <- merge(gender_df, position, by=c("gender", "gender_count"))

# age/gender breakdown
gender <- ggplot(gender_df, aes(x=factor(1), fill=gender)) +
          geom_bar(width=1) +
          coord_polar(theta="y") +
          labs(title="INFX 572 students, by Gender",
               x="",
               y="") +
          scale_fill_discrete(name="") +
          theme(legend.position="bottom",
                axis.text=element_blank(),
                axis.ticks=element_blank(),
                panel.grid=element_blank()) +
          geom_text(aes(label = sprintf("%i", gender_count), y=position), size=10)
          
gender_age_df <- data[age!="" & gender!=""]
gender_age_df[, gender_age_count:= 1]
gender_age_df[, gender_age_count:= sum(gender_age_count), by=c("gender", "age")]
gender_age_df <- gender_age_df[order(age, gender)]
position <- unique(gender_age_df[, list(gender, age, gender_age_count)])
position[, position:= (cumsum(gender_age_count)-0.5*gender_age_count)/sum(gender_age_count), by="age"]
gender_age_df <- merge(gender_age_df, position, by=c("gender", "age", "gender_age_count"))
gender_age_df[, position_x := ifelse(age=="35-40", 0.5, 1)]

gender_by_age <- ggplot(gender_age_df, aes(x=factor(1), fill=gender)) +
                  geom_bar(width=1, position="fill") +
                  coord_polar(theta="y") +
                  facet_wrap(~age) +
                  labs(title="INFX 572 students, by Gender and Age",
                       x="",
                       y="") +
                  scale_fill_discrete(name="") +
                  theme(legend.position="bottom",
                        axis.text=element_blank(),
                        axis.ticks=element_blank(),
                        panel.grid=element_blank()) +
                  geom_text(aes(label = sprintf("%i", gender_age_count), y=position, x=position_x), size=5)


# Age by gender
age <- ggplot(data[age!="" & gender!=""], aes(x=age, fill=age)) +
        geom_bar() +
        theme(legend.position="none") +
        labs(title= "INFX 572 Students, by Age",
             x="Age",
             y="Count")

age_by_gender <- age + facet_grid(~gender)


# Programming and Stats Background

# adjust stats background
data[, stats_background:= ifelse(stats_background %like% "undergrad", "undergrad", 
                                 ifelse(stats_background %like% "high school", "high",
                                        ifelse(stats_background %like% "grad school", "grad", "none")))]
data[, stats_background:= factor(stats_background, levels=c("none", "high", "undergrad", "grad"))]
levels(data$stats_background) <- c("None", "High School", "Undergrad", "Grad")

# adjust labeling for programming background
data[, programmer:= paste(programmer, "Programming")]

# find counts and positions for pie chart
prog_data <- copy(data)
prog_data[, programmer_count:=1]
prog_data[, programmer_count:= sum(programmer_count), by="programmer"]
programmer <- unique(prog_data[, list(programmer, programmer_count)])
programmer <- programmer[order(programmer)]
programmer[, programmer_pos:= cumsum(programmer_count)-0.5*programmer_count]
prog_data <- merge(prog_data, programmer, by=c("programmer", "programmer_count"), all=T)

programming <- ggplot(prog_data, aes(x=factor(1), fill=programmer)) +
                geom_bar(width=1) +
                coord_polar(theta="y") +
                labs(title="INFX 572 students, by Programming Background",
                     x="",
                     y="") +
                scale_fill_discrete(name="") +
                theme(legend.position="bottom",
                      axis.text=element_blank(),
                      axis.ticks=element_blank(),
                      panel.grid=element_blank()) +
              geom_text(aes(label = sprintf("%i", programmer_count), y=programmer_pos))

stats <- ggplot(data, aes(x=stats_background)) + 
          geom_bar(aes(fill=stats_background)) +
          theme(axis.text.x = element_text(angle = 45, hjust = 1),
                legend.position="none") +
          labs(title = "INFX 572 Students, by Statistics Experience",
               x="Stats Experience",
               y="Count")

programming_stats_layout <- rbind(c(1,1,1,1),
                                  c(1,1,1,1),
                                  c(1,1,1,1),
                                  c(NA,2,2,NA),
                                  c(NA,2,2,NA))


program_stats <- ggplot(data, aes(x=stats_background)) +
                  geom_bar(aes(fill=stats_background)) +
                  facet_grid(~programmer)+
                  theme(axis.text.x = element_text(angle = 45, hjust = 1),
                        legend.position="none") +
                  labs(title = "INFX 572 Students, by Programming Background and Stats Experience",
                       x="Stats Experience",
                       y="Count")

# Country
nationality <- ggplot(data[country!=""], aes(x=country, fill=country)) +
                geom_bar()+
                theme(legend.position="none") +
                labs(title="INFX 572 Students, by Country of Origin",
                     x="Country",
                     y="County")


plot_list <- list(gender, gender_by_age, age, age_by_gender, program_stats, nationality)
names(plot_list) <- c("gender", "gender_by_age", "age", "age_by_gender", "program_stats", "nationality")

for (plot_name in names(plot_list)){
  plot <- plot_list[[plot_name]]
  png(paste0(main_dir, "welcome_plots/", plot_name, ".png"))
  print(plot)
  graphics.off()
}

png(paste0(main_dir, "welcome_plots/programming_stats_stacked.png"))
grid.arrange(programming, stats, layout_matrix=programming_stats_layout)
graphics.off()


# pdf(paste0(main_dir, "welcome_plots.pdf"), width=10, height=10)
# 
# print(gender)
# print(gender_by_age)
# print(age)
# print(age_by_gender)
# grid.arrange(programming, stats, layout_matrix=programming_stats_layout)
# print(program_stats)
# 
# graphics.off()
