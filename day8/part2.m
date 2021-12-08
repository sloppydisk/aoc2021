% part 2
% fname = 'example.txt';
fname = 'input.txt';

[input, output] = my_read(fname);

% reformat inputs
A = reformat(input, output);

% deduce maps
M = deduce_mapping(A);

% set up doing the mapping
B = cellfun(@(x)cast(x, 'double')-96, output, 'UniformOutput', false);
n = size(B, 1); 
C = B; 
D = zeros(n, 4); 

map_to_digit = {[0, 1, 2, 4, 5, 6], [2, 5], [0, 2, 3, 4, 6], [0, 2, 3, 5, 6],...
    [1, 2, 3, 5], [0, 1, 3, 5, 6], [0, 1, 3, 4, 5, 6], [0, 2, 5], 0:6, [0, 1, 2, 3, 5, 6]};
total = 0; 

% do the mapping
for k = 1: n
    for j = 1: 4
        for i = 1: length(B{k, j})
            C{k, j}(i) = find(B{k, j}(i) == M(k, :));   % use the map to find which lights are on
        end
        temp = sort(C{k, j})-1;
        % map lights to digits
        cellnum = cellfun(@(a)isequal(a, temp), map_to_digit, 'UniformOutput', false);
        num = find(cell2mat(cellnum))-1; 
        total = total+num*10^(4-j);     % add up to the total  
        D(k, j) = num;                  % write to array
    end
end

disp(total)

function map = deduce_mapping(cl)
n = size(cl, 1); 
map = nan(n, 7);
for k = 1: n
    map(k, 1) = setdiff(cl{k, 2}, cl{k, 1}); % <-- find zero
    onethree = setdiff(cl{k, 3}, cl{k, 1});
    zerothreesix = find(histcounts(cl{k, 4})==3);
    map(k, 7) = setdiff(zerothreesix, [onethree, map(k, 1)]);  % <-- find six
    twothreefour = find(histcounts(cl{k, 5})==2);
    onetwothreefive = cl{k, 3}; 
    map(k, 5) = setdiff(twothreefour, onetwothreefive);  % <-- find four
    map(k, 4) = setdiff(zerothreesix, map(k, [1, 7])); % <-- find three
    map(k, 3) = setdiff(twothreefour, map(k, [4, 5])); % <-- find two
    map(k, 6) = setdiff(cl{k, 1}, map(k, 3)); % <-- find five
    map(k, 2) = setdiff(1:7, map(k, :)); % <-- find one
end
end

function D = reformat(input, output)
A = horzcat(input, output);
B = cellfun(@(x)cast(x, 'double')-96, A, 'UniformOutput', false);
% C = cellfun(@length, B); 
D = cell(size(B, 1), 6); 
for i = 1: size(B, 1)
    temp = B(i, :); 
    for j = 2: 7
        D(i, j-1) = {temp(cellfun(@length, temp) == j)};
        if (j==2||j==3||j==4||j==7)
            D(i, j-1) = D{i, j-1}(1);
        else 
            D(i, j-1) = {unique(cell2mat(D{i, j-1}'), 'rows')};
        end
    end
end
end


%  0000
% 1    2
% 1    2
%  3333
% 4    5
% 4    5
%  6666

% 2 chars: a 1 (2, 5)
% 3 chars: a 7 (0, 2, 5)
% 4 chars: a 4 (1, 2, 3, 5)
% 7 chars: an 8 (all)

% the 1 and 7 give location of the 0 <-
% the 4 and 1 gives the location of the 1+3 <-
% the 4 gives the 4+6+7+8
% the 1 gives location of 2+5 <-

% 5 chars: a 5, 2, or 3
% 5 (0, 1, 3, 5, 6)
% 2 (0, 2, 3, 4, 6)
% 3 (0, 2, 3, 5, 6)
% gives location of the 1+4 (1 occurence) <-
% gives the 2+5 (2 occurences)
% gives the 0+3+6 (3 occurences), combine with 1+3 and 0 -> gives 6

% 6 chars: a 9, 6, or 0
% 9 (0, 1, 2, 3, 5, 6)
% 6 (0, 1, 3, 4, 5, 6)
% 0 (0, 1, 2, 4, 5, 6)
% gives the 2+3+4 (2 occurences), combine with 1+2+3+5 gives the 4
% gives the 0+1+5+6  (3 occurences)
