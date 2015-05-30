function [FP, FN, accuracy, sensitivity, specificity, F1] = classifier_performance(predicted_y, true_y)
    if size(predicted_y) ~= size(true_y)
        predicted_y = predicted_y';
    end

    num = length(predicted_y);
    accuracy = sum(predicted_y == true_y) / num;
    FP = sum(predicted_y == 2 & true_y == 1) / num;
    FN = sum(predicted_y == 1 & true_y == 2) / num;
    TP = sum(predicted_y == 2 & true_y == 2) / num;
    TN = sum(predicted_y == 1 & true_y == 1) / num;
    
    sensitivity = TP / (TP + FN);
    specificity = TN / (TN + FP);
    
    beta = 1;
    F1 = (1 + beta^2) * TP / ((1+beta^2) * TP + beta^2 * FN + FP);
   
end