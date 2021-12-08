function c = count(A)
count_output = cellfun(@strlength, A);
easy = [2 3 4 7]; 
c = 0; 
for i = 1: 4
    c = c + sum(count_output == easy(i), 'all'); 
end
end