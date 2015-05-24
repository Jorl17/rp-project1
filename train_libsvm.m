function [ svm_model ] = train_libsvm( training_x, training_y, varargin )
    
    if (iscell(varargin) && ~isempty(varargin))
        %Convert to string because varargin is a cell array
        maximum_number_iterations = cell2mat(varargin);
        if (maximum_number_iterations <= 0)
            maximum_number_iterations = 100000;
        end
    else
        maximum_number_iterations = 100000;
    end

    %%%
    %% LibSVM Documentation:
    %% svmtrain(training_label_vector, training_instance_matrix [, 'libsvm_options']);
    %%%%    
    options.MaxIter = maximum_number_iterations;
    %svm_model = libsvmtrain(training_y, training_x, 'Options', options);
    svm_model = libsvmtrain(training_y, training_x);
    
end