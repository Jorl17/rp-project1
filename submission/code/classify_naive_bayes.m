function [ predicted_values ] = classify_naive_bayes(model, data)
%CLASSIFYNAIVEBAYES Classifies a given data set using a trained MATLAB
%Naive Bayes Model implementation
    predicted_values = predict(model, data.X');
end