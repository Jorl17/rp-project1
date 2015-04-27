function [ data, indexes ] = fisher(data, target_number_of_features)
%FIHSER Implementation of the Fisher Filter method for feature selection
%   data is a stprtool data type, containing the features/observed data and
%        the respective classes, in the format (data.X, data.y)
%   target_number_of_features is the desired number of features to select
     
    X = data.X';
    classes = data.y;
    number_features = size(X, 2);
    scores = zeros(1,number_features);
    classes_unique = unique(classes);
    
    % Fisher Score: (mean_feature(i)_class_1 - ... - mean_feature(i)_class_2)^2 / (STD_class_1^2 + STD_class_2^2 + ... + STD_class_n^2)
        
    for i=1:number_features
        % Rank each feature according to a given metric -- Fisher Score
        mean_feature_classes = 0;
        std_squared_feature_classes = 0;
       
        %Compute the mean and std for each class, for this feature
        for k=length(classes_unique)
           j = classes_unique(k);
           indexes_current_class = find(classes(:,end)==j);
           if (k == 1)
               mean_feature_classes = mean(X(indexes_current_class,i));
           else
               mean_feature_classes = mean_feature_classes - mean(X(indexes_current_class,i));
           end
           std_squared_feature_classes = std_squared_feature_classes + (std(X(indexes_current_class,i))^2) ;
        end
        %Compute the fisher score
        scores(i) = (mean_feature_classes^2) / std_squared_feature_classes;
    end
    
    %Sort the scores in descending order (good features first) and return
    %their original indexes
    [~, indexes] = sort(scores, 'descend');
    
     indexes = indexes(1:target_number_of_features);
     data.X = X(:,indexes)';
end

