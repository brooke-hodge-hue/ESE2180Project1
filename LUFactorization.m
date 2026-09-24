function [L,U] = LUFactorization(A)

%Get the number of rows in A
n = size(A,1);

%U start off as a copy of A 
U = A;

%L to start as a matrix of zeros 
L = zeros(n,n);

%Put 1's along L's diagonal 
for i = 1:n
    L(i,i) = 1;
end 

%need to move through each pivot column 
for k = 1:n-1
    %Move through each row below the current pivot 
    for i = k+1:n
        %Calculate the multiplier needed to eliminate U(i,k)
        multiplier = U(i,k)/U(k,k);
        %Store the multiplier in L 
        L(i,k) = multiplier;
        %Now we must subtract the multiplier from the current row 
        U(i,:) = U(i,:)-multiplier*U(k,:);
    end 
end 

end

