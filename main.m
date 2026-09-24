resistanceData = readResistances('node_resistances.txt');

voltageData = readVoltages('node_voltages.txt');

[A,b] = buildSystem(resistanceData,voltageData);
