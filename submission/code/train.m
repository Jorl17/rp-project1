function model = train(train_sprt_data, method, varargin)
    model.type =  method;
    if strcmp(method, 'knn')   
        [K] = args_with_default_values(varargin, 20);
        model.m = train_knn(train_sprt_data,K);
    elseif strcmp(method, 'fitctree')
        model.m = train_fitctree(train_sprt_data);
    elseif strcmp(method, 'fitrtree')
        model.m = train_fitrtree(train_sprt_data);
    elseif strcmp(method, 'libsvm')
        method = args_with_default_values(varargin, 0);%To be linear
        model.m = train_libsvm(train_sprt_data, method);
    elseif strcmp(method, 'naive_bayes')
        model.m = train_naive_bayes(train_sprt_data);
    elseif strcmp(method, 'svm')
        [val] = args_with_default_values(varargin, 0);%To be linear
        model.m = train_svm(train_sprt_data, val);
    end
end