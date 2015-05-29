function [ tree ] = train_fitrtree( training_x, training_y )
%TRAINFITRTREE creates a regression tree for predictors in training_x and
%class labels in training_y
    tree = fitrtree(training_x, training_y);
end