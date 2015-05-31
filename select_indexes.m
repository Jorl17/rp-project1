function [ data ] = select_indexes ( data, indexes ) 
% SELECTINDEXES selects a given subset of the sprt_data given
    if indexes == -1
        fprintf('....No feature selection performed\n');
        return
    end
    data.X = data.X(indexes, :);
    data = convert_to_sprt_data([data.X' data.y]);
end