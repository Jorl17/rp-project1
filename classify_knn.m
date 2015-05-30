function [ labels ] = classify_knn( model, sprt_test, varargin )
    labels = knnclass(sprt_test.X,model);
end