function [ data ] = feature_extraction(data, method, target_number_of_features, varargin)
    if strcmp(method, 'pca')
        m = pca(data.X, target_number_of_features);
        data = linproj(data, m);
    elseif strcmp(method, 'lda')
        m = lda(data, target_number_of_features);
        data = linproj(data, m);
        data.X = real(data.X);
    elseif strcmp(method, 'kpca')
        %Note: KPCA just blows up my memory. Greedy KPCA too.
        %see help kernel for more kernel types (default was linear)
        [kernel_type, kernel_argument] = args_with_default_values(varargin, 'rbf', 1);
        options.ker = kernel_type;
        options.arg = kernel_argument;
        options.new_dim = target_number_of_features;
        %m = greedykpca(data.X, options);        
        m = kpca(data.X, options);        
        %data.X = kpcarec( X, m );
        data = kernelproj(data, m);
    elseif strcmp(method, 'gda')
        %Note: GDA just blows up my memory.
        %see help kernel for more kernel types (default was linear)
        [kernel_type, kernel_argument] = args_with_default_values(varargin, 'rbf', 1);
        options.ker = kernel_type;
        options.arg = kernel_argument;
        options.new_dim = target_number_of_features;
        m = gda(data, options);
        data = kernelproj( data, m );        
    end
    data.num_data = size(data.X, 2);
    data.name = 'Higgs Data';
end