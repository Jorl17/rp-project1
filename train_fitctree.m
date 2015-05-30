function [ tree ] = train_fitctree( sprt_data )
%TRAINFITCTREE creates a classification decision tree for predictors in
%sprt_data.X and class labels in sprt_data.y
    tree = fitctree(sprt_data.X', sprt_data.y);
end

