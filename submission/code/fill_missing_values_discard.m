function [ outdata ] = fill_missing_values_discard( indata )
    line_idx = sum(indata' == -999.0) == 0;
    outdata = indata(line_idx,:);        
end

