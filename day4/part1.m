filename = 'input';
% filename = 'example_input.txt';
fID = fopen(filename, 'r');

% get drawn numbers
draw = fscanf(fID, '%d,');

% get bingo boards
V = fscanf(fID, '%d');
n = 5; % size per board
m = length(V)/n;
A = reshape(V, n, m)';      % to check for rows
temp = permute(reshape(A', n, n, m/n), [2 1 3]);       % transpose to check for cols
B = reshape(temp, n, m)';

% row for ismember check
c1 = -1*ones(1, 5); 

% draw numbers and check for bingo
for k = 1: 1e4
    num = draw(k);
    A(A==num) = -1; B(B==num) = -1; 
    if any(ismember(A, c1, 'rows'))
        board = ceil(find(ismember(A, c1, 'rows'))/n);
        output = A;
        break
    elseif any(ismember(B, c1, 'rows'))
        board = ceil(find(ismember(B, c1, 'rows'))/n);
        output = B;
        break
    end
end

loc1 = (board-1)*n+1;
thisboard = output(loc1:loc1+n-1, :);
unmarked = sum(thisboard(thisboard~=-1));

answer = unmarked*num;
disp(['The answer is ', num2str(answer)])