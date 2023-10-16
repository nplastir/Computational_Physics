function u = solvePoissonFFT(N, sourceTerm)
% N: number of interior grid points in each dimension
% sourceTerm: function handle representing the source term

% Grid spacing
h = 1 / (N + 1);

% Define the wavenumbers
k = (2 * pi / (N + 1)) * (-N/2:N/2-1);
[kx, ky] = meshgrid(k);

% Compute the source term in the Fourier domain
f = zeros(N+2, N+2);
for i = 1:N+2
    for j = 1:N+2
        f(i, j) = h^2 * sourceTerm(i, j);
    end
end

% Compute the Fourier coefficients of the source term
fHat = fft2(f);

% Solve the Poisson equation in the Fourier domain
denom = 4 - 2*cos(kx*h) - 2*cos(ky*h);
uHat = -fHat ./ denom;

% Transform back to the spatial domain
u = real(ifft2(uHat));

% Apply the homogeneous Dirichlet boundary conditions
u(:, 1) = 0;         % Left boundary
u(:, N+2) = 0;      % Right boundary
u(1, :) = 0;         % Top boundary
u(N+2, :) = 0;      % Bottom boundary

end
