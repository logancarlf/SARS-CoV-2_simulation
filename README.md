# SARS-CoV-2 Simulation code
This is code runs a simulation of an epidemic. The simulation uses an SIRVD model that models 5 categories of people in an epidemic:
- Susceptible People: Number of people who are not but can be infected with the virus 
- Infected: Number of people who are infected with the virus
- Recovered: Number of people who have have been infected and survived
- Deceased: Number of People have died due to the disease
- Vaccinated: Number of people who have been vaccinated against the disease
## Parameters
The simulations runs based on initial conditions. These include:
- A single parameter for the number of people in the simulated population
- Parameters based on the number of people in each  category at t=0.
- Time parameters that define how long the simulation runs and at what time intervals data needs to be collected
- Parameters that define how the data categories change in time. Specifically:
	- Rate of infection
	- Rate of recovery
	- Rate of mortality
	- Rate of vaccination
## Differential Equations
The model works by solving a set of coupled, ordinary differential equations. Each equation is needed to define the number of people in each respective category of which there are 5. Hence, there are 5 differentials that are solved:

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?%5Cdpi%7B300%7D%20%5Cfrac%7BdS%7D%7Bdt%7D%3D-%5Cfrac%7B%5Cbeta%20S%20I%7D%7BN%7D)

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?%5Cdpi%7B300%7D%20%5Cfrac%7BdI%7D%7Bdt%7D%3D%5Cfrac%7B%5Cbeta%20S%20I%7D%7BN%7D%20-%20%5Cgamma%20I%20-%20%5Cmu%20I)

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?%5Cdpi%7B300%7D%20%5Cfrac%7BdR%7D%7Bdt%7D%3D%5Cgamma%20I)

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}](https://latex.codecogs.com/svg.latex?%5Cdpi%7B300%7D%20%5Cfrac%7BdD%7D%7Bdt%7D%3D%5Cmu%20I)

