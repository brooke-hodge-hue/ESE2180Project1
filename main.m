resistanceData = readResistances('node_resistances.txt');

voltageData = readVoltages('node_voltages.txt');

[A,b] = buildSystem(resistanceData,voltageData);

[L,U] = LUFactorization(A);

%Solve Ly=b using forward substitution 
y = triangularSolve(L,b,'lower');

%Solve Uy=b using backward substitution 
x = triangularSolve(U,y,'upper'); %Our voltages 

%Currents 
currentData = computeCurrents(resistanceData,x); %third column is the current 