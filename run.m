target_number_features = 2;
[~, higgs_data] = load_dataset();
higgs_data = fill_missing_values(higgs_data, 'mean');
sprt_data = convert_to_sprt_data(higgs_data);
[data_fisher, indexes_fisher] = fisher(sprt_data, target_number_features);
[data_fs_fisher, indexes_fs_fisher] = fsFisher(sprt_data, target_number_features);