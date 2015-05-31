function [selected_features, feature_extraction_model, sprt_data] = preprocess(higgs_data, missing_value_method, do_feature_selection, feature_selection_method, do_feature_extraction, feature_extraction_method, target_number_of_features_feature_selection, target_number_of_features_feature_extraction, varargin)
    %Remember that data is NOT SPRT_DATA
    
    if strcmp(missing_value_method, 'knn')
        K = args_with_default_values(varargin, 5);
        higgs_data = fill_missing_values(higgs_data, missing_value_method, K);
    else
        higgs_data = fill_missing_values(higgs_data, missing_value_method);
    end
    sprt_data_original = convert_to_sprt_data(higgs_data);
    
    if do_feature_extraction
        [sprt_data,feature_extraction_model] = feature_extraction(sprt_data_original, feature_extraction_method, target_number_of_features_feature_extraction);
    else
        [sprt_data,feature_extraction_model] = feature_extraction(sprt_data_original, 'none', target_number_of_features_feature_extraction);
    end
    
    
    if do_feature_selection
        [sprt_data, selected_features] = feature_selection(sprt_data, feature_selection_method, target_number_of_features_feature_selection);
    else
        fprintf('....No feature selection performed[2]\n');
        selected_features=-1;
    end
    
    %[sprt_train, sprt_test, ~] = split_training_test_validate(sprt_data_balanced, train_pct, test_pct, validate_pct);
end