# loading libraries used in code
library(ggplot2)
library(broom)

# loading CSV file into global environment 
data2 <- read.csv("output with no vaccine data.csv", fileEncoding="UTF-8-BOM")

#converting date to dd/mm/yy format 
data2$Date = as.Date(data2$Date, format='%d-%m-%Y')

# performing one sided paired t test and storing as data frame 
a<- tidy(t.test(data2$DeathsModel, data2$DeathsModelNoVaccine, paired = TRUE, alternative = "less"))
a$p.value

b <- tidy(t.test(data2$InfectedModel, data2$InfectedModelNoVaccine, paired = TRUE, alternative = "less"))
b$p.value

# Plot of deaths with and without vaccine in our model
png("deaths_comparison.png", width = 4500, height = 3000, units = "px", res = 400)
p<- ggplot(data2, aes(Date, DeathsModel)) + 
  geom_point(aes(y=DeathsModel, color = "steelblue")) +
  geom_smooth(aes(y=DeathsModel, color = "steelblue")) +
  geom_point(aes(y = DeathsModelNoVaccine, color = "darkred")) +
  geom_smooth(aes(y = DeathsModelNoVaccine, color = "darkred")) +
  xlab("Time") + 
  ylab("Cumulative number of deaths") + 
  scale_color_manual(name = "Key", values = c("black", "red"), 
                     labels= c("Model with no vaccine", "Model with vaccine")) +
  theme(legend.text=element_text(size=14), legend.title = element_text(size = 16)) +
  theme(plot.title = element_text(hjust = 0.5)) +  
  theme(axis.text.x = element_text(hjust = 1, vjust = 0.5)) + 
  ggtitle("Comparison of deaths in our model with and without vaccine") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14), plot.title = element_text(face = "bold", hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21)) +
  theme(legend.justification = c("right", "top"),legend.position = c(0.95, 0.25)) 

p + labs(subtitle = "p value = 9.904732e-15 (one-sided paired T-test performed)")

dev.off()

#plot of infections with and without vaccine in our model
png("infections_comparison.png", width = 4500, height = 3000, units = "px", res = 400)
p2 <- ggplot(data2, aes(Date, DeathsModel)) + 
  geom_point(aes(y=InfectedModel, color = "steelblue")) +
  geom_smooth(aes(y=InfectedModel, color = "steelblue")) +
  geom_point(aes(y = InfectedModelNoVaccine, color = "darkred")) +
  geom_smooth(aes(y = InfectedModelNoVaccine, color = "darkred")) +
  xlab("Time") + 
  ylab("Daily number of infections") + 
  scale_color_manual(name = "Key", values = c("black", "red"), 
                     labels= c("Model with no vaccine", "Model with vaccine")) +
  theme(legend.text=element_text(size=14), legend.title = element_text(size = 16)) +
  theme(plot.title = element_text(hjust = 0.5)) +  
  theme(axis.text.x = element_text(hjust = 1, vjust = 0.5)) + 
  ggtitle("Comparison of daily infections in our \n model with and without vaccine") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14), plot.title = element_text(face = "bold", hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21)) +
  theme(legend.justification = c("right", "top"),legend.position = c(0.99, 0.95))

p2 + labs(subtitle = "p value < 2.2e-16 (one-sided paired T-test performed", size = 50)

dev.off()

max(data2$DeathsModelNoVaccine) - max(data2$DeathsModel)
max(data2$InfectedModelNoVaccine) - max(data2$InfectedModel) 
