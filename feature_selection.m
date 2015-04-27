function [ data, indexes ] = feature_selection(data, classes, method, target_number_of_features, varargin)
    if strcmp(method, 'fisher')
        %Filter Method
        indexes = fisher(data, classes);
        indexes = indexes(1:target_number_of_features);
        data = data(:,indexes);
    elseif strcmp(method, 'fsfisher')
        %Filter Method
        out = fsFisher(data, classes);
        indexes = out.fList(1:target_number_of_features);
        data = data(:,indexes);
    elseif strcmp(method, 'fskruskalwallis')
        out = fsKruskalWallis(data, classes);
        indexes = out.fList(1:target_number_of_features);
        data = data(:,indexes);
    end
end