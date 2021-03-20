# load ggplot2 package from repository
library(ggplot2)


# loaded data file into global environment
data<- read.csv("OUTPUT.csv", fileEncoding="UTF-8-BOM")
class(data$Date)
data$Date = as.Date(data$Date, format='%d-%m-%Y')
class(data$Date)

# plot of infected individuals in the UK
ggplot(data, aes(Date, cumInfected)) + 
  geom_point(aes(y=cumInfected, color = "steelblue")) +
  geom_smooth(aes(y=cumInfected, color = "steelblue")) +
  geom_point(aes(y = mod_inf, color = "darkred")) +
  geom_smooth(aes(y = mod_inf, color = "darkred")) +
  xlab("Time") + 
  ylab("Daily number of infected individuals") + 
  scale_color_discrete(name = "Key", labels= c("Model", "Government data")) +
  theme(plot.title = element_text(hjust = 0.5)) +  
  theme(axis.text.x = element_text(angle = 90,hjust = 1, vjust = 0.5)) + 
  ggtitle("Daily number of infected individuals in UK") 

# plot of cumulative number of deaths in the UK
ggplot(data, aes(Date, cumDeaths)) + 
  geom_point(aes(y=cumDeaths, color = "steelblue")) + 
  geom_smooth(aes(y = cumDeaths, color = "steelblue")) + 
  geom_point(aes(y = mod_death, color = "darkred")) +
  geom_smooth(aes(y = mod_death, color = "darkred")) +
  scale_color_discrete(name = "Key", labels= c("Model", "Government data")) +
  xlab("Time") + 
  ylab("Cumulative number of deaths") + 
  ylim(60000, 140000) +
  theme(axis.text.x = element_text(angle = 90,hjust = 1, vjust = 0.5)) + 
  ggtitle("Cumulative number of deaths in UK") +
  theme(plot.title = element_text(hjust = 0.5)) 

# plot of cumulative number of first dose vaccine in UK
ggplot(data, aes(Date, cumPplVac)) + 
  geom_point(aes(y=cumPplVac, color = "steelblue")) + 
  geom_smooth(aes(y=cumPplVac, color = "steelblue"))+ 
  xlab("Time") + 
  ylab("Number of first doses given") + 
  geom_point(aes(y= mod_vacc, color = "darkred")) + 
  geom_smooth(aes(y=mod_vacc, color = "darkred")) + 
  scale_color_discrete(name = "Key", labels= c("Model", "Government data")) + 
  ggtitle("Cumulative number of vaccinations administered in UK") + 
  theme(plot.title = element_text(hjust = 0.5)) 

# calculating proportional difference between cumulative number of deaths of our 
# model and goverment data
data$diff_deaths <- abs(data$mod_death - data$cumDeaths)
data$diff_deaths_prop <- data$diff_deaths / data$cumDeaths
ggplot(data, aes(Date, diff_deaths_prop)) + 
  geom_point(aes(y=diff_deaths_prop)) + 
  geom_smooth(aes(y=diff_deaths_prop))+ 
  xlab("Time") + 
  ylab("Degree of error") +
  ylim (0, 0.08) +
  ggtitle("Difference between cumulative deaths of our model against goverment data") + 
  theme(plot.title = element_text(hjust = 0.5)) 

# calculating proportional difference between cumulative number of infections of our 
# model and goverment data
data$diff_cases <- abs(data$mod_inf - data$cumInfected)
data$diff_cases_prop <- data$diff_cases/data$cumInfected
ggplot(data, aes(Date, diff_cases_prop)) + 
  geom_point(aes(y=diff_cases_prop)) + 
  geom_smooth(aes(y=diff_cases_prop))+ 
  xlab("Time") + 
  ylab("Degree of error") +
  ylim(0,1) +
  ggtitle("Difference between cumulative infected individuals of our model against goverment data") + 
  theme(plot.title = element_text(hjust = 0.5)) 

data$diff_vacc <- abs(data$mod_vacc - data$cumPplVac)
data$diff_vacc_prop <- data$diff_vacc/data$cumPplVac
ggplot(data, aes(Date, diff_vacc_prop)) + 
  geom_point(aes(y=diff_vacc_prop)) + 
  geom_smooth(aes(y=diff_vacc_prop))+ 
  xlab("Time") + 
  ylab("Degree of error") +
  ggtitle("Difference between cumulative number of vaccinations of our model against goverment data") + 
  theme(plot.title = element_text(hjust = 0.5)) 

