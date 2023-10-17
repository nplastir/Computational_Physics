# helper functions for the rest of the scripts
import random
import numpy as np

def pick_transition(
    possible_results: np.array, transition_rates: np.array
):
    transition_intervals = transition_rates.cumsum()
    rate_sum = transition_intervals[-1] # last entry

    R = random.random() * rate_sum
    result_idx = (transition_intervals > R).nonzero()[0][0]

    dt = -np.log(random.random()) / rate_sum

    return (dt, possible_results[result_idx])

