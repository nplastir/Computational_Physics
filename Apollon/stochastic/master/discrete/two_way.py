import numpy as np
import pandas as pd
import utils

A = 20; N = 20
k1 = 1; k2 = 1

Tsim = 10000

# number of A is constant

t = 0
bins = 42
P = np.zeros(bins)

possible_transitions = np.array([1, -1])
transition_rates = np.array([k1 * A, k2 * N])
while t < Tsim:
    dt, dN = utils.pick_transition(
        possible_transitions,
        transition_rates
    )

    t += dt; N += dN
    transition_rates[1] += k2 * dN

    try: P[N] += dt
    except IndexError: pass

P /= t

df0 = pd.DataFrame({
    'N': np.arange(1, bins + 1),
    'P': P
})

df0.to_csv('data/twr-0.csv', index = False)



# total number is constant

t = 0
bins = 20
P = np.zeros(bins)

possible_transitions = np.array([1, -1])
transition_rates = np.array([k1 * (A - N), k2 * N])
while t < Tsim:
    dt, dN = utils.pick_transition(
        possible_transitions,
        transition_rates
    )

    t += dt; N += dN
    transition_rates[0] -= k1 * dN
    transition_rates[1] += k2 * dN

    try: P[N] += dt
    except IndexError: pass

P /= t

df1 = pd.DataFrame({
    'N': np.arange(1, bins + 1),
    'P': P
})

df1.to_csv('data/twr-1.csv', index = False)