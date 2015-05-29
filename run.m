%Add libsvm to Matlab's path
addpath('libsvm-3.20/matlab');

[sprt_data_original, sprt_data_undersample, sprt_train, sprt_test] = prepare_dataset();

%{
[data_fisher, indexes_fisher] = feature_selection(sprt_data, 'fisher', target_number_of_features);
%DECIDED TO STOP USING THIS -- [data_fs_fisher, indexes_fs_fisher] = feature_selection(sprt_data, 'fsfisher', target_number_of_features);
[data_auc, indexes_auc] = feature_selection(sprt_data, 'auc', target_number_of_features);
[data_mrmra, indexes_mrmra] = feature_selection(sprt_data, 'mrmra', target_number_of_features);
[data_mrmrm, indexes_mrmrm] = feature_selection(sprt_data, 'mrmrm', target_number_of_features);
%NOT WORKING WITH OUR DATA -- [data_sequential_fs, indexes_sequential_fs] = sequentialFs(sprt_data, target_number_of_features, 1, 'critfun');
%[data_sequential_fs, indexes_sequential_fs] = sequentialFs(sprt_data, target_number_of_features, 1, 'my_fitlm');
%}

%{
%Training and classifying with MATLAB's SVM Implementation
svm_model = train_svm(sprt_data.X(:,1:100)', sprt_data.y(1:100));
fprintf('Going to classify\n');
[labels, accuracy, posterior_probabilities] = classify_svm(svm_model, sprt_data.X', sprt_data.y);
accuracy

%Using LIBSVM implementation in MATLAB
svm_model2 = train_libsvm(sprt_data.X(:,1:100000)', sprt_data.y(1:100000));%This still runs in feasible time
fprintf('Going to classify\n');
[predicted_label, accuracy, decision_values] = classify_libsvm(svm_model2, sprt_data.X', double(sprt_data.y));
accuracy
%}