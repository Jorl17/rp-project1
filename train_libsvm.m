function [ svm_model ] = train_libsvm( training_x, training_y, varargin )
%TRAIN_LIBSVM Trains a LIBSVM classifier with a given set of taining data
%and labels
%   Receives the training data in the arrays "training_x" and "training_y"
%   and trains a MATLAB SVM.
%   training_x is a m-by-n matrix, where n is the number of features,
%   containing in each row the feature values for the given training
%   instance.
%   training_y is a m-by-1 matrix, containing the classification/label of
%   each training instance.
%   Additionally, there is an opcional parameter used to define
%   the maximum number of iterations of the training process.
%   This method returns a MATLAB SVMStruct object, containing the trained
%   classifier.
    
    if (iscell(varargin) && ~isempty(varargin))
        %Convert to string because varargin is a cell array
        maximum_number_iterations = cell2mat(varargin);
        if (maximum_number_iterations <= 0)
            maximum_number_iterations = 100000;
        end
    else
        maximum_number_iterations = 100000;
    end

    %%%
    %% LibSVM Documentation:
    %% svmtrain(training_label_vector, training_instance_matrix [, 'libsvm_options']);
    %%%%    
    options.MaxIter = maximum_number_iterations;
    %svm_model = libsvmtrain(training_y, training_x, 'Options', options);
    svm_model = libsvmtrain(training_y, training_x);
    
end