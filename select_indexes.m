function [ data ] = select_indexes ( data, indexes ) 
% SELECTINDEXES selects a given subset of the sprt_data given

    data.X = data.X(indexes, :);
    data.y = data.y(indexes);
end