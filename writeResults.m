function writeResults(x,currentData)

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

% Close the output file
fclose(fid_write);

end