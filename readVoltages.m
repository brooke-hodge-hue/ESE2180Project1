function voltageData = readVoltages(filename);

fid = fopen(filename);

if fid == -1
    error('Could not open the input file.');
end

voltageData = fscanf(fid, '%f', [2 inf])';

fclose(fid);
end