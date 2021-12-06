fname = 'input';
fid = fopen(fname, 'r'); 
input = fscanf(fid, '%d,%d -> %d,%d\n', [4, Inf])';

% add 1, because this is matlab
input = input+1;

% categorize inputs
x = input(:, [1 3]); y = input(:, [2 4]);
r1 = input(:, [1 2]); r2 = input(:, [3 4]);

% make a grid
grid_lim = [max(x(:)) max(y(:))];
grid = zeros(grid_lim); 
n = size(grid, 1);
for i = 1: length(input)
    A = get_lines(r1(i, :), r2(i, :));
    for j = 1:size(A, 1)
        grid(A(j, 1), A(j, 2)) = grid(A(j, 1), A(j, 2)) + 1;
    end
end

% find the answer
answer = sum(grid>=2, 'all'); 
disp(['The answer is ', num2str(answer)])

function B = get_lines(r1, r2)
% get directions
dir = sign(r2-r1);
% get all points on the line
x = r1(2):dir(2):r2(2);
y = r1(1):dir(1):r2(1); 
if ~dir(1)
    y = [y, r1(1)*ones(1, length(x))];
end
if ~dir(2)
    x = [x, r1(2)*ones(1, length(y))];
end
B = [y' x'];
end