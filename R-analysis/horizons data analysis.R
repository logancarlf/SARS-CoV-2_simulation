# load ggplot2 package from repository
library(ggplot2)

# loaded data file into global environment
data<- read.csv("first output data horizons.csv")

# plot of daily number of cases in the UK
ggplot(data, aes(Time, I)) + geom_line(aes(y=gov_cases_sorted))+ xlab("Time (days after 10/01/21)") + ylab("Number of cases") + 
          theme(plot.title = element_text(hjust = 0.5)) + ggtitle("Daily number of cases in UK") + ylim(0,50000)

# plot of cumulative value of daily number of cases in the UK
ggplot(data, aes(Time, I)) + geom_line(aes(y=gov_cases_cum))+ xlab("Time") + ylab("Number of cases") + 
  theme(plot.title = element_text(hjust = 0.5)) + ggtitle("Daily number of cases in UK")


# plot of daily number of deaths in the UK
ggplot(data, aes(Time, I)) + geom_line(aes(y=gov_deaths_sorted))+ xlab("Time (after 10/01/21)") + 
        ylab("Number of deaths") + ylim(0,1500) + 
        ggtitle("Daily number of deaths in UK")

# plot of daily number of first dose vaccine in UK
ggplot(data, aes(Time, I)) + geom_line(aes(y=gov_vac_sorted))+ xlab("Time (after 10/01/21)") + 
  ylab("Number of first doses given")  + 
  ggtitle("Daily number of first dose vaccinations in UK")

# boxplot of case cumulative deaths


