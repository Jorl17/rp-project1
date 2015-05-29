function [ model ] = train_naive_bayes( x_data, y_data )
%TRAINNAIVEBAYES Returns a naive Bayes model for the given predictions and
%labels
    model = fitcnb(x_data', y_data);
end