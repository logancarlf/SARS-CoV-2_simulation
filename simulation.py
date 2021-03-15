import numpy as np
import matplotlib.pyplot as plt
import scipy.integrate as sp
from differential_eqns import differentials


class SIRVD_simulation:
    def __init__(self, population_size, infected, recovered, vaccinated,
                 deceased, infection_rate, recovery_rate,
                 mortality_rate):
        '''
        The simulation models 5 categories of people in an epidemic based on 4
        initial parameters of the disease:
            - Number of Infected People
            - Population
            - Rate of Vaccination
            - Rate of Infection
            - Rate of Recovery
            - Rate of Mortality

        This will determine, through time, the number of people that are:
            - Susceptible to the disease
            - Infected with the diseaese
            - Vaccinated from the disease
            - Recovered from the disease
            - Deceased due to the disease
        '''

        self._beta = infection_rate
        self._gamma = recovery_rate
        self._mu = mortality_rate
        self._N = population_size

        self._S = population_size - infected - recovered - vaccinated \
            - deceased
        self._I = infected
        self._R = recovered
        self._V = vaccinated
        self._D = deceased
        self._t = 0

    def run(self, period, dt):
        '''
        For a given duration (period) and a given time interval (dt), the
        simulation will run by solving the differential equations for the
        parameters of the simulation
        '''

        # define boundary conditions
        y0 = self._S, self._I, self._R, self._V, self._D
        # define functional parameters
        func_args = self._N, self._beta, self._gamma, self._mu
        # create array for time points of the simulation
        self._time = np.arange(0, period, dt)
        # solve the differential equations
        solution = sp.odeint(differentials, y0, self._time, args=func_args)
        # store solutions in data attributes
        self._S, self._I, self._R, self._V, self._D = solution.T
        

    def graph(self, Plot_Susceptible=True, Plot_Infected=True,
              Plot_Recovered=True, Plot_Deceased=True, Plot_Vaccinated=True):
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
        if Plot_Vaccinated:
            plt.scatter(self._time, self._V, label='Vaccinated')
        if Plot_Deceased:
            plt.scatter(self._time, self._D, label='Deceased')


        plt.title("Epidemiolgical SIRVD Simulation")
        plt.xlabel("Time $t$ / $days$")
        plt.ylabel("Number of People $N$")
        plt.legend(loc='center right')
        plt.grid()
        plt.show()

    def infected_model(self):
        return self._I

    def recovered_model(self):
        return self._R

    def vaccinated_model(self):
        return self._V

    def deceased_model(self):
        return self._D
    
    def time_model(self):
        return self._time
