fname1 = 'example.txt'; 
fname2 = 'input.txt'; 
input = readlines(fname2);
input = arrayfun(@str2num, char(input)); 


A = input; 


% set up adjacent grid
[grdx, grdy] = meshgrid(-1:1:1); 
adjx = grdx([1:4, 6:9])'; adjy = grdy([1:4, 6:9])'; 

flash_count = 0; 
for step = 1: 1e3
    temp_fc = flash_count; 
    A = A+1; 
    % initialize flashing
    newflashing = A>9;
    while sum(newflashing, 'all')
        flash_count = flash_count + sum(newflashing, 'all'); 

        oldflashing = A>9; 
        [flashr, flashc]= find(newflashing); 
        for i = 1: size(flashr, 1)
            adj = adjacent(A, flashr(i), flashc(i), adjx, adjy);
            A(adj) = A(adj) + 1; 
        end
        newflashing = A>9 & ~oldflashing;
    end
    if flash_count-temp_fc == numel(A)
        answer(2) = step;
        break
    end
    A(A>9) = 0; 
end
answer(1) = flash_count; 


function ind = adjacent(A, fr, fc, adjx, adjy)
sz = size(A); 
r = fr + adjx; 
c = fc + adjy; 
cond = r<1 | r>sz(1) | c<1 | c>sz(2);
r(cond) = []; 
c(cond) = []; 
ind = sub2ind(sz, r, c); 
end