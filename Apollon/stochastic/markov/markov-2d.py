import numpy as np


def progress_system(a, b, p, tolerance = 0.001):
    Q = np.array([
        [1 - a, b],
        [a, 1 - b]
    ])

    P = np.array([p, 1 - p])
    result = [P]

    while True:
        prev = P[0]
        P = Q @ P
        result.append(P)

        if abs(prev - P[0]) < tolerance:
            break
    
    return np.array(result), P

def get_inf_prob(a, b, p, tolerance = 0.001):
    Q = np.array([
        [1 - a, b],
        [a, 1 - b]
    ])

    P = np.array([p, 1 - p])

    for i in range(100):
        prev = P[0]
        P = Q @ P

        if abs(prev - P[0]) < tolerance:
            break
    
    return P

p = get_inf_prob(0.4, 0.32, 0.2)

step = 0.2


a_vals = np.arange(0, 1 + step, step)
b_vals = np.arange(0, 1 + step, step)

# print(np.meshgrid(a_vals, b_vals))

# p_vals_01 = np.vectorize(lambda a, b: get_inf_prob(a, b, 0.1))(a_vals, b_vals)

p_vals_01 = np.array(
    [[get_inf_prob(a, b, 0.1)[0] for b in b_vals] for a in a_vals]
)

print(p_vals_01)