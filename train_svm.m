function [ SVMStruct ] = train_svm( x_data, y_data )
%TRAIN_SVM Trains a MATLAB implemented SVM Classifier with a given set of
%taining data and labels
%   Receives the training data in the arrays "x_data" and "y_data" and
%   trains a MATLAB SVM.
%   x_data is a m-by-n matrix, where n is the number of features,
%   containing in each row the feature values for the given training
%   instance.
%   y_data is a m-by-1 matrix, containing the classification/label of each
%   training instance.
%   This method returns a MATLAB SVMStruct object, containing the trained
%   classifier.

    % As in LIBSVM we could think about changing the kernel function,
    % however the linear kernel function seems to be more suitable for our
    % situation, since we have two classes...
    % "Default: 'linear' for two-class learning and 'gaussian' (or 'rbf')
    % for one-class learning" taken from MATLAB help
    SVMStruct = fitcsvm(x_data', double(y_data), 'KernelFunction', 'linear');
    %SVMStruct = fitcsvm(x_data', double(y_data), 'KernelFunction', 'RBF');
end