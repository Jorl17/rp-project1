function [ knn_model ] = train_knn( sprt_train, varargin )
    [K] = args_with_default_values(varargin, 20);
    knn_model = knnrule(sprt_train,K);
end