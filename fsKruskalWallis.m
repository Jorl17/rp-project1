function [ data, indexes ] = fsKruskalWallis(data, target_number_of_features)
%FSKRUSKALWALLIS Implementation of the Kruskal-Wallis test for feature
%selection
%Taken and adapted from http://featureselection.asu.edu/software.php
%   data is the higgins data (features of all the entries in the dataset)
%   target_number_of_features is the desired number of features to select

    X = data.X';
    Y = data.y;
    [~, n] = size(X);
    W = zeros(n,1);

    for i=1:n
        W(i) = -kruskalwallis(vertcat(X(:,i)', Y'),{},'off');
    end

    [~, fList] = sort(W, 'descend');
    
    indexes = fList(1:target_number_of_features);
    data.X = X(:,indexes)';
end