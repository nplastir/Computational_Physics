A = 20;
k = 1;
T = 10000;

s = 1;
b = 1;
a = 1;

N = A;

W_N = b + k * (A + N);

dt = 0;
t = 0;

p = zeros(1, 50);

t_N = zeros(1, 50);

while t < T;
    r1 = rand();
    dt = -log(1 - r1) / W_N;

    t = t + dt;

    t_N(N+1) = t_N(N+1) + dt;

    rho = rand();

    if rho * W_N - k * N < 0
        N = N - 1;
        W_N = W_N - k;
        % disp('first');
    end

    if s == 0
        s = 1;
        W_N = W_N + k * A + b - a;
        % disp('second');
    else
        if rho * W_N - k * A < 0
            N = N + 1;
            W_N = W_N + k;
            % disp('third');
        else
            s = 0;
            W_N = W_N - k * A + a - b;
            % disp('fourth');
        end
    end
    disp(W_N);
    disp(t);
end

p = t_N / t;

bar(0:49, p);
