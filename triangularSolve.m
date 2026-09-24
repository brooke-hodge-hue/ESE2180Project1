function x = triangularSolve(A,b,type)

%Get the number of equations 
n = size(A,1);

%Create a vector to store the solution 
x = zeros(n,1);

end 

%first doing the lower triangular matrix - forward substitution 
%check if A is a lower triangular matrix 

if type == 'lower'
    %Move from the first row to the last row 
    for i = 1:n
        %Start with the value of the right side of the equation 
        sum = b(i);
    end
end 
   
       