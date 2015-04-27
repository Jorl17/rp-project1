function [ outdata ] = fill_missing_values( indata, technique,varargin)
    if strcmp(technique,'discard')
        outdata = fill_missing_values_discard(indata);        
    elseif strcmp(technique,'mean')
        outdata = fill_missing_values_mean(indata);        
    elseif strcmp(technique,'median')
        outdata = fill_missing_values_median(indata);        
    elseif strcmp(technique,'knn')
        [K,distance] = args_with_default_values(varargin,5,'euclidean');
        outdata = fill_missing_values_knn(indata,K,distance);
    elseif strcmp(technique,'design')
        outdata = fill_missing_values_design(indata, varargin(1), varargin{2:end});
    else
        error('Unrecognized missing value technique: %s', technique);
    end    
end

