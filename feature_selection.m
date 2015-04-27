function [ data, indexes ] = feature_selection(data, classes, method, target_number_of_features, varargin)
    if strcmp(method, 'fisher')
        %Filter Method
        indexes = fisher(data, classes);
        indexes = indexes(1:target_number_of_features);
        data = data(:,indexes);
        %FIXME: Adapt above to data.X and data.y (different dimensions)
    elseif strcmp(method, 'fsfisher')
        %Filter Method
        out = fsFisher(data, classes);
        indexes = out.fList(1:target_number_of_features);
        data = data(:,indexes);
        %FIXME: Adapt above to data.X and data.y (different dimensions)
    elseif strcmp(method, 'fskruskalwallis')
        out = fsKruskalWallis(data, classes);
        indexes = out.fList(1:target_number_of_features);
        data = data(:,indexes);
        %FIXME: Adapt above to data.X and data.y (different dimensions)
    elseif strcmp(method, 'corrcoef')
        [corrcoef_type, threshold] = args_with_default_values(varargin, 'exclude_high_correlation', 0.9);
        if strcmp(corrcoef_type, 'exclude_high_correlation')
            % Exclude highly correlated features (leave only one of them)
            % Note that we ignore target_number_of_features. This step only eliminates redundancy.            
            c = corrcoef(data.X');
            idx = find( abs(c) > threshold  & c ~= 1.0 );
            [~,idx]=ind2sub(size(c),idx);
            indexes = setdiff(1:data.dim, [1 2 6 4 2 11]);
            
            %Remember that data.X is transposed!
            data.X(idx,:)=[];                       
        elseif strcmp(corrcoef_type, 'include_high_correlation_with_class')
            
            %FIXME: Implement: if threshold == -1, then use the
            %target_number_of_features most discriminating features (even
            %if they suck. Currently we ignore target_number_of_features
            
            % Only include features with high class correlation
            d = [data.X' data.y];
            c = corrcoef(d);
            c = c(end,1:end-1);
            indexes= find( abs(c) > threshold );
            
            %Remember that data.X is transposed!
            data.X = data.X(indexes,:);
            %^Note that indexes from d and c are still valid in data.X
            %because only the last column is different (hence size changes
            %are irrelevant)
        end
        
    end
    
    %Re-convert (we changed dimensionality and a bunch of stuff)
    data = convert_to_sprt_data([data.X' data.y]);        
end