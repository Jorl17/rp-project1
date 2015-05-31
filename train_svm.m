function [ SVMStruct ] = train_svm( sprt_data, method )
%TRAIN_SVM Trains a MATLAB implemented SVM Classifier with a given set of
%taining data and labels
%   Receives the training data in the sprt format and trains a MATLAB SVM.
%   sprt_data.X is a m-by-n matrix, where n is the number of features,
%   containing in each row the feature values for the given training
%   instance.
%   sprt_data.y is a m-by-1 matrix, containing the classification/label of each
%   training instance.
%   This method returns a MATLAB SVMStruct object, containing the trained
%   classifier.

    % As in LIBSVM we could think about changing the kernel function,
    % however the linear kernel function seems to be more suitable for our
    % situation, since we have two classes...
    % "Default: 'linear' for two-class learning and 'gaussian' (or 'rbf')
    % for one-class learning" taken from MATLAB help
    if method == 0
    	SVMStruct = fitcsvm(sprt_data.X', double(sprt_data.y), 'KernelFunction', 'linear');
    elseif method == 1
        SVMStruct = fitcsvm(sprt_data.X', double(sprt_data.y), 'KernelFunction', 'polynomial');
    else
    	SVMStruct = fitcsvm(sprt_data.X', double(sprt_data.y), 'KernelFunction', 'RBF');
    end
end