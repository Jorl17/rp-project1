function [ outdata ] = fill_missing_values_knn( indata, k_neighbours, distance_method )
    indata(indata == -999) = NaN;
    outdata = knnimpute(indata, k_neighbours, 'Distance', distance_method);
end


