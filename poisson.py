import random 
import numpy as np
import matplotlib.pyplot as plt

A = 20
k = 1
T = 10000

N = A

def W_N(N):
    return k*(A+N)

def exp_dist(W , r):
    return -np.log(1-r)/W

m = 0
dt = 0
t = 0

p=np.zeros(50)

t_N = np.zeros(50)

sum_t = 0

while t < T:
    r1 = random.random()
    dt = exp_dist(W_N(N),r1)

    t = t + dt

    t_N[N] = t_N[N] + dt

    rho = random.random()
    ratio = A/(A+N)

    if rho > ratio:
        N = N - 1 
    else:
        N = N + 1 

    sum_t += t

    m += 1

p = t_N / t

plt.bar(range(0,50), p)
plt.show()

    
    # dt_vals[2*m+2] = exp_dist(a,r2)
    
    # sum_even += dt_vals[2*m+1]
    # sum_odd += dt_vals[2*m+2]

# mean = sum_odd /(sum_odd + sum_even)

# print (mean)