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
    svm_model = libsvmtrain(training_y, training_x);
end