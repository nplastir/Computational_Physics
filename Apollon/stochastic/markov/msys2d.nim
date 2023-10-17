type
    vector2d = array[2, float]
    matrix2d = array[2, array[2, float]]


proc applyMatrix2d(M: matrix2d, v: vector2d): vector2d =
    var res: vector2d
    res[0] = M[0][0] * v[0] + M[0][1] * v[1]
    res[1] = M[1][0] * v[0] + M[1][1] * v[1]

    return res


proc applyMatrixRepeatedly(
    M: matrix2d, initial_vector: vector2d, 
    tolerance: float = 0.001, max_iter: int = 100
): vector2d =
    var 
        prev_v0: float
        v: vector2d = initial_vector

    for i in 0..max_iter:
        prev_v0 = v[0]
        v = applyMatrix2d(M, v)

        if abs(prev_v0 - v[0]) < tolerance:
            return v
    
    echo "warning: max iterations reached!"
    return v

proc makeQ(a, b: float): matrix2d = 
    var res: matrix2d
    res[0][0] = 1 - a
    res[0][1] = b
    res[1][0] = a
    res[1][1] = 1 - b

    return res

proc makeP(p: float): vector2d = 
    var res: vector2d
    res[0] = p
    res[1] = 1 - p

    return res

var
    a = 0.4
    b = 0.32
    p = 0.2
    Q = makeQ(a, b)
    P = makeP(p)

echo applyMatrixRepeatedly(Q, P)

