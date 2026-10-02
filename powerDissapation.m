function powerDis = powerDissapation(x)

% Read the resistance data
resistanceValues = readResistances('node_resistances.txt');

% Read the known voltage data
voltageData = readVoltages('node_voltages.txt');

% Create a vector to store the power values
powerValues = zeros(20,1);

% Test resistance values from 1 to 20 ohms
for resistances = 1:20

    % Create a vector containing the new resistance value
    newR = zeros(length(resistanceValues),1) + resistances;

    % Replace the resistance values in column 3
    resistanceValues(:,3) = newR;

    % Rebuild the system using the new resistance values
    [A,b] = buildSystem(resistanceValues,voltageData);

    % Perform LU factorization
    [L,U] = LUFactorization(A);

    % Solve Ly=b using forward substitution
    y = triangularSolve(L,b,'lower');

    % Solve Ux=y using backward substitution
    x = triangularSolve(U,y,'upper');

    % Calculate the current through each link
    currents = computeCurrents(resistanceValues,x);

    % Create a vector to store the power for each link
    values = zeros(length(resistanceValues),1);

    % Go through each resistor link
    for i = 1:length(resistanceValues)

        % Get the two nodes connected by the resistor
        node1 = resistanceValues(i,1);
        node2 = resistanceValues(i,2);

        % Get the voltage at each node
        V1 = x(node1);
        V2 = x(node2);

        % Calculate power using P = VI
        values(i) = (V1-V2) * currents(i,3);

    end

    % Add the power dissipated by all resistor links
    powerValues(resistances) = sum(values);

end

% Return the power values
powerDis = powerValues;

% Plot the power values
figure
plot(powerValues)

xlabel('Resistance (Ohms)')
ylabel('Total Power Dissipation (W)')
title('Power Dissipation vs. Resistance')
grid on

end