import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as sp
from differential_eqns import *

class SIRVD_simulation:
    def __init__(self, population_size, infected, vaccination_rate,
                 infection_rate, recovery_rate, mortality_rate):
        '''
        The simulation models 5 categories of people in an epidemic based on 4
        initial parameters of the disease:
            - Rate of Vaccination
            - Rate of Infection
            - Rate of Recovery
            - Rate of Mortality
            - Population
            - Number of Infected People

        This will determine through time the number of people that are:
            - Susceptible to the disease
            - Infected with the diseaes
            - Vaccinated from the disease
            - Recovered from the disease
            - Deceased due to the disease
        '''

        self._alpha = vaccination_rate
        self._beta = infection_rate
        self._gamma = recovery_rate
        self._mu = mortality_rate
        self._N = population_size

        self._S = population_size - infected
        self._I = infected
        self._R = 0
        self._V = 0
        self._D = 0
        self._t = 0

    def run(self, period, dt):
        '''
        For a given duration (period) and a given time interval (dt), the
        simulation will run by solving the differential equations for the
        parameters of the simulation
        '''

        # define boundary conditions
        y0 = self._S, self._I, self._R, self._D
        # define functional parameters
        func_args = self._N, self._beta, self._gamma, self._mu
        # create array for time points of the simulation
        self._time = np.arange(0, period, dt)
        # solve the differential equations
        solution = sp.odeint(differentials, y0, self._time, args=func_args)
        # store solutions in data attributes
        self._S, self._I, self._R, self._D = solution.T

    def graph(self, Plot_Susceptible=True, Plot_Infected=True,
              Plot_Recovered=True, Plot_Deceased=True):
        '''
        A basic visualisation of the data by plotting the four data categories:
        Susceptible, Infected, Recovered and Deceased.

        Each respective category can be excluded from the graph by setting the
        argument Plot_[category_name]=False in the run function.
        '''
        if Plot_Susceptible:
            plt.scatter(self._time, self._S, label='Susceptible')
        if Plot_Infected:
            plt.scatter(self._time, self._I, label='Infected')
        if Plot_Recovered:
            plt.scatter(self._time, self._R, label='Recovered')
        if Plot_Deceased:
            plt.scatter(self._time, self._D, label='Deceased')

        plt.title("Epidemiolgical SIRD Simulation")
        plt.xlabel("Time $t$ / $days$")
        plt.ylabel("Number of People $N$")
        plt.legend(loc='center right')
        plt.grid()
        plt.show()

