function [ column_names, higgs_data, higgs_classes ] = load_dataset()
    
    load('dataset/higgs_data.mat');
    higgs_data=higgs_data_for_optimization(:,2:end);
    higgs_classes=higgs_data_for_optimization(:,32);
end

