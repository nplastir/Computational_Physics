import numpy as np
import pandas as pd

bins = 200; P = np.zeros(bins)
tolerance = 0.5

V = 1; a = 100
Ns = int(np.floor(V * (a - 1)))

N = Ns; P[Ns] = 1

S2 = 0; S0 = 1; dS2 = 2 * tolerance

while dS2 > tolerance:
    N += 1
    P[N] = a * N / ((N + 1) * (1 + N / V)) * P[N - 1]

    dS2 = (N - Ns) ** 2 * P[N-1]
    S2 += dS2
    S0 += P[N-1]

    print(dS2)

dS2 = 2 * tolerance
N = Ns

while dS2 > tolerance and N > 1:
    N -= 1
    P[N] = (N + 1) * (1 + N / V) / (a * N) * P[N + 1]

    dS2 = (N - Ns) ** 2 * P[N]
    S2 += dS2
    S0 += P[N]


print(S2 / S0)

df = pd.DataFrame({
    'N': np.arange(1,bins + 1),
    'P': P
})

df.to_csv(f'data/sc-3.csv', index = False)