from simulation import SIRVD_simulation
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

# define population number
N = 67e6
# number of infected people
Inf = 20
# simulation runs in time interval dt
dt = 1
# number of time intervals the simulation runs
Period = 59




# rate of infection
Beta = 0.0012
# rate of recovery
Gamma = 0.001
# rate of mortality
Mu = 0.0018


# import data from 10th Jan to 9th Mar
data = np.loadtxt('10_dec_present_data.csv', delimiter=',',
                  usecols=(1, 2, 3, 4), skiprows=1)

I = np.transpose(data)[0]
R = np.transpose(data)[1]
V = np.transpose(data)[2]
D = np.transpose(data)[3]

time_array = np.arange(0, 59, 1)

def parameter_fit(t,B,y,u):
    fit = SIRVD_simulation(N, I[0], R[0], V[0], D[0], B, y, u)
    fit.run(59, 1)
    return fit.recovered_model()

fit = curve_fit(parameter_fit, time_array, R)



test = SIRVD_simulation(N, I[0], R[0], V[0], D[0], Beta, Gamma, Mu)
test.run(Period, dt)
test.graph(Plot_Susceptible=False, Plot_Vaccinated=False)

infected_model = test.infected_model()
recovered_model = test.recovered_model()
vaccinated_model = test.vaccinated_model()
deceased_model = test.deceased_model()
time_model = test.time_model()


'''
Test for Vaccination Program
'''
plt.figure(figsize=(5, 3.5))
plt.scatter(time_model, vaccinated_model, color='red', 
            label='Model Predictions')
plt.scatter(time_model, V, color='black', label='Government Data')
plt.title('Model vs Data: Vaccinated')
plt.xlabel('Days since 10th January')
plt.ylabel('Number of Vaccinated People')
plt.legend()
plt.grid()
plt.show()

'''
Test for Infections
'''
plt.figure(figsize=(5, 3.5))
plt.scatter(time_model, infected_model, color='red', label='Model Predictions')
plt.scatter(time_model, I, color='black', label='Government Data')
plt.title('Model vs Data: Infecetd')
plt.xlabel('Days since 10th January')
plt.ylabel('Number of Infected People')
plt.legend()
plt.grid()
plt.show()

'''
Test for deceased
'''
plt.figure(figsize=(5, 3.5))
plt.scatter(time_model, deceased_model, color='red', label='Model Predictions')
plt.scatter(time_model, D, color='black', label='Government Data')
plt.title('Model vs Data: Deceaesd')
plt.xlabel('Days since 10th January')
plt.ylabel('Number of Deceased People')
plt.legend()
plt.grid()
plt.show()

'''
Test for Recovered
'''
plt.figure(figsize=(5, 3.5))
plt.scatter(time_model, recovered_model, color='red', label='Model Predictions')
plt.scatter(time_model, R, color='black', label='Government Data')
plt.title('Model vs Data: Recovered')
plt.xlabel('Days since 10th January')
plt.ylabel('Number of recovered People')
plt.legend()
plt.grid()
plt.show()