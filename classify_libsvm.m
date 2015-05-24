function [ predicted_label, accuracy, decision_values ] = classify_libsvm( svm_model, data, varargin )
    
    if (iscell(varargin) && ~isempty(varargin))
        testing_label_vector = double(cell2mat(varargin(1)));
    else
        testing_label_vector = zeros(size(data,1), 1); 
    end
    %testing_label_vector is going to be used to compute the accuracy of
    %the prediction
    [predicted_label, accuracy, decision_values] = libsvmpredict(testing_label_vector, data, svm_model);
    accuracy = accuracy(1);
end

