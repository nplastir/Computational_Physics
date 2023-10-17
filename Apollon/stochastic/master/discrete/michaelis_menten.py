import numpy as np
import pandas as pd
import utils


def bool_swap(b):
    return 1 if b == 0 else 0

# number of A is constant
def run_sim_const_A(
    A = 20, N = 20, 
    a = 1, b = 1, k1 = 1, k2 = 1, 
    Tsim = 10000, bins = 50, s_0 = 1, 
    filename = '0'
):
    P = np.zeros(bins)

    s = s_0
    t = 0
    possible_results = np.array([
        [-1, 0],
        [0, -1 if s_0 == 1 else 1],
        [1, 0]
    ])
    while t < Tsim:
        dt, (dN, ds) = utils.pick_transition(
            possible_results,
            np.array([
                k2 * N,
                a if s == 0 else b,
                k1 * A * s # if s is 0 the probability is 0
            ])
        )
        t += dt; N += dN; s += ds
        possible_results[1][1] -= 2 * ds

        try: P[N] += dt
        except IndexError: pass

    P /= t

    df = pd.DataFrame({
        'N': np.arange(1,bins + 1),
        'P': P
    })

    df.to_csv(f'data/mm-{filename}.csv', index = False)


run_sim_const_A(a = 1.75, b = 0.25, filename = 'Ab-0')
run_sim_const_A(a = 0.25, b = 1.75, filename = 'aB-0')
run_sim_const_A(a = 1, b = 1, filename = 'ab-0')

run_sim_const_A(a = 50, b = 50, filename = 'AB-0')
