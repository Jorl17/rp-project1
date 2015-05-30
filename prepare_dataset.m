function [ sprt_data_original, sprt_data_balanced, sprt_train, sprt_test ] = prepare_dataset()
%PREPAREDATASET Prepares the dataset for testing

    if exist('preprocessedData.mat', 'file') == 2
        load('preprocessedData.mat');
        return ;        
    end
    
    target_number_of_features_feature_extraction = 15;
    target_number_of_features_feature_selection = 7;
    [~, higgs_data] = load_dataset();
    higgs_data = fill_missing_values(higgs_data, 'knn');
    sprt_data_original = convert_to_sprt_data(higgs_data);
    sprt_data = feature_extraction(sprt_data_original, 'lda', target_number_of_features_feature_extraction);
    [sprt_data, ~] = feature_selection(sprt_data, 'fisher', target_number_of_features_feature_selection);
    sprt_data_balanced = balance_dataset(sprt_data, 'undersample');
    [sprt_train, sprt_test, ~] = split_training_test_validate(sprt_data_balanced, 0.7, 0.3, 0);
    save('preprocessedData.mat', 'sprt_data_original', 'sprt_data_balanced', 'sprt_train', 'sprt_test');
end