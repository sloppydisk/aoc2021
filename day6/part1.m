% state = [3,4,3,1,2];
state = fscanf(fopen('input', 'r'), '%d,', [1 Inf]);
T = 256; % days
reg_T = 7; % regular fish period
new_T = reg_T + 2; % new fish period

% a = cell(T, 1); 
for t = 1:T
    state = [state-1 + reg_T*~state, (new_T-1)*~state(~state)]; 
%     a{t} = state;
end

disp(['The answer is ', num2str(length(state))])