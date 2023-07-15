import random 
import numpy as np
import matplotlib.pyplot as plt

A = 20
k = 1
T = 10000

s = 1
b = 1.75
a = 0.25

N = A 

# def W_N(N):
#     return b + k*(A+N)
W_N = b + k*(A+N)

def exp_dist(W , r):
    return -np.log(1-r)/W

dt = 0
t = 0

p=np.zeros(50)

t_N = np.zeros(50)

while t < T:
    r1 = random.random()
    dt = exp_dist(W_N,r1)

    t = t + dt

    t_N[N] = t_N[N] + dt

    rho = random.random()

    if rho > A/(A+N):
        N = N - 1 
        W_N = W_N - k
        print("first")
    elif s == 0:
        s = 1
        W_N =W_N + k*A + b -a
        print("second")
    else:
        if rho < A/(A+N):
            N = N + 1
            W_N = W_N + k
            print("third")
        else:
            s=0
            W_N = W_N - k*A + a - b
            print("fourth")
    print(W_N)
    print(t)


p = t_N / t

plt.bar(range(0,50), p)
plt.show()

    
    # dt_vals[2*m+2] = exp_dist(a,r2)
    
    # sum_even += dt_vals[2*m+1]
    # sum_odd += dt_vals[2*m+2]

# mean = sum_odd /(sum_odd + sum_even)

# print (mean)