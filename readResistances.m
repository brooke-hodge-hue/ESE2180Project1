function resistanceData = readResistances(filename);

fid = fopen(filename);

if fid == -1
    error('Could not open the input file.');
end

resistanceData = fscanf(fid,'%d %d %f', [3 inf])';

fclose(fid);
end