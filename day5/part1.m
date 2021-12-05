fname = 'input';
fid = fopen(fname, 'r'); 
input = fscanf(fid, '%d,%d -> %d,%d\n', [4, Inf])';

% add 1, because this is matlab
input = input+1;
a = input(:, [1 3]); b = input(:, [2 4]);

x1 = input(:, 1); y1 = input(:, 2); x2 = input(:, 3); y2 = input(:, 4);

% check for horizontal and vertical
vert = (x1 == x2); 
hor = (y1 == y2); 

% make a grid
grid_lim = [max([x1; x2]) max([y1; y2])];
grid = zeros(grid_lim); 
n = size(grid, 1);

% fill the grid
for i = 1: length(input)
    xi1 = min(a(i, :)); xi2 = max(a(i, :)); yi1 = min(b(i, :)); yi2 = max(b(i, :)); 
    if hor(i)
        grid(y1(i), xi1: xi2) = grid(y1(i), xi1: xi2) + 1; 
    end
    if vert(i)
        grid(yi1: yi2, x1(i)) = grid(yi1: yi2, x1(i)) + 1; 
    end
end

% find the answer
answer = sum(grid>=2, 'all'); 
disp(['The answer is ', num2str(answer)])

