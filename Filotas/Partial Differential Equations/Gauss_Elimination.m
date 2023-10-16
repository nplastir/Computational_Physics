function x=Gauss_Elimination(a,b)
%solving ax=b , a in R^nxn , x & b in R^n

n=length(b);      % dimension of the problem
for i=1:n-1     
    [amax,imax]=max(abs(a(i:n,i)));
    if amax<eps                           % Σε περίπτωση που όλα τα στοιχεία της στήλης =0 ο πίνακας δεν διαγωνοποιείται και η λούπα σταματάει
        disp('Singular Matrix');
        break;
    end
    imax=imax+i-1;
    if imax~=i
        sa=a(imax,i:n); sb=b(imax);
        a(imax,i:n)=a(i,i:n); b(imax)=b(i);
        %Εναλλαγή γραμμών
        a(i,i:n)=sa; b(i)=sb;
    end
    
    b(i+1:n)=b(i+1:n)-b(i)*a(i+1:n,i)/a(i,i);
    a(i+1:n,i+1:n)=a(i+1:n,i+1:n)-a(i+1:n,i)*a(i,i+1:n)/a(i,i);
end             % Απαλοιφή j-οστής στήλης

if abs(a(n,n))<eps
    disp('Singular Matrix');
   
end
%Πίσω αντικατάσταση
x(n,1)=b(n)/a(n,n);
for i=n-1:-1:1
    x(i,1)=(b(i)-a(i,i+1:n)*x(i+1:n,1))/a(i,i);
end
     