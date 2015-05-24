function [ result ] = classify_libsvm( svm_model, data )
    
    %Used to calculate the accuracy of the prediction. Not used in our scenario
    testing_label_vector = zeros(size(data,1), 1);
    result = libsvmpredict(testing_label_vector, data, svm_model);
end

