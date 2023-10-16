clc;


N = 50;                  % Number of interior grid points

sourceTerm = @(i, j) 1;  % Example: constant source term

% Solve the Poisson equation using FFT
u = solvePoissonFFT(N, sourceTerm);

% Plot the solution
[X, Y] = meshgrid(linspace(0, 1, N+2));
surf(X, Y, u);
xlabel('x');
ylabel('y');
zlabel('u');
title('Solution of the Poisson equation using FFT');
