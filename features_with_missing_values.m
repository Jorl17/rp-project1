function cols_list = features_with_missing_values(dataset)
    cols_list = find(sum(dataset == -999) > 0); 
end