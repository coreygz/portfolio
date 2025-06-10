import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# Define the model parameters

alpha12 = 0.4  # nondimensionalized competition coefficient for species 1 from species 2
alpha21 = 0.5  # nondimensionalized competition coefficient for species 2 from species 1

# Define the differential equations

def lotka_volterra(t, X):
    N1, N2 = X
    dN1dt = N1 * (1 - N1 - alpha12 * N2)
    dN2dt = N2 * (1 - N2 - alpha21 * N1)
    return [dN1dt, dN2dt]

# Define the initial conditions

N1_0 = 0.5  # initial population of species 1
N2_0 = 0.5  # initial population of species 2
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