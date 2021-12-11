fname1 = 'example.txt';
fname2 = 'input';
input = readlines(fname2);

delim = {'([{<', ')]}>'};
n = length(input); 
isc = false(n, 1);      % is corrupted boolean
c_idx = zeros(n, 1);    % corrupted indices
compl_str = string(zeros(n, 1));                  % completion strings

points = [3; 57; 1197; 25137];
delims = {')';']';'}';'>'};
mytab = table(points, 'rownames', delims);  % tables are so ugly in matlab lol
total = 0; 
for j = 1: n
    this_str = input(j);
    [isc(j), c_idx(j), compl_str(j)] = syntaxCheck(this_str, delim);
    if isc(j)
        charizard = char(this_str); 
        this_c_char = charizard(c_idx(j)); 
        total = total + table2array(mytab(this_c_char, 'points'));
    end
end

answer(1) = total; 

% part 2
% discard corrupted
input(isc) = []; 
compl_str(isc) = []; 

score = zeros(length(input), 1); 
% compute score
for i = 1: length(input)
    score(i) = scoreString(compl_str(i), delim);
end
score = sort(score); 
format longG
answer(2) = score(ceil(length(input)/2)); 

function y = scoreString(str, delim)
charmeleon = char(str); 
y = 0;
for asdf = 1: length(charmeleon)
    y = 5*y; 
    pts = find(delim{1}==charmeleon(end+1-asdf));
    y = y + pts; 
end
end


function [iscorrupted, idx, opened] = syntaxCheck(str, delim)
opened = '';
idx = nan; 
chars = char(str); 
for i = 1: strlength(chars)
    this_char = chars(i); 
    [a, loca] = ismember(this_char, delim{1}); 
    [b, locb] = ismember(this_char, delim{2}); 
    if a
        opened = append(opened, this_char);     % keep track of all opened chars
        lastopened = loca;                      % keep track of the delim index of the last opened char
    elseif b
        if locb == lastopened && ~isempty(opened)   % can't close something if nothing is opened
            iscorrupted = 0;
            opened(end) = [];       % remove the last opened char
            if ~isempty(opened)
                lastopened = find(delim{1}==opened(end));
            else
                lastopened = nan;   % if nothing is open, there is also no last opened index
            end
        else
            iscorrupted = 1;
            idx = i;
            break
        end
    end
end
end