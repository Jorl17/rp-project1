function [output_args] = area_under_curve(input_args)
    
    %FIXME: DO DID FOR ALL THE FEATURES

    [FPR,TPR,T,AUC] = perfcurve(sprt_data.y, sprt_data.X(10,:), 1);
    AUC
    figure;
    hold on;
    plot(FPR,TPR);

end