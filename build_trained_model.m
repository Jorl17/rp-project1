function model_train = build_trained_model(model_train, selected_features, feature_extraction_model, missing_value_method, varargin)
    model_train.selected_features = selected_features;
    model_train.feature_extraction_model = feature_extraction_model;
    model_train.missing_value_method = missing_value_method;
    if strcmp(missing_value_method,'knn')
        model_train.K = args_with_default_values(varargin,5);
    end
end