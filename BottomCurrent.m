function BottomCurrent(x)
    totalResistanceValues = readResistances('node_resistances.txt');
    bottomCurrents = zeros(1,5);
    i = 1;
    for k = [5,10,15,25]
        resistances = totalResistanceValues(1:k,:);
        currents = computeCurrents(resistances,x);
        bottomCurrents(1:i) = currents(k,3);
        i = i+1;
    end
    disp(bottomCurrents)
end