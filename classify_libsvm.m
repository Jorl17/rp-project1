function [ result ] = classify_libsvm( svm_model, data, varargin )
    
    if (iscell(varargin) && ~isempty(varargin))
        testing_label_vector = double(cell2mat(varargin(1)));
    else
        testing_label_vector = zeros(size(data,1), 1); 
    end
    %testing_label_vector is going to be used to compute the accuracy of
    %the prediction
    result = libsvmpredict(testing_label_vector, data, svm_model);
end

