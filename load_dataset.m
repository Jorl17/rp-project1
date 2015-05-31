function [ column_names, higgs_data ] = load_dataset( filePath )
    if nargin < 1
        filePath = 'dataset/higgs_data.mat';
    end
    load(filePath);
    higgs_data=higgs_data_for_optimization(:,2:end);
    column_names = column_names(:,2:end);
end

