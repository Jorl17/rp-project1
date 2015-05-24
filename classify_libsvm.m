function [ predicted_label, accuracy, decision_values ] = classify_libsvm( svm_model, data, varargin )
%CLASSIFY_LIBSVM Classifies a given data set using a trained LIBSVM
%implementation
%   Receives the trained LIBSVM model in the first parameter, "svm_model".
%   The training data is stored in the variable "data", a m-by-n matrix
%   where n is the number of features of the classification instances and
%   m is the number of classification instances.
%   Additionally there is an opcional parameter containing the true
%   classficiation for each provided instance, used to compute the
%   classifiers accuracy. If the true classification of the provided
%   instances is not known this parameter should be ignored, as well as the
%   second and third return values of this function.
%   This method returns the classification for each instance, the
%   classification accuracy and the classification decision values.
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

