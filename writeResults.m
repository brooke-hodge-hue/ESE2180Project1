function writeResults(x,currentData,powerDis,bottomCurrents,effectiveR)

% Open the output file
filename_write = 'output.txt';
fid_write = fopen(filename_write,'w');

% Check that the file opened correctly
if fid_write == -1
    error('Could not open the output file.');
end

% Write the node voltages
fprintf(fid_write,'Node Voltages\n');

for i = 1:length(x)
    fprintf(fid_write,'%d %6.2f\n',i,x(i));
end

% Write the currents through each link
fprintf(fid_write,'\nLink Currents\n');

for i = 1:size(currentData,1)
    fprintf(fid_write,'%d %d %6.2f\n',currentData(i,:));
end

% Write the power dissipation
fprintf(fid_write,'\nPower Dissipation\n');
fprintf(fid_write,'Resistance (Ohms) Total Power (W)\n');

for i = 1:length(powerDis)
    fprintf(fid_write,'%d %6.2f\n',i,powerDis(i));
end

% Write the bottom-right current results
fprintf(fid_write,'\nBottom-Right Current\n');
fprintf(fid_write,'Grid Size    Current (A)\n');

gridSizes = [5 10 15 20 25];

for i = 1:length(bottomCurrents)
    fprintf(fid_write,'%d x %d    %6.4f\n', ...
        gridSizes(i),gridSizes(i),bottomCurrents(i));
end

%Writing the effective resistance 
fprintf(fid_write,'\nEffective Resistance\n');
fprintf(fid_write,'Nodes 1 and 25: %6.4f Ohms\n',effectiveR);

% Close the output file
fclose(fid_write);

end