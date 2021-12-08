fname = 'example.txt';
fname2 = 'input.txt';

% part 1
[example.input, example.output] = my_read(fname); 
assert(my_count(example.output)==26)

[input, output] = my_read(fname2); 
answer(1) = my_count(output);




