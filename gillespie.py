import numpy as np

def gillespie_algorithm(initial_state, reactions, time_limit):
    """
    Simulate a system of chemical reactions using the Gillespie algorithm.

    Args:
        initial_state (numpy array): An array of initial populations for each species.
        reactions (list of tuples): A list of tuples, where each tuple represents a reaction
            and contains two elements: a numpy array of the stoichiometry of the reactants and
            a float representing the reaction rate.
        time_limit (float): The maximum simulation time.

    Returns:
        (numpy array, numpy array): A tuple containing two arrays:
            1. An array of the times at which the state of the system changes.
            2. An array of the states of the system at each time point.
    """
    time = 0.0
    state = initial_state
    times = [time]
    states = [state]

    while time < time_limit:
        # Calculate the reaction rates for the current state
        rates = np.zeros(len(reactions))
        for i, (stoichiometry, rate) in enumerate(reactions):
            reactants_present = np.all(state >= stoichiometry, axis=1)
            rates[i] = rate * np.sum(np.prod(state[reactants_present] - stoichiometry[reactants_present], axis=1))

        # Determine the time of the next reaction
        total_rate = np.sum(rates)
        if total_rate == 0.0:
            break
        delta_time = np.random.exponential(scale=1/total_rate)
        time += delta_time

        # Determine which reaction occurs next
        probabilities = rates / total_rate
        reaction_index = np.random.choice(len(reactions), p=probabilities)

        # Update the state of the system
        state += reactions[reaction_index][0]
        times.append(time)
        states.append(state)

    return np.array(times), np.array(states)
