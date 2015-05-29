function [ predicted_values ] = classify_tree( tree, data )
%UNTITLED4 Classifies a given data set using a trained MATLAB FITCTREE
%implementation
    predicted_values = predict(tree, data);
end

