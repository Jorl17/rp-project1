function [ SVMStruct ] = train_svm( x_data, y_data, varargin )

    if (iscell(varargin) && ~isempty(varargin))
        %Convert to string because varargin is a cell array
        maximum_number_iterations = cell2mat(varargin);
        if (maximum_number_iterations <= 0)
            maximum_number_iterations = 100000;
        end
    else
        maximum_number_iterations = 100000;
    end

    %Increase the maximum number of iterations! Let the CPU burn!!!
    options.MaxIter = maximum_number_iterations; 
    % Simply call svmtrain
    SVMStruct = svmtrain(x_data, y_data, 'Options', options);
end