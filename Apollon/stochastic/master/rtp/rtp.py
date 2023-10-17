import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
matplotlib.use('TkAgg')

# plt.rcParams['backend'] = 'TkAgg'

a = 1
b = 1

N = 1_000_000; N2 = N // 2

def get_dt1(transition_rate, N): # get transition durations
    r1 = np.random.rand(N)
    return -np.log(r1) / transition_rate

dt1_1to0 = get_dt1(b, N2)
dt1_0to1 = get_dt1(a, N2)

sum_1to0 = sum(dt1_1to0)
sum_0to1 = sum(dt1_0to1)

n_mean = sum_1to0 / (sum_1to0 + sum_0to1)

print(n_mean)

cum_dt1_1to0 = dt1_1to0.cumsum()
cum_dt1_0to1 = dt1_0to1.cumsum()

t1_0to1 = cum_dt1_1to0 + cum_dt1_0to1
t1_1to0 = t1_0to1 - dt1_0to1

n_0_intervals = np.array([t1_1to0, t1_0to1]).transpose()

n_1_intervals = np.array([
    np.concatenate((np.array([0]), t1_0to1[:-1])),
    t1_1to0
]).transpose()

# print(n_1_intervals)
# print(n_1_intervals)

def step(x):
    return x if x > 0 else 0


def get_overlapping_area(intervals_0, intervals_1):
    intervals_1_slice = intervals_1
    result = 0
    for start_0, end_0 in intervals_0:
        for j, (start_1, end_1) in enumerate(intervals_1_slice):
            if start_1 >= end_0:
                intervals_1_slice = intervals_1_slice[j-1:]
                break
            
            if start_0 >= end_1: 
                continue
            
            result += (
                end_0 - start_1 - step(end_0 - end_1) - step(start_0 - start_1))
    
    return result

a0 = np.array([[1,2],[3,4]])
a1 = np.array([[1.5,2.5],[3.5,3.75],[3.8,5]])

print(get_overlapping_area(a0, a1)) 

print(get_overlapping_area(a1, a0)) 

print(get_overlapping_area(a0, a0)) 



def get_k(tau, n_1_intervals, n_mean):
    t_max = n_1_intervals[-1,1] # last entry

    n_1_offset = n_1_intervals - tau
    n_1_offset = n_1_offset[n_1_offset[:,1] > 0]
    n_1_offset[0,0] = max(n_1_offset[0,0], 0)

    n_1_truncated = n_1_intervals[n_1_intervals[:,0] < t_max - tau]
    n_1_truncated[-1,1] = min(n_1_truncated[-1,1], t_max - tau)

    overlapping_area = get_overlapping_area(
        n_1_offset, n_1_truncated
    )
    print(overlapping_area, t_max - tau)

    return overlapping_area / (t_max - tau) - n_mean ** 2

get_k_vec = np.vectorize(
    lambda tau: get_k(tau, n_1_intervals, n_mean)
)

print(sum_1to0)

tau_values = np.linspace(0, 10, 40)

k_values = get_k_vec(tau_values)

kdf = pd.DataFrame({
    'tau': tau_values,
    'kappa': k_values
})

kdf.to_csv('data/k-short-1M.csv', index = False)

# plt.figure(figsize = (7,5))
# plt.grid(alpha = 0.25)

# plt.xlabel('τ [sec]')
# plt.ylabel('κ(τ)')

# plt.plot(tau_values, k_values, color = 'red')

# plt.subplots_adjust(
#     left = 0.11,
#     right = 0.95,
#     bottom = 0.10,
#     top = 0.95
# )
# plt.savefig('img/k-high-4.png')
# plt.show()

