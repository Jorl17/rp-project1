function [ model ] = train_naive_bayes( sprt_data )
%TRAINNAIVEBAYES Returns a naive Bayes model for the given predictions and
%labels, present in sprt_data.X and sprt_data.y, respectively
    model = fitcnb(sprt_data.X', sprt_data.y);
end