import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# Define the model parameters

r1 = 0.5  # intrinsic growth rate of species 1
r2 = 0.3  # intrinsic growth rate of species 2
K1 = 1000  # carrying capacity of the environment for species 1
K2 = 1000 # carrying capacity of the environment for species 2
alpha12 = 0.5  # competition coefficient for species 1 from species 2
alpha21 = 0.5  # competition coefficient for species 2 from species 1

# Define the differential equations

def lotka_volterra(t, X):
    N1, N2 = X
    dN1dt = r1 * N1 * (K1 - N1 - alpha12 * N2) / K1
    dN2dt = r2 * N2 * (K2 - N2 - alpha21 * N1) / K2
    return [dN1dt, dN2dt]

# Define the initial conditions

N1_0 = 10  # initial population of species 1
N2_0 = 10  # initial population of species 2
X0 = [N1_0, N2_0]

# Solve the differential equations

sol = solve_ivp(lotka_volterra, [0, 100], X0, t_eval=np.linspace(0, 100, 1000))

# Plot the results

plt.plot(sol.t, sol.y[0], label='Species 1')
plt.plot(sol.t, sol.y[1], label='Species 2')
plt.legend()
plt.xlabel('Time')
plt.ylabel('Population size')
plt.show()
