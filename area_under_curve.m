function [data, indexes] = area_under_curve(data, target_number_of_features)
%AREA_UNDER_CURVE Implementation of the Area Under Curve filter for feature
%selection
%   data is the higgins data (features of all the entries in the dataset)
%   target_number_of_features is the desired number of features to select

    X = data.X';
    Y = data.y;
    number_features = size(X, 2);
    auc_scores = zeros(1, number_features);
    
    for i=1:number_features
        [~,~,~,auc] = perfcurve(Y, X(:, i), 1);
        auc_scores(i) = auc;
    end
    
    [~, indexes] = sort(auc_scores, 'descend');
    indexes = indexes(1:target_number_of_features);
    data.X = X(:,indexes)';
end