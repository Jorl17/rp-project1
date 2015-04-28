function [ data, indexes ] = sequentialFs(data, target_number_of_features, forward, varargin)

    if (forward)
        direction = 'forward';
    else
        direction = 'backward';
    end

    if (iscell(varargin))
        %FIXME: Check for length
        function_name = varargin(1);
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
    [~,dev] = glmfit(X,Y,'binomial');
end

function error = my_fitlm(X, Y)
    model = fitlm(X, Y);
    error = model.RMSE;
end