target_number_features = 2;
[~, higgs_data] = load_dataset();
higgs_data = fill_missing_values(higgs_data, 'mean');
sprt_data = convert_to_sprt_data(higgs_data);
% [data_fisher, indexes_fisher] = fisher(sprt_data, target_number_features);
% [data_fs_fisher, indexes_fs_fisher] = fsFisher(sprt_data, target_number_features);

%{
model_data = fld(sprt_data);
[y_pred,dfce] = linclass(sprt_data.X,model_data);
[FP, FN] = roc(dfce, sprt_data.y);
figure;
hold on;
plot(FP,1-FN);
%}

[FP, FN] = roc(sprt_data.X(10,:), sprt_data.y);
figure;
hold on;
plot(FP,1-FN);

