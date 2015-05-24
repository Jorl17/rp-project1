function [ labels, accuracy, posterior_probabilities ] = classify_svm( svm_model, data, varargin )
%CLASSIFY_SVM Classifies a given data set using a trained MATLAB SVM
%implementation.
%   Receives the trained MATLAB SVM model in the first parameter,
%   "svm_model".
%   The training data is stored in the variable "data", a m-by-n matrix
%   where n is the number of features of the classification instances and
%   m is the number of classification instances.
%   Additionally there is an opcional parameter containing the true
%   classficiation for each provided instance, used to compute the
%   classifiers accuracy. If the true classification of the provided
%   instances is not known this parameter should be ignored, as well as the
%   second and third return values of this function.
%   This method returns the classification for each instance, the accuracy
%   of the classifier and the classification's posterior probabilities.
    [labels, posterior_probabilities] = predict(svm_model, data);
    %result = svmclassify(svm_model, data);
    if (iscell(varargin) && ~isempty(varargin))
        %True classification provided, compute classifier's accuracy
        classification = double(cell2mat(varargin(1)));
        number_instances = size(classification,1);
        correct_classifications = 0;
        for i=1:number_instances
            if classification(i) == labels(i)
                correct_classifications = correct_classifications + 1;
            end
        end
        accuracy = correct_classifications/number_instances;
    else
        %No true classification provided, return null value
        accuracy = 0.0;
    end
end