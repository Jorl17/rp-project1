function [ outdata ] = fill_missing_values( indata, technique )
    if strcmp(technique,'discard')
        outdata = fill_missing_values_discard(indata);        
    elseif strcmp(technique,'mean')
        outdata = fill_missing_values_mean(indata);        
    elseif strcmp(technique,'median')
        outdata = fill_missing_values_median(indata);        
    elseif strcmp(technique,'knn')
        %FIXME: hardcoded values
        K = 5;
        distance = 'euclidean';
        outdata = fill_missing_values_knn(indata,K,distance);
    else
        error('Unrecognized missing value technique: %s', technique);
    end    
end

