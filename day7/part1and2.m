% io
example = [16,1,2,0,4,2,7,1,2,14]';
input = fscanf(fopen('input', 'r'), '%d,');

% part 1
f = @(y, x0) sum(abs(y-x0));
g = @(f, y) min(f(y, 1:length(y)));
assert(g(f, example)==37) % test 1

answer(1) = g(f, input);
disp(['The first answer is ', num2str(answer(1))])

% part 2
h = @(n) n.*(n+1)/2;
f2 = @(y, x0) sum(h(abs(y-x0)));
assert(g(f2, example)==168) % test 2

tic
answer(2) = g(f2, input);
toc
% Elapsed time is 0.006125 seconds.
disp(['The second answer is ', num2str(answer(2))])
