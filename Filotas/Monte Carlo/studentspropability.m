function pro=studentspropability(Nstudent)

Ndays = 365;
Ntoys = 100;
rng(12345); % Set the random seed for reproducibility
totalsuccess = 0;

for itoy = 1:Ntoys
    success = 0;
    for i = 1:Nstudent
        Ib = randi(Ndays); % Generate a random integer between 1 and Ndays
        for j=i+1:Nstudent
            Jb=randi(Ndays);
            if Ib == Jb
                success =1;
                break
            end
        end
    end
    if success > 0
        totalsuccess = totalsuccess + 1;
    end
end

pro = totalsuccess / Ntoys;


end 