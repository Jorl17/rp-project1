function save_trained_model(name, model_train, selected_features, feature_extraction_model, missing_value_method)
    model_train.idx = selected_features;
    model_train.feature_extraction_model = feature_extraction_model;
    model_train.missing_value_method = missing_value_method;
    save(name, 'model_train')
end