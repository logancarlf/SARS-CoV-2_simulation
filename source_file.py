from simulation import SIRVD_simulation
from differential_eqns import *
import matplotlib.pyplot as plt
import scipy.integrate as sp
from scipy import optimize
import pandas as pd
import numpy as np


def least_sq_func(x,params):
    f = lambda y,t: differentials(y,t,N,params)
    sol = sp.odeint(f,y0,x)
    return sol


def f_residue(p):
    residue = (data - least_sq_func(time, p)).ravel()
    return residue


def differentials(y, t, N, k):  # k = [beta, gamma, mu]
    S, I, R, V, D = y
    dS_dt = -k[0] * S * I / N - v(t)
    dI_dt = k[0] * S * I / N - k[1] * I - k[2] * I
    dR_dt = k[1] * I
    dV_dt = v(t)
    dD_dt = k[2] * I
    return dS_dt, dI_dt, dR_dt, dV_dt, dD_dt


# define population number
N = 67e6
# number of infected people
Inf = 20
# simulation runs in time interval dt
dt = 1
# number of time intervals the simulation runs
Period = 92
# rate of infection
Beta = 0.01
# rate of recovery
Gamma = 0.01
# rate of mortality
Mu = 0.01


data = pd.read_csv('10_dec_present_data.csv')
data.rename(columns={'Unnamed: 0':'Date'}, inplace=True)
data['SusPpl'] = 67.61e6 - data['cumDeaths'] - data['cumPplVac'] \
                - data['cumInfected'] - data['cumRecovered']
data = data.dropna(how='all', axis=1)
#data = data[:-1]
#data = data[1:]
data = data.drop('Date', 1)
cols = ['SusPpl', 'cumInfected', 'cumRecovered', 'cumPplVac', 'cumDeaths']
data = data[cols]
data = data.values.tolist()
data = np.array(data)

I = np.transpose(data)[1]
R = np.transpose(data)[2]
V = np.transpose(data)[3]
D = np.transpose(data)[4]
time = np.arange(0,len(data))

#%%

guess = [0.317, 0.23, 0.001]
y0 = data[0]
c = optimize.least_squares(f_residue, guess, bounds = ([0,0,0],[1,1,1]))
print("Fit Parameters", c.x)

#%%

c = [0.317, 0.23, 0.001]

test = SIRVD_simulation(N, I[0], R[0], V[0], D[0], *c)
test.run(Period, dt)
test.graph(Plot_Susceptible=False, Plot_Vaccinated=False)

susceptible_model = test.susceptible_model()
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



