resistanceData = readResistances('node_resistances.txt');

voltageData = readVoltages('node_voltages.txt');

[A,b] = buildSystem(resistanceData,voltageData);

[L,U] = LUFactorization(A);

%Solve Ly=b using forward substitution 
y = triangularSolve(L,b,'lower');

%Solve Ux=y using backward substitution 
x = triangularSolve(U,y,'upper') %Our voltages 

%Currents 
currentData = computeCurrents(resistanceData,x) %third column is the current 

%Power 
powerDis = powerDissapation(x)

%Bottom current 
% Part 8ii - Bottom current
bottomCurrents = BottomCurrent()

%Effective Resistance 
effectiveR = effectiveResistance(1,25,'node_resistances.txt',25)

%Plotting effective Resistances 
effectiveRValues = effectiveResistancePlot();

% Write all results to output file
writeResults(x,currentData,powerDis,bottomCurrents,effectiveR);

