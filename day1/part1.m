%% part 1
load input
sum(diff(input)>0)

%% part 2
slidingsum = input(1:end-2) + input(2:end-1) + input(3:end);
sum(diff(slidingsum)>0)
