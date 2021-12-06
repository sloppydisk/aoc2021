% state = [3,4,3,1,2];
state = fscanf(fopen('input', 'r'), '%d,', [1 Inf]);

T = 256; % days
reg_T = 7; % regular fish period
new_T = reg_T + 2; % new fish period
reg_state = reg_T == 1:new_T;

% keep track with bins, get initial state
bin_state = zeros(1, new_T); 
for i = 1: new_T
    bin_state(i) = sum(state==i-1);
end

for t = 1:T
    bin_state = [bin_state(2:end), bin_state(1)] + bin_state(1)*reg_state;
end

disp(['The answer is ', num2str(sum(bin_state))])