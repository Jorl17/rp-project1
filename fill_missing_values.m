function [ outdata ] = fill_missing_values( indata, technique,varargin)
    if strcmp(technique,'discard')
        outdata = fill_missing_values_discard(indata);        
    elseif strcmp(technique,'mean')
        outdata = fill_missing_values_mean(indata);        
    elseif strcmp(technique,'median')
        outdata = fill_missing_values_median(indata);        
    elseif strcmp(technique,'knn')
        %FIXME: hardcoded values
        [K,distance] = args_with_default_values(varargin,5,'euclidean');
        %args_with_default_values(varargin,5,'euclidian');
        %K = arg_with_default_value(varargin,1,5);
        %distance = arg_with_default_value(varargin,2,'euclidean');
        outdata = fill_missing_values_knn(indata,K,distance);
    else
        error('Unrecognized missing value technique: %s', technique);
    end    
end

