#There are still some gaps left and please help me to have a double check. Thank you! 
#By Mingjun Sun

#Analyse the results

datafr <- read.csv("OUTPUT.csv")

#the mean value of daily number of cases in the UK

meanfr_dailycases <- mean(datafr$cumInfected,na.rm=T)

#the mean value of daily number of cases from our simulation

meansm_dailycases <- mean(datafr$mod_inf,na.rm=T)

#the median value of daily number of cases in the uk

medianfr_dailycases <- median(datafr$cumInfected,na.rm=T)

#the median value of daily number of cases from our simulation

mediansm_dailycases <- median(datafr$mod_inf ,na.rm=T)

#the interquartile range of daily number of cases in the uk

IQRfr_dailycases <- IQR(datafr$cumInfected,na.rm=T)

#the interquartile range of daily number of cases

IQRsm_dailycases <- IQR(datafr$mod_inf ,na.rm=T)

#plot the differences of mean value, median value, and interquartile range between the data in reality and from our simulation

meandf_dailycases <- abs (meanfr_dailycases - meansm_dailycases)
mediandf_dailycases <- abs (medianfr_dailycases - mediansm_dailycases)
IQRdf_dailycases <- abs (IQRfr_dailycases - IQRsm_dailycases)
y_daily_cases <- c(meandf_dailycases, mediandf_dailycases, IQRdf_dailycases)
barplot(y_daily_cases, main="Differences of mean, median, and interquartile range for daily cases", horiz=TRUE, names.arg=c("mean", "median", "interqurtile range"))

#the mean value of daily number of deaths in the UK

meanfr_deathcases <- mean(datafr$cumDeaths,na.rm=T)

#the mean value of daily number of deaths from our simulation

meansm_deathcases <- mean(datafr$mod_death ,na.rm=T)

#the median value of daily number of deaths in the uk

medianfr_deathcases <- median(datafr$cumDeaths,na.rm=T)

#the median value of daily number of deaths from our simulation

mediansm_deathcases <- median(datafr$mod_death ,na.rm=T)

#the interquartile range of daily number of deaths in the uk

IQRfr_deathcases <- IQR(datafr$cumDeaths,na.rm=T)

#the interquartile range of daily number of deaths

IQRsm_deathcases <- IQR(datafr$mod_death ,na.rm=T)

#plot the differences of mean value, median value, and interquartile range between the data in reality and from our simulation

meandf_dailydeaths <- abs (meanfr_deathcases - meansm_deathcases)
mediandf_dailydeaths <- abs (medianfr_deathcases - mediansm_deathcases)
IQRdf_dailydeaths <- abs (IQRfr_deathcases - IQRsm_deathcases)
y_daily_deaths <- c(meandf_dailydeaths, mediandf_dailydeaths, IQRdf_dailydeaths)
barplot(y_daily_deaths, main="Differences of mean, median, and interquartile range for daily deaths", horiz=TRUE, names.arg=c("mean", "median", "interqurtile range"))

#the mean value of cumulative value of daily vaccinations in the UK

meanfr_cumdaily_vacc <- mean(datafr$cumPplVac,na.rm=T)

#the mean value of cumulative value of daily vaccinations simulation

meansm_cumdaily_vacc_m <- mean(datafr$mod_vacc ,na.rm=T)

#the median value cumulative value of daily vaccinations in the uk

medianfr_cumdaily_vacc <- median(datafr$cumPplVac,na.rm=T)

#the median value of cumulative value of daily number of cases from our simulation

mediansm_cumdaily_vacc_m <- median(datafr$mod_vacc ,na.rm=T)

#the interquartile range of cumulative value of daily number of cases in the uk

IQRfr_cumdaily_vacc <- IQR(datafr$cumPplVac,na.rm=T)

#the interquartile range of cumulative value of daily number of cases

IQRsm_cumdaily_vacc_m <- IQR(datafr$mod_vacc ,na.rm=T)

#plot the differences of mean value, median value, and interquartile range between the data in reality and from our simulation

meandf_cumdaily_vacc <- abs (meanfr_cumdaily_vacc - meansm_cumdaily_vacc_m)
mediandf_cumdaily_vacc <- abs (medianfr_cumdaily_vacc - mediansm_cumdaily_vacc_m)
IQRdf_cumdaily_vacc <- abs (IQRfr_cumdaily_vacc - IQRsm_cumdaily_vacc_m)
y_cum_daily_vacc <- c(meandf_cumdaily_vacc, mediandf_cumdaily_vacc, IQRdf_cumdaily_vacc)
barplot(y_cum_daily_vacc, main="Differences of mean, median, and interquartile range for cumulative daily vaccine", horiz=TRUE, names.arg=c("mean", "median", "interqurtile range"))
meandf_cumdaily_vacc
medianfr_cumdaily_vacc


