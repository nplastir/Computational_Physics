import numpy as np
import matplotlib.pyplot as plt

a = 100
V = 1


Ns = V*(a-1)
S2 = 0 
S0 = 1

p = np.zeros(1000)


N = Ns
p[N] = 1

diff = 1


while diff > 0.5:
    
    p[N+1] = (a*N * p[N])/((N+1)*(1+N/V))
    N += 1

    temp = S2

    S2 += (N - Ns)**2 * p[N]
    S0 += p[N]

    diff = S2 - temp
    print(diff)

p = np.zeros(1000)
diff = 1
N = Ns
p[N] = 1

while diff > 0.5 and N != 1:
    
    #p[N+1] = (a*N * p[N])/((N+1)*(1+N/V))
    p[N-1] = (p[N]* N * (1+ (N-1)/V))/(a*(N-1))
    N -= 1

    temp = S2

    S2 += (N - Ns)**2 * p[N]
    S0 += p[N]

    diff = S2 - temp

Var = S2 / S0
    
print("The Variance is equal to " + str(Var))