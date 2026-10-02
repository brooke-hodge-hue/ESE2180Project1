function bottomCurrents = BottomCurrent()

    % Store the bottom current for each grid size
    bottomCurrents = zeros(1,5);

    i = 1;

    % Go through the required grid sizes
    for k = [5,10,15,20,25]

        % Number of nodes in the k x k grid
        numNodes = k^2;

        % Start with an empty resistance matrix
        resistances = [];

        % Create the resistor connections for the grid
        for node = 1:numNodes

            % Connect to the node on the right
            if mod(node,k) ~= 0
                resistances = [resistances; node node+1 1];
            end

            % Connect to the node below
            if node <= numNodes-k
                resistances = [resistances; node node+k 1];
            end

        end

        % Top-left node is 10 V
        % Bottom-right node is 0 V
        voltageData = [1 10;
                       numNodes 0];

        % Build the system
        [A,b] = buildSystem(resistances,voltageData);

        % LU factorization
        [L,U] = LUFactorization(A);

        % Solve for the node voltages
        y = triangularSolve(L,b,'lower');
        x = triangularSolve(U,y,'upper');

        % Calculate the currents
        currents = computeCurrents(resistances,x);

        % Add the two currents entering the bottom-right node
        bottomCurrents(i) = currents(end,3) + currents(end-1,3);
        i = i+1;
    end

    % Display the currents
    disp(bottomCurrents)

    % Plot the currents
    figure
    plot([5,10,15,20,25],bottomCurrents,'o-')

    xlabel('Grid Size')
    ylabel('Current Entering Bottom-Right Node (A)')
    title('Bottom-Right Current vs. Grid Size')
    grid on

end