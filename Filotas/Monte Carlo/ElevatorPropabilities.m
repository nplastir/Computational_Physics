clearvars;
clc;

%Επιλογή παραμέτρων
Mfloor=2; 
Npeople=2;

elevator(Mfloor,Npeople);


function elevator(Mfloor, Npeople)
    rng(779977);  % Set the seed for reproducibility
    Ntoys = 10000;
    staseis = 0;
    
    for itoy = 1:Ntoys
        x = zeros(1, Mfloor);

        for i = 1:Npeople
            ifloor = randi(Mfloor);
            x(ifloor) = 1;
        end
        
        staseis = staseis + sum(x);
    end
    
    staseis = staseis / Ntoys;
    fprintf('Average number of floors occupied: %.4f\n', staseis);
end
