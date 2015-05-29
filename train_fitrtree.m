function [ tree ] = train_fitrtree( training_x, training_y )
%TRAINFITRTREE creates a regression tree for predictors in training_x and
%class labels in training_y

    % The only parameter worth changing would probably be the cross
    % validation, but we decided to skip it for now
    tree = fitrtree(training_x', training_y);
end