import numpy as np

def get_next_p(a, b, p):
    return (1 - a - b) * p + b

def get_some_ps(a, b, p0, num):
    p = p0
    return [p0] + [
        p := (1 - a - b) * p + b
        for i in range(num)
    ]

a = 0.9
b = 0.9

print(b / (a + b))

print(get_some_ps(a, b, 0.1, 10))
print(get_some_ps(a, b, 0.9, 10))