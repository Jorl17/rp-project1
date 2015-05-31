function [ predicted_values ] = classify_tree( tree, data )
%CLASSIFYTREE Classifies a given data set using a trained MATLAB FITCTREE
%implementation. This function can either receive a fitctree model or a
%fitrtree model.
    predicted_values = predict(tree, data.X');
end

