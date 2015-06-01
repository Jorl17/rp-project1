function [ data, indexes ] = fsFisher(data, target_number_of_features)
%Fisher Score for Feature Selection, using the N var formulation
%   Taken and adapted from http://featureselection.asu.edu/software.php
%   data is a stprtool data type, containing the features/observed data and
%        the respective classes, in the format (data.X, data.y)
%   target_number_of_features is the desired number of features to select

    X = data.X';
    Y = data.y;
    numC = max(Y);
    [~, numF] = size(X);
    W = zeros(1,numF);

    % statistic for classes
    cIDX = cell(numC,1);
    n_i = zeros(numC,1);
    for j = 1:numC
        cIDX{j} = find(Y(:)==j);
        n_i(j) = length(cIDX{j});
    end

    % calculate score for each features
    for i = 1:numF
        temp1 = 0;
        temp2 = 0;
        f_i = X(:,i);
        u_i = mean(f_i);

        for j = 1:numC
            u_cj = mean(f_i(cIDX{j}));
            var_cj = var(f_i(cIDX{j}),1);
            temp1 = temp1 + n_i(j) * (u_cj-u_i)^2;
            temp2 = temp2 + n_i(j) * var_cj;
        end

        if temp1 == 0
            W(i) = 0;
        else
            if temp2 == 0
                W(i) = 100;
            else
                W(i) = temp1/temp2;
            end
        end
    end

    [~, fList] = sort(W, 'descend');

    indexes = fList(1:target_number_of_features);
    data.X = X(:,indexes)';
end