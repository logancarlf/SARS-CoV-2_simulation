# -*- coding: utf-8 -*-
"""
Created on Sun Mar 14 16:11:58 2021

@author: joshu
"""

import pandas as pd
import numpy as np
import scipy.integrate as sp
from scipy import optimize

data = pd.read_csv('parameter data.csv')
data.rename( columns={'Unnamed: 0':'Date'}, inplace=True)
data['SusPpl'] = 67.61e6 - data['cumDeaths'] - data['cumPplVac'] - data['cumInfected'] - data['cumRecovered']
data = data.dropna(how='all', axis=1)
data = data[:-1]
data = data[1:]
data = data.drop('Date', 1)
cols = ['SusPpl','cumInfected','cumRecovered','cumPplVac','cumDeaths']
data = data[cols]
data = data.values.tolist()
data = np.array(data)
time = np.arange(0,len(data))
N = 67.61e6
#%%
def v(t):
    V = np.loadtxt('VaccinationProgram.csv', delimiter=',',
                   usecols=(0), skiprows=1)
    V = np.flip(V)
    return V[round(t)]


# differential equations to solve
def differentials(y, t, N, k): #k = [beta, gamma, mu]
    S, I, R, V, D = y
    dS_dt = -k[0] * S * I / N - v(t)
    dI_dt = k[0] * S * I / N - k[1] * I - k[2] * I
    dR_dt = k[1] * I
    dV_dt = v(t)
    dD_dt = k[2] * I
    return dS_dt, dI_dt, dR_dt, dV_dt, dD_dt

def least_sq_func(x,params):
    f = lambda y,t: differentials(y,t,N,params)
    sol = sp.odeint(f,y0,x)
    return sol

def f_residue(p):
    residue = (data - least_sq_func(time, p)).ravel()
    return residue
guess = [0.01,0.01,0.01]
y0 = data[0]
c = optimize.least_squares(f_residue, guess, bounds = ([0,0,0],[1,1,1]))
print(c.x)
    

