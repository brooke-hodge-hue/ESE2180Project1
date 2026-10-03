function effectiveRValues = effectiveResistancePlot()

% Read the original resistance data
resistanceData = readResistances('node_resistances.txt');

% Store the effective resistance for R = 1 through 20 ohms
effectiveRValues = zeros(20,1);

% Test each resistance value
for R = 1:20

    % Make every link have the same resistance R
    resistanceData(:,3) = R;

    % Number of nodes
    n = 25;

    % Create the conductance matrix
    matrix = zeros(n,n);

    % Build the conductance matrix
    for k = 1:size(resistanceData,1)

        node1 = resistanceData(k,1);
        node2 = resistanceData(k,2);
        resistance = resistanceData(k,3);

        matrix(node1,node1) = matrix(node1,node1) + 1/resistance;
        matrix(node2,node2) = matrix(node2,node2) + 1/resistance;

        matrix(node1,node2) = matrix(node1,node2) - 1/resistance;
        matrix(node2,node1) = matrix(node2,node1) - 1/resistance;

    end

    % Apply a 1 A test current from node 1 to node 25
    elim = zeros(n,1);
    elim(1) = 1;
    elim(25) = -1;

    % Use node 25 as the reference node
    keep = true(n,1);
    keep(25) = false;

    % Remove node 25 from the system
    newm1 = matrix(keep,keep);
    newm2 = elim(keep);

    % Solve the system using LU factorization
    [L,U] = LUFactorization(newm1);

    y = triangularSolve(L,newm2,'lower');
    voltages = triangularSolve(U,y,'upper');

    % Node 1 is still the first value in the reduced system
    % Since the test current is 1 A, V1 = effective resistance
    effectiveRValues(R) = voltages(1);

end

% Plot effective resistance versus link resistance
figure
plot(1:20,effectiveRValues,'o-')

xlabel('Link Resistance (Ohms)')
ylabel('Effective Resistance (Ohms)')
title('Effective Resistance vs. Link Resistance')
grid on

end