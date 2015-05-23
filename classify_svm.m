function [ result ] = classify_svm( svm_model, data)

    result = svmclassify(svm_model, data);
end