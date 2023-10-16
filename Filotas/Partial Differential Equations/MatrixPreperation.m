function A=MatrixPreperation(l,Nx)

A=zeros(Nx-2,Nx-2); 
A(1,1)=-0.5*l; A(1,2)=-0.5*l; A(Nx-2,Nx-3)=-0.5*l; A(Nx-2,Nx-2)=-0.5*l; %Diagonal elements are going to be fixed later in the code

for i=2:Nx-3
    for j=i-1:i+1
        
        A(i,j)=-0.5*l; 
        
    end 
end 

A=A+(0.5*l+1+l)*eye(Nx-2,Nx-2); 

end 

