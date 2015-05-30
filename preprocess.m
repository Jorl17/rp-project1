function [selected_features, feature_extraction_model, sprt_data_balanced] = preprocess(higgs_data, missing_value_method, feature_selection_method, feature_extraction_method, target_number_of_features_feature_selection, target_number_of_features_feature_extraction, balancing_method, varargin)
    %Remember that data is NOT SPRT_DATA
    
    if strcmp(missing_value_method, 'knn')
        K = args_with_default_values(varargin, 5);
        higgs_data = fill_missing_values(higgs_data, missing_value_method, K);
    else
        higgs_data = fill_missing_values(higgs_data, missing_value_method);
    end
    sprt_data_original = convert_to_sprt_data(higgs_data);
    [sprt_data,feature_extraction_model] = feature_extraction(sprt_data_original, feature_extraction_method, target_number_of_features_feature_extraction);
    [sprt_data, selected_features] = feature_selection(sprt_data, feature_selection_method, target_number_of_features_feature_selection);
    sprt_data_balanced = balance_dataset(sprt_data, balancing_method);
    %[sprt_train, sprt_test, ~] = split_training_test_validate(sprt_data_balanced, train_pct, test_pct, validate_pct);
end