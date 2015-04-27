function [ original_indexes ] = fisher(data, classes)
%FIHSER Implementation of the Fisher Filter method for feature selection
%   data is the higgins data (features of all the entries in the dataset)
%   classes is a list with the class of each entry in the datset
%   target_number_of_features is the desired number of features to select
     
    %FIXME: SINCE DATA(:,32) HAS THE LABEL WE ARE NOT INCLUDING IT HERE,
    %RIGHT???? CONFIRM IT!!!!
    number_features = size(data, 2)-1;
    scores = zeros(1,number_features);
    classes_unique = unique(classes);
    
    % Fisher Score: (mean_feature(i)_class_1 - ... - mean_feature(i)_class_2)^2 / (STD_class_1^2 + STD_class_2^2 + ... + STD_class_n^2)
        
    for i=1:number_features
        % Rank each feature according to a given metric -- Fisher Score
        mean_feature_classes = 0;
        std_squared_feature_classes = 0;
       
        %Compute the mean and std for each class
        for k=length(classes_unique)
           j = classes_unique(k);
           indexes_current_class = find(data(:,end)==j);
           if (k == 1)
               mean_feature_classes = mean(data(indexes_current_class,i));
           else
               mean_feature_classes = mean_feature_classes - mean(data(indexes_current_class,i));
           end
           std_squared_feature_classes = std_squared_feature_classes + (std(data(indexes_current_class,i))^2) ;
        end
        
        %Compute the fisher score
        scores(i) = (mean_feature_classes^2) / std_squared_feature_classes;
    end
    %Sort the scores in descending order (good features first) and return
    %their original indexes
    [~, original_indexes] = sort(scores, 'descend');
end

