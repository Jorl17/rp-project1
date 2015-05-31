function [ labels, sprt_data_processed ] = classify(trained_model, method, data)
    
    if strcmp(method,'preprocess')
        if strcmp(trained_model.missing_value_method, 'knn')
            data = fill_missing_values(data, trained_model.missing_value_method, trained_model.K);
        else
            data = fill_missing_values(data, trained_model.missing_value_method);
        end

        sprt_data_processed = convert_to_sprt_data(data);
        sprt_data_processed = feature_extraction_from_model(sprt_data_processed, trained_model.feature_extraction_model);
        sprt_data_processed = select_indexes(sprt_data_processed, trained_model.selected_features);
    else
        sprt_data_processed = data;
    end
    
    if strcmp(trained_model.type, 'knn')        
        labels = classify_knn(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'fitctree')
        labels = classify_tree(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'fitrtree')
        labels = classify_tree(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'libsvm')
        labels = classify_libsvm(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'naive_bayes')
        labels = classify_naive_bayes(trained_model.m, sprt_data_processed);
    elseif strcmp(trained_model.type, 'svm')
        labels = classify_svm(trained_model.m, sprt_data_processed);
    else
        fprintf('Invalid method!!!!Let''s go Roger let''s go! Kernel Panic!!!!!!\n');
    end
end