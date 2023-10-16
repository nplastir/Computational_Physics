% Define the function to be expanded
p = @(x) sin(2 * pi * x) + 0.5 * sin(4 * pi * x);  % Example function

% Range [0, L]
L = 1;

% Number of terms in the expansion
N = 10;

% Calculate the Fourier sine series coefficients
A = zeros(N, 1);
x = linspace(0, L, 1000);  % Sample points for integration
for n = 1:N
    integrand = @(x) p(x) .* sin(n * pi * x / L);
    A(n) = (2 / L) * integral(integrand, 0, L);
end

% Reconstruct the function using the Fourier sine series
x_vals = linspace(0, L, 1000);  % Points for function evaluation
p_approx = A(1) / 2;  % DC component
for n = 1:N
    p_approx = p_approx + A(n) * sin(n * pi * x_vals / L);
end

% Plot the original function and the reconstructed approximation
plot(x_vals, p(x_vals), 'b-', 'LineWidth', 2);
hold on;
plot(x_vals, p_approx, 'r--', 'LineWidth', 1);
xlabel('x');
ylabel('p(x)');
legend('Original Function', 'Approximation');
title('Fourier Sine Series Expansion');
