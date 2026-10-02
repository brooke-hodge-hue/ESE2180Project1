function effectiveResistance = effectiveResistance(i, j, resistanceFile, n)

    % Read all resistance data
    allResistances = readResistances(resistanceFile);

    % Get node 1, node 2, and resistance for each link
    r1s = allResistances(:,1);
    r2s = allResistances(:,2);
    out = allResistances(:,3);

    % Create the conductance matrix
    matrix = zeros(n,n);
    
    % Go through each resistor
    for k = 1:size(r1s,1)

        resistance = out(k);

        % Add conductances to the matrix
        matrix(r1s(k), r1s(k)) = matrix(r1s(k), r1s(k)) + 1/resistance;
        matrix(r2s(k), r2s(k)) = matrix(r2s(k), r2s(k)) + 1/resistance;

        matrix(r1s(k), r2s(k)) = matrix(r1s(k), r2s(k)) - 1/resistance;
        matrix(r2s(k), r1s(k)) = matrix(r2s(k), r1s(k)) - 1/resistance;

    end

    % Create the current vector
    elim = zeros(n,1);

    % 1 A enters node i and leaves node j
    elim(i) = 1;
    elim(j) = -1;
    
    % Use node j as the reference node
    keep = true(n,1);
    keep(j) = false;

    % Remove the row and column for the reference node
    newm1 = matrix(keep,keep);
    newm2 = elim(keep);

    % Factor the reduced matrix
    [L,U] = LUFactorization(newm1);

    % Solve Ly = b
    y = triangularSolve(L,newm2,'lower');

    % Solve Ux = y
    voltages = triangularSolve(U,y,'upper');

    % Since node j is the reference node, Vj = 0
    % Find where node i is located in the reduced voltage vector
    nodes = find(keep);
    position = find(nodes == i);

    Vi = voltages(position);

    % Effective resistance = voltage difference / test current
    % Test current is 1 A, so Reff = Vi
    effectiveResistance = Vi;

end