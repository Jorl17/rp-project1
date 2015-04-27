function [ data, indexes ] = fsKruskalWallis(data, target_number_of_features)
% Taken from http://featureselection.asu.edu/software.php

    X = data.X;
    Y = data.y;
    [~, n] = size(X);
    out.W = zeros(n,1);

    for i=1:n
        out.W(i) = -kruskalwallis(vertcat(X(:,i)', Y'),{},'off');
    end

    [~, out.fList] = sort(out.W, 'descend');
    out.prf = 1;
    
    indexes = out.fList(1:target_number_of_features);
    data.X = data.X(:,indexes);
    data.y = data.y(:,indexes);
end