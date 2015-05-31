function [ data ] = select_indexes ( data, indexes ) 
% SELECTINDEXES selects a given subset of the sprt_data given
    data.X = data.X(indexes, :);
    data = convert_to_sprt_data([data.X' data.y]);
end