fname = 'input';
% A = fscanf(fopen(fname, 'r'), '%s', [10 5])';
A = fscanf(fopen(fname, 'r'), '%s', [100 100])';

A = arrayfun(@str2num, A);
risk = 0; 

n = size(A, 1);
m = size(A, 2); 

lowpoints = []; 
for i = 1: n
    for j = 1:m
        compare = step(i, j, n, m, A);
        if all(compare>A(i,j))
            risk = risk + A(i, j)+1;
            lowpoints = [lowpoints; [i, j]];
        end
    end
end

answer(1) = risk; 
% 
% C = A==9;
% imwrite(C, 'asdf.png')

% start at lowpoint
% if not in basins then
% do step for all compare points
% add new points to the new points
% for all new points do step for all compare points
% 
basinsizes = ones(size(lowpoints, 1), 1); 
basins = lowpoints(1, :); 
for i = 1: length(lowpoints)
    start = lowpoints(i, :); 
    newpoints = start;
    if ~ismember(start, basins, 'rows') || i==1
        if i>1      % i am not proud of this ok.
            basins = [basins; start];
        end
        while size(newpoints, 1) >=1
            prevsize = basinsizes(i); 
            for k = 1: size(newpoints, 1)
                [compare, idx] = step(newpoints(1, 1), newpoints(1, 2), n, m, A);
                newpoints(1, :) = []; % remove this point from new points
                for j = 1: size(compare, 1)
                    if compare(j) <9
                        [r, c] = ind2sub(size(A), idx(j));
                        if ~ismember([r, c], basins, 'rows')
                            basinsizes(i) = basinsizes(i) + 1;
                            basins = [basins; [r, c]];
                            newpoints = [newpoints; [r, c]];
                        end
                    end
                end
            end
        end
    end
end
answer(2) = prod(maxk(basinsizes, 3)); 

function [compare, idx] = step(i, j, n, m, A)
step = [i+1, j; i, j+1; i-1, j; i, j-1];
ai = find(step<1 | step(:, 2)>m | step(:, 1)>n );
[ri, ~] = ind2sub(size(step), ai);
step(ri, :) = [];
idx = sub2ind(size(A), step(:, 1), step(:, 2));
compare = A(idx);
end