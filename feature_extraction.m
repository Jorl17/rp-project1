function [ data ] = feature_extraction(data, method, target_number_of_features)
    if strcmp(method, 'pca')
        m = pca(data.X, target_number_of_features);
        data = linproj(data, m);
    elseif strcmp(method, 'lda')
        m = lda(data, target_number_of_features);
        data = linproj(data, m);
    end
end