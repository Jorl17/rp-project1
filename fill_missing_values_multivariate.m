function outdata = fill_missing_values_multivariate(indata)
    total_lines = 1:size(indata, 1);
    %Get the lines with missing values
    lines_missing = features_with_missing_values(indata');
    %Get lines without missing values
    total_lines(lines_missing) = [];
    
    %Get cols wihtout missing values
    indexes = features_without_missing_values(indata);
    %Get cols with missing values
    indexes_missing = features_with_missing_values(indata);
   
    outdata = indata;
    
    indata_without_missing_values_x = indata(total_lines, indexes);

    for j=indexes_missing
        %Call mvregress for each feature
        [beta,Sigma,E,CovB,logL] = mvregress(indata_without_missing_values_x, indata(total_lines,j));
        
        %FIXME: We are having a warning here saying matrix is close to
        %singular or badly scaled and that could result in an inaccurate
        %result... See if we need to fix this!!!
        
        %Apply regression to the missing data and return it
        for i=1:size(lines_missing, 1)
            %yi = xi * beta + ei where xi is a vector
            yi = indata(lines_missing(i), indexes) * beta + E(i);
            outdata(lines_missing(i), j) = yi;
        end
    end
end