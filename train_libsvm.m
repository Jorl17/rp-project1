function [ svm_model ] = train_libsvm( training_x, training_y )
%TRAIN_LIBSVM Trains a LIBSVM classifier with a given set of taining data
%and labels
%   Receives the training data in the arrays "training_x" and "training_y"
%   and trains a MATLAB SVM.
%   training_x is a m-by-n matrix, where n is the number of features,
%   containing in each row the feature values for the given training
%   instance.
%   training_y is a m-by-1 matrix, containing the classification/label of
%   each training instance.
%   This method returns a MATLAB SVMStruct object, containing the trained
%   classifier.

    % Check this link for more details regarding libsvmtrain's parameters:
    % http://www.openpr.org.cn/files/help/rn01re19.html
    % Might be interesting to change the type of kernel function? (default
    % is the Radial Basis Function) Apart from this I don't think any other
    % parameter is worth changing...
    svm_model = libsvmtrain(training_y, training_x');
end