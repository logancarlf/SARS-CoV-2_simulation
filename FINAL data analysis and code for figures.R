# load ggplot2 package from repository
library(ggplot2)


# loaded data file into global environment
data<- read.csv("OUTPUT.csv", fileEncoding="UTF-8-BOM")
class(data$Date)
data$Date = as.Date(data$Date, format='%d-%m-%Y')
class(data$Date)

# plot of infected individuals in the UK
#png("infections.png", width = 4500, height = 3000, units = "px", res = 400)
ggplot(data, aes(Date, cumInfected)) + 
  geom_point(aes(y=cumInfected, color = "steelblue")) +
  geom_smooth(aes(y=cumInfected, color = "steelblue")) +
  geom_point(aes(y = mod_inf, color = "darkred")) +
  geom_smooth(aes(y = mod_inf, color = "darkred")) +
  xlab("Time") + 
  ylab("Daily number of infected individuals") + 
  scale_color_manual(name = "Key", values = c("black", "red"), 
                     labels= c("Model", "Government data")) +
  theme(legend.text=element_text(size=14), legend.title = element_text(size = 16)) +
  theme(plot.title = element_text(hjust = 0.5)) +  
  theme(axis.text.x = element_text(hjust = 1, vjust = 0.5)) + 
  ggtitle("Daily number of infected individuals in UK") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14), plot.title = element_text(face = "bold", hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21)) +
  theme(legend.justification = c("right", "top"),legend.position = c(0.95, 0.95)) 



dev.off()
#dev.off()

# plot of cumulative number of deaths in the UK
png("deaths.png", width = 4500, height = 3000, units = "px", res = 400)
ggplot(data, aes(Date, cumDeaths)) + 
  geom_point(aes(y=cumDeaths, color = "steelblue")) + 
  geom_smooth(aes(y = cumDeaths, color = "steelblue")) + 
  geom_point(aes(y = mod_death, color = "darkred")) +
  geom_smooth(aes(y = mod_death, color = "darkred")) +
  scale_color_manual(name = "Key", values = c("black", "red"), 
                     labels= c("Model", "Government data")) +
  theme(legend.text=element_text(size=14), legend.title = element_text(size = 16)) +
  xlab("Time") + 
  ylab("Cumulative number of deaths") + 
  ylim(60000, 140000) +
  theme(axis.text.x = element_text(hjust = 1, vjust = 0.5)) + 
  ggtitle("Cumulative number of deaths in UK") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14)
        ,plot.title = element_text(face = "bold", 
                                   hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21)) +
  theme(legend.justification = c("right", "top"),legend.position = c(0.95, 0.95)) 


dev.off()

# plot of cumulative number of first dose vaccine in UK
png("vaccines.png", width = 4500, height = 3000, units = "px", res = 400)
ggplot(data, aes(Date, cumPplVac)) + 
  geom_point(aes(y=cumPplVac, color = "steelblue")) + 
  geom_smooth(aes(y=cumPplVac, color = "steelblue"))+ 
  xlab("Time") + 
  ylab("Number of first doses given") + 
  geom_point(aes(y= mod_vacc, color = "darkred")) + 
  geom_smooth(aes(y=mod_vacc, color = "darkred")) + 
  scale_color_manual(name = "Key", values = c("black", "red"), labels= c("Model", "Government data")) +
  theme(legend.text=element_text(size=14), legend.title = element_text(size = 16)) +
  ggtitle("Cumulative number of vaccinations administered in UK") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14)
        ,plot.title = element_text(face = "bold", 
                                   hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21)) +
  theme(legend.position = c(0.75,0.25)) 

dev.off()
dev.new()
# calculating proportional difference between cumulative number of deaths of our 
# model and goverment data
png("deaths_diff.png", width = 4500, height = 3000, units = "px", res = 400)
data$diff_deaths <- abs(data$mod_death - data$cumDeaths)
data$diff_deaths_prop <- data$diff_deaths / data$cumDeaths
ggplot(data, aes(Date, diff_deaths_prop)) + 
  geom_point(aes(y=diff_deaths_prop)) + 
  geom_smooth(aes(y=diff_deaths_prop))+ 
  xlab("Time") + 
  ylab("Degree of error") +
  ylim (0, 0.08) +
  ggtitle("Comparison of deaths between model and goverment data") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14)
        ,plot.title = element_text(face = "bold", 
                                   hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21))
