function [input, output] = my_read(filename)
% fid = fopen(fname, 'r'); 
format = '%s';

a = textread(filename, format, 'delimiter', '|');
b = cellfun(@strsplit, a, 'UniformOutput', false);
output = b(2:2:end); output = cellfun(@sort, vertcat(output{:}), 'UniformOutput', false);
input = b(1:2:end); input = cellfun(@sort, vertcat(input{:}), 'UniformOutput', false); 
end