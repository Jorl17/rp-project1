target_number_of_features = 2;
[~, higgs_data] = load_dataset();
higgs_data = fill_missing_values(higgs_data, 'mean');
sprt_data = convert_to_sprt_data(higgs_data);
%{
[data_fisher, indexes_fisher] = feature_selection(sprt_data, 'fisher', target_number_of_features);
[data_fs_fisher, indexes_fs_fisher] = feature_selection(sprt_data, 'fsfisher', target_number_of_features);
[data_auc, indexes_auc] = feature_selection(sprt_data, 'auc', target_number_of_features);
%}
 fea = mrmr_multiplicative(sprt_data, target_number_of_features);
 fea
