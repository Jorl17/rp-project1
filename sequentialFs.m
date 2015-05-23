function [ data, indexes ] = sequentialFs(data, target_number_of_features, forward, varargin)
%SEQUENTIALFS Implementation of a Sequential Feature Selection approach for
%             feature selection
%   data is a stprtool data type, containing the features/observed data and
%        the respective classes, in the format (data.X, data.y)
%   target_number_of_features is the desired number of features to select
%   forward is a parameter indicating the use of forward selection or
%           backward selection

    if (forward)
        direction = 'forward';
    else
        direction = 'backward';
    end

    if (iscell(varargin) && length(varargin)==1)
        %Convert to string because varargin is a cell array
        function_name = char(varargin(1));
    else
        function_name = 'my_fitlm';
    end
    
    opt = statset('UseParallel', true);
    indexes = sequentialfs(str2func(function_name), data.X', data.y,...
                           'cv', 'none', 'nullmodel', true,...
                           'direction', direction, 'options', opt,...
                           'nfeatures', target_number_of_features);
    data.X = data.X(indexes,:);
end

function dev = critfun(X,Y)
%FIXME: NOT WORKING WITH OUR DATA
    [~,dev] = glmfit(X,Y,'binomial');
end

function error = my_fitlm(X, Y)
    model = fitlm(X, Y);
    error = model.RMSE;
end