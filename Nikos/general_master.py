import random 
import numpy as np
import matplotlib.pyplot as plt

def exp_dist(denom , r):
    return -np.log(1-r)/denom

a = 1 
b = 1

W = np.zeros(N)

N = 10000
m = 0

dt_vals = np.zeros(N)

sum_odd = 0 ; sum_even = 0

for m in range(N//2 - 1):
    r1 = random.random()
    r2 = random.random()


    dt_vals[2*m+1] = exp_dist(b,r1)
    dt_vals[2*m+2] = exp_dist(a,r2)
    
    sum_even += dt_vals[2*m+1]
    sum_odd += dt_vals[2*m+2]

mean = sum_odd /(sum_odd + sum_even)

print (mean)