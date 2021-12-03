input = importdata('input');

forward_idx = strcmp(input.textdata, 'forward'); 
down_idx = strcmp(input.textdata, 'down'); 

up_idx = strcmp(input.textdata, 'up'); 

coord = [sum(input.data(forward_idx)), sum(input.data(down_idx))-sum(input.data(up_idx))];
answer1 = coord(1)*coord(2);

%% part 2

% down X increases your aim by X units.
% up X decreases your aim by X units.
% forward X does two things:
%    It increases your horizontal position by X units.
%    It increases your depth by your aim multiplied by X.

N = length(input.data);
coord2 = [0 0];
aim = 0; 
for i = 1:N
    val = input.data(i);
    if forward_idx(i)
        coord2(1) = coord2(1) + val;
        coord2(2) = coord2(2) + aim*val;
    elseif down_idx(i)
%         coord2(2) =+ val;
        aim = aim + val; 
    elseif up_idx(i)
        aim = aim - val; 
    end
end
answer = prod(coord2)