import numpy as np
import pandas as pd
import utils

A = 20; N = 20
k1 = 1; k2 = 1
V = 1

Tsim = 10000

t = 0
bins = 50
P = np.zeros(bins)

N_shifts = np.array([1, -1])

while t < Tsim:
    dt, dN = utils.pick_transition(
        N_shifts,
        np.array([
            k1 * A * N / V, 
            k2 * N * (N - 1) / V
        ])
    )

    t += dt; N += dN

    try: P[N] += dt
    except IndexError: pass

P /= t

df0 = pd.DataFrame({
    'N': np.arange(1, bins + 1),
    'P': P
})

df0.to_csv('data/pc-0.csv', index = False)