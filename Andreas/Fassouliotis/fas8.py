#hlek
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

nx = 10
ny = 10
maxstep = 100


dx = 0.1
dy = 0.1

x = np.zeros(nx+1)
y = np.zeros(ny+1)

C = np.zeros((nx+1, ny+1))

F = np.zeros((nx+1, ny+1))


for i in range(nx+1):
    x[i] = i * dx

    for j in range(ny+1):
        y[j] = j * dy
        
        charge = 10
        C[i][j] = charge
            
        if i == 0 or i == nx or j == 0 or j == ny:
            F[i][j] = 0.0
        

for it in range(maxstep):
    for i in range(1, nx):
        for j in range(1, ny):
            F[i][j] = 0.25 * (F[i+1][j] + F[i-1][j] + F[i][j+1] + F[i][j-1]) + dx * dy * C[i][j]

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
X, Y = np.meshgrid(x, y)
ax.plot_surface(X, Y, F.T, cmap='viridis')
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Potential')
ax.set_title('Poisson Equation Solution')
plt.show()