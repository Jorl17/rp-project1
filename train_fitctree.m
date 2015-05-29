function [ tree ] = train_fitctree( training_x, training_y )
%TRAINFITCTREE creates a classification decision tree for predictors in
%training_x and class labels in training_y
    tree = fitctree(training_x, training_y);
end

