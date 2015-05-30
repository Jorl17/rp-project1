function model_train = save_trained_model(name, model_train, selected_features, feature_extraction_model, missing_value_method)
    model_train = build_trained_model(model_train, selected_features, feature_extraction_model, missing_value_method);
    save(name, 'model_train')
end