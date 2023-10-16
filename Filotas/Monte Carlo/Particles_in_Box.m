clearvars;
clc;
close all;

N_init=500;
par_in_box(N_init)

function par_in_box(N_init)

    max_time = 10 * N_init;
    N_left = N_init;
    time = zeros(1, max_time / 10);
    pososto = zeros(1, max_time / 10);

    for t = 1:max_time
        x = randi(N_init);
        if x < N_left
            N_left = N_left - 1;
        else
            N_left = N_left + 1;
        end
        
        if mod(t, 10) == 0
            index = t / 10;
            time(index) = t;
            pososto(index) = N_left / N_init;
        end
    end
    
    plot(time, pososto);
    xlabel('Time','Interpreter','latex','Fontsize',18);
    ylabel('Particles Ratio','Interpreter','latex','Fontsize',18);
    title('Particle Ratio in a Box Over Time','Interpreter','latex','Fontsize',18);
end
