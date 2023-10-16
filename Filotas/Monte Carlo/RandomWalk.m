clear all;
close all;
clc;

% rng('shuffle'); % Initialization of random sequence
nstep = 15000; % Number of time steps
x =zeros(1,nstep); % Initial position
t=linspace(1,nstep,15000);

for i = 1:nstep-1 % Perform the time steps
    r = rand() - 0.5; % Random number in the range -0.5 to 0.5
    x(i+1) = x(i) + sign(r); % Move +1 or -1 according to the sign of r
    % Alternatively, for uniformly distributed steps in the range -1 to 1, use:
    % x = x + 2 * r;
   
end

figure(1)
plot(t,x)
xlabel('Time t','interpreter','latex')
ylabel('Distance x','interpreter','latex')