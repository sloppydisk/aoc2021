%% part 1
filename = 'input';
input = load(filename);

% clean up input
% A = dec2base(input, 10) - '0';
M = max(floor(log10(input)));
A = mod(floor(input ./ 10 .^ (M:-1:0)), 10);

% get most common values
N = size(A, 1); 
bitties = sum(A, 1)>=N/2;
gamma = bin2dec(num2str(bitties)); 
eps = bin2dec(num2str(~bitties));
answer(1) = gamma*eps;

%% part 2
ox_idx = boolean(ones(N, 1)); co2_idx = ox_idx; 
most_common_fun = @(idx, k) sum(A(idx, k), 1)>=sum(idx)/2;
for k = 1: M+1
    if sum(ox_idx, 1)>1
        most_common_ox = most_common_fun(ox_idx, k);
        remove_ox_idx = A(:, k) == not(most_common_ox); % remove the least common indices
        ox_idx(remove_ox_idx) = 0;
    end
    if sum(co2_idx, 1)>1
        most_common_co2 = most_common_fun(co2_idx, k);
        remove_co2_idx = A(:, k) == most_common_co2;     % remove the most common indices
        co2_idx(remove_co2_idx) = 0;
    end
end

ox = bin2dec(num2str(A(ox_idx, :)));
co2 = bin2dec(num2str(A(co2_idx, :)));
answer(2) = ox*co2;