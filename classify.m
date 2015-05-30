function labels = classify(trained_model, sprt_test_data)
    if strcmp(trained_model.type, 'knn')        
        labels = classify_knn(trained_model.m, sprt_test_data);
    elseif strcmp(trained_model.type, 'fitctree')
        labels = classify_fitctree(trained_model.m, sprt_test_data);
    elseif strcmp(trained_model.type, 'fitrtree')
        labels = classify_fitrtree(trained_model.m, sprt_test_data);
    elseif strcmp(trained_model.type, 'libsvm')
        labels = classify_libsvm(trained_model.m, sprt_test_data);
    elseif strcmp(trained_model.type, 'naive_bayes')
        labels = classify_naive_bayes(trained_model.m, sprt_test_data);
    elseif strcmp(trained_model.type, 'svm')
        labels = classify_svm(trained_model.m, sprt_test_data);
    end
end