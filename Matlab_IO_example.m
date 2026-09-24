filename = 'read_file.txt';

fid = fopen(filename);

if fid == -1
    error('Could not open the input file.');
end

data = fscanf(fid,'%d %d %f', [3 inf])';

A = [1 3 2 ;
    0 4.1 5 ;
    4 4 8];

fclose(fid);
filename_write = 'write_file.txt';

fid_write = fopen(filename_write,'w');

for i=1:3
    fprintf(fid_write, '%6.2f %6.2f %6.2f\n',A(i,:));
end
fclose(fid_write);