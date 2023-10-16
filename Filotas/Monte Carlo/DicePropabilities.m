clear all;
clc;

Ntoys = 10000;
Nriksies = 50;
Nzari = 6;
% ran = rng(39875);
total_success = zeros(1, 6);  % One for each case: Neksares = 0, 1, 2, 3, 4, >=5

for Itoy = 1:Ntoys
    Neksares = 0;
    for i = 1:Nriksies
        Z1 = randi(Nzari);
        Z2 = randi(Nzari);
        if Z1 == 6 && Z2 == 6
            Neksares = Neksares + 1;
        end
    end
    
    % Αποθήκευση του αποτελέσματος 6αρες=1,2,3,4,5,... - Η αρίθμηση του
    % διανύσματος γίνεται με βάση το Neskares
    
    if Neksares<5
    total_success(Neksares+1) = total_success(Neksares+1) + 1;
    else 
      total_success(6)=total_success(6)+1; %Τα αποτελέσματα 5 και πάνω καταχωρίζονται στην ίδια θέση
    end 
end

% Calculate and print the success rate for each case
for i = 1:5
    success_rate = total_success(i) / Ntoys;
    fprintf('Success rate for Neksares = %d: %.4f\n', i-1 , success_rate);
end
   
   fprintf('Success rate for Neksares >=5: %.4f \n',total_success(6)/Ntoys);

   
   
   %% Θεωρητική πιθανότητα για εμφάνιση ενός (6.6) στις 50 ρίψεις των ζαριών

n = 50;  % Total number of trials
k = 1;   % Number of successful trials (getting (6,6) exactly once)
p_success = 1/36;  % Probability of success in a single trial

% Calculate the binomial probability
binomial_probability = nchoosek(n, k) * (p_success^k) * ((1 - p_success)^(n - k));

fprintf('Probability of getting (6,6) exactly once in 50 trials: %.4f\n', binomial_probability);