dev.off()

#outliers of the proportional difference between cumulative number of deaths of our 
#model and goverment data
iqr_diff_deaths <- IQR(data$diff_deaths)
lowerq_diff_deaths = quantile(data$diff_deaths)[2]
lowerq_diff_deaths

upperq_diff_deaths = quantile(data$diff_deaths)[4]
upperq_diff_deaths

outlierlower_diff_deaths = lowerq_diff_deaths - (iqr_diff_deaths * 1.5)
outlierlower_diff_deaths

outlierupper_diff_deaths = upperq_diff_deaths + (iqr_diff_deaths * 1.5)
outlierupper_diff_deaths

lower_outliers_diff_deaths <- which(data$diff_deaths < outlierlower_diff_deaths)
lower_outliers_diff_deaths

upper_outliers_diff_deaths <- which(data$diff_deaths > outlierupper_diff_deaths)
print(lower_outliers_diff_deaths)
print(upper_outliers_diff_deaths)

# calculating proportional difference between cumulative number of infections of our 
# model and goverment data
png("cases_diff.png", width = 4500, height = 3000, units = "px", res = 400)
data$diff_cases <- abs(data$mod_inf - data$cumInfected)
data$diff_cases_prop <- data$diff_cases/data$cumInfected
ggplot(data, aes(Date, diff_cases_prop)) + 
  geom_point(aes(y=diff_cases_prop)) + 
  geom_smooth(aes(y=diff_cases_prop))+ 
  xlab("Time") + 
  ylab("Degree of error") +
  ylim(0,1) +
  ggtitle("Comparison of infected individuals between model and goverment data") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14)
        ,plot.title = element_text(face = "bold", 
                                   hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21))
dev.off()

#outliers of the proportional difference between cumulative number of infections of our 
#model and goverment data
iqr_diff_cases <- IQR(data$diff_cases)
lowerq_diff_cases = quantile(data$diff_cases)[2]
upperq_diff_cases = quantile(data$diff_cases)[4]
outlierlower_diff_cases = lowerq_diff_cases - (iqr_diff_cases * 1.5)
outlierupper_diff_cases = upperq_diff_cases + (iqr_diff_cases * 1.5)
lower_outliers_diff_cases <- which(data$diff_cases < outlierlower_diff_cases)
upper_outliers_diff_cases <- which(data$diff_cases > outlierupper_diff_cases)
print(lower_outliers_diff_cases)
print(upper_outliers_diff_cases)

# calculating proportional difference between cumulative number of vaccinations of our 
# model and goverment data
png("vaccines_diff.png", width = 4500, height = 3000, units = "px", res = 400)
data$diff_vacc <- abs(data$mod_vacc - data$cumPplVac)
data$diff_vacc_prop <- data$diff_vacc/data$cumPplVac
ggplot(data, aes(Date, diff_vacc_prop)) + 
  geom_point(aes(y=diff_vacc_prop)) + 
  geom_smooth(aes(y=diff_vacc_prop))+ 
  xlab("Time") + 
  ylab("Degree of error") +
  ggtitle("Comparison of administered vaccines between model and government data") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(size = 14)
        ,plot.title = element_text(face = "bold", 
                                   hjust = 0.5), axis.text.y = element_text(size = 14),
        axis.title.x = element_text(size = 14, face = "bold"), axis.title.y = element_text(size = 16, face = "bold"))+
  theme(plot.title = element_text(size = 21))
dev.off()
#outliers of the proportional difference between cumulative number of vaccinations of our 
#model and goverment data
iqr_diff_vacc <- IQR(data$diff_vacc)
lowerq_diff_vacc = quantile(data$diff_vacc)[2]
upperq_diff_vacc = quantile(data$diff_vacc)[4]
outlierlower_diff_vacc = lowerq_diff_vacc - (iqr_diff_vacc * 1.5)
outlierupper_diff_vacc = upperq_diff_vacc + (iqr_diff_vacc * 1.5)
lower_outliers_diff_vacc <- which(data$diff_vacc < outlierlower_diff_vacc)
upper_outliers_diff_vacc <- which(data$diff_vacc > outlierupper_diff_vacc)
print(lower_outliers_diff_vacc)
print(upper_outliers_diff_vacc)

