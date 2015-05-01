function [ column_names, higgs_data ] = load_dataset()    
    load('dataset/higgs_data.mat');
    higgs_data=higgs_data_for_optimization(:,2:end);
    column_names = column_names(:,2:end);
end

