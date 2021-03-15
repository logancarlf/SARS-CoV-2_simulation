import numpy as np
import math


# define vaccination program function
def v(t):
    V = np.loadtxt('VaccinationProgram.csv', delimiter=',',
                   usecols=(0), skiprows=1)
    V = np.flip(V)
    return V[round(t)]


# differential equations to solve
def differentials(y, t, N, beta, gamma, mu):
    S, I, R, V, D = y
    dS_dt = -beta * S * I / N - v(t)
    dI_dt = beta * S * I / N - gamma * I - mu * I
    dR_dt = gamma * I
    dV_dt = v(t)
    dD_dt = mu * I
    return dS_dt, dI_dt, dR_dt, dV_dt, dD_dt
