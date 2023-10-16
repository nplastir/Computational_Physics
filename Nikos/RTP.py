import numpy as np
import matplotlib.pyplot as plt

def random_telegraph_process(num_samples, tau_on, tau_off, p_on):
    """
    Generates a random telegraph process with the given parameters.

    Parameters:
    num_samples (int): The number of samples to generate.
    tau_on (float): The duration of the on state.
    tau_off (float): The duration of the off state.
    p_on (float): The probability of being in the on state.

    Returns:
    np.array: A 1D numpy array containing the generated random telegraph process.
    """
    # Generate the on and off periods
    on_period = np.random.exponential(scale=tau_on, size=num_samples)
    off_period = np.random.exponential(scale=tau_off, size=num_samples)

    # Initialize the state and output arrays
    state = np.zeros(num_samples, dtype=np.int8)
    output = np.zeros(num_samples)

    # Set the initial state
    state[0] = np.random.choice([0, 1], p=[1-p_on, p_on])
    output[0] = state[0]

    # Generate the rest of the states and outputs
    for i in range(1, num_samples):
        if state[i-1] == 0:
            if off_period[i-1] <= 1:
                state[i] = 1
            else:
                state[i] = 0
        else:
            if on_period[i-1] <= 1:
                state[i] = 0
            else:
                state[i] = 1
        output[i] = state[i]

    return output

# Example usage
num_samples = 1000
tau_on = 2
tau_off = 5
p_on = 0.3
rtp = random_telegraph_process(num_samples, tau_on, tau_off, p_on)

# Plot the random telegraph process
plt.plot(rtp)
plt.xlabel('Time')
plt.ylabel('State')
plt.title('Random Telegraph Process')
plt.show()

