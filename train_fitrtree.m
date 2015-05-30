function [ tree ] = train_fitrtree( sprt_data )
%TRAINFITRTREE creates a regression tree for predictors in sprt_data.X and
%class labels in sprt_data.y

    % The only parameter worth changing would probably be the cross
    % validation, but we decided to skip it for now
    tree = fitrtree(sprt_data.X', sprt_data.y);
end