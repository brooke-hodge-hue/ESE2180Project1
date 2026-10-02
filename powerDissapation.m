function powerDis = DissPower(x)
    resistanceValues = readResistances('node_resistances.txt');
    powerValues = zeros(20,1);
    for resistances = 1:20
        newR = zeros(length(resistanceValues),1)+resistances;
        resistanceValues(:,3) = newR;
        currents = computeCurrents(resistanceValues,x);
        values = zeros(length(resistanceValues),1);
        for i = 1:length(resistanceValues)
            node1 = resistanceValues(i,1);
            node2 = resistanceValues(i,2);
            V1 = x(node1);
            V2 = x(node2);
            values(i) = (V1-V2).*currents(i,3);
        end
        powerValues(resistances) = sum(values);
    end
    plot(powerValues)
    
end