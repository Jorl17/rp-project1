function [best_k,FP_m,FN_m,accuracy_m,sensitivity_m,specificity_m,F1_m] = find_best_k(sprt_train, sprt_test, varargin)
    [first,last,step]=args_with_default_values(varargin,5,150,5);
    num = (last-first)/step + 1;
    FP_m = zeros(num,1);
    FN_m = zeros(num,1);
    TP_m = zeros(num,1);
    TN_m = zeros(num,1);
    accuracy_m = zeros(num,1);
    sensitivity_m = zeros(num,1);
    specificity_m = zeros(num,1);
    F1_m = zeros(num,1);
    
    k = first;
    best_accuracy=-1;
    best_k=-1;
    for i=1:num
        model = train_knn(sprt_train,k);
        r = classify_knn(model,sprt_test);
        [FP, FN, TP, TN, accuracy, sensitivity, specificity, F1]=classifier_performance(r, sprt_test.y);
        FP_m(i) = FP;
        FN_m(i) = FN;
        TP_m(i) = TP;
        TN_m(i) = TN;
        accuracy_m(i) = accuracy;
        sensitivity_m(i) = sensitivity;
        specificity_m(i) = specificity;
        F1_m(i) = F1;
        
        if accuracy > best_accuracy
            best_k = k;
            best_accuracy = accuracy;
        end
        
        k = k + step;
    end
    
end