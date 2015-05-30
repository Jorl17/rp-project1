function labels = classify(trained_model, test_higgs_data)
    
    if strcmp(trained_model.missing_value_method, 'knn')
        test_higgs_data = fill_missing_values(test_higgs_data, trained_model.missing_value_method, trained_model.K);
    else
        test_higgs_data = fill_missing_values(test_higgs_data, trained_model.missing_value_method);
    end
    
    sprt_data_processed = convert_to_sprt_data(test_higgs_data);
    sprt_data_processed = feature_extraction_from_model(sprt_data_processed, trained_model.feature_extraction_model);
    sprt_data_processed = select_indexes(sprt_data_processed, model.selected_features);

    if strcmp(trained_model.type, 'knn')        
        labels = classify_knn(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'fitctree')
        labels = classify_fitctree(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'fitrtree')
        labels = classify_fitrtree(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'libsvm')
        labels = classify_libsvm(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'naive_bayes')
        labels = classify_naive_bayes(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'svm')
        labels = classify_svm(trained_model.m, sprt_data_processed);
    end
end