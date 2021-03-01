from simulation import SIRVD_simulation

# define population number
N = 1000000
# number of infected people
Inf = 20
# simulation runs in time interval dt
dt = 1
# number of time intervals the simulation runs
Period = 200
# rate of infection
Beta = 0.2
# rate of recovery
Gamma = 0.05
# rate of mortality
Mu = 0.01
# rate of vaccination rollout
Alpha = 0.3


test = SIRVD_simulation(N, Inf, Alpha, Beta, Gamma, Mu)
test.run(Period, dt)
test.graph()
