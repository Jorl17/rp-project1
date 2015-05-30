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

%Train and test a naive bayes classifier
bayes_model = train_naive_bayes(sprt_train);
predicted_values = classify_naive_bayes(bayes_model, sprt_test.X);

%{
%Train and test a fitctree classifier -- NOT ENTIRELY TESTED DUE TO
%PROBLEM IN PREPARE_DATASET()
fitctree_model = train_fitctree(sprt_train.X, sprt_train.y);
predicted_values = classify_tree(fitctree_model, sprt_test.X);
%}

%{
%Train and test a fitrtree classifier -- NOT ENTIRELY TESTED DUE TO
%PROBLEM IN PREPARE_DATASET()
fitrtree_model = train_fitrtree(sprt_train.X, sprt_train.y);
predicted_values = classify_tree(fitrtree_model, sprt_test.X);
%}

%{
%Training and classifying with MATLAB's SVM Implementation
svm_model = train_svm(sprt_train.X, sprt_train.y);
fprintf('Going to classify\n');
[labels, accuracy, posterior_probabilities] = classify_svm(svm_model, sprt_data.X, sprt_data.y);
accuracy

%Using LIBSVM implementation in MATLAB
fprintf('Going to train with libsvm\n');
svm_model2 = train_libsvm(sprt_train.X, sprt_train.y);
fprintf('Going to classify\n');
[predicted_label, accuracy, decision_values] = classify_libsvm(svm_model2, sprt_test.X, sprt_test.y);
accuracy
%}