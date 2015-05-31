function shuffled = shuffle(indata, which)
    [rows,cols] = size(indata);
    if nargin == 1
        if rows > cols
            which = 'rows';
        else
            which = 'cols';
        end
    end
    
    if strcmp(which,'rows')
        p = randperm(rows);
        shuffled = indata(p,:);
    elseif strcmp(which,'cols')
        p = randperm(cols);
        shuffled = indata(:,p);
    end
end