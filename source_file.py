from differential_eqns import *
from simulation import *

# define population number
N = 1000000
# number of infected people
Inf = 20
# simulation runs in time interval dt
dt = 1
# number of time intervals the simulation runs
Period = 1000
# rate of infection
Beta = 0.9
# rate of recovery
Gamma = 0.3
# rate of mortality
Mu = 0.2
# rate of vaccination rollout
Alpha = 0.3


test = SIRVD_simulation(N, Inf, Alpha, Beta, Gamma, Mu)
test.run(100, 1)
test.graph()
