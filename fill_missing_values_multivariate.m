function outdata = fill_missing_values_multivariate(indata, method)
% FILL_MISSING_VALUES_MULTIVARIATE  Fills the missing values with a given
% method.
%   outdata = FILL_MISSING_VALUES(indata, method) reads the data in the
%   variable "indata" and applies a given method to fill its missing
%   values. The "method" parameter can have the following values:
%       -> 'linear', to fill the missing data by computing a multivariate
%                    linear interpolation
%       -> 'nearest', to perform a nearest neighbour interpolation of the
%                     missing data
%
    %FIXME: We can have this or interpolation or any other thing
    if ~exist('method', 'var')
        method = 'linear';%FIXME: CHANGE THIS
    end

    outdata = indata;

    %Get cols wihtout missing values
    indexes_without_missing = features_without_missing_values(indata);
    %Get cols with missing values
    indexes_missing = features_with_missing_values(indata);
    
    %Select only the collumns without missing data
    design_matrix = indata(:,indexes_without_missing);

    for j=indexes_missing
        
        %For each collumn with missing values we have to determine which
        %lines have missing values and which lines have not, discarding the
        %lines with missing values
        current_lines_missing = find(indata(:,j)==-999);      
        current_design_matrix = design_matrix;
        current_design_matrix(current_lines_missing,:) = [];
        current_observation_matrix = indata(:,j);
        current_observation_matrix(current_lines_missing) = [];
        
        %Call mvregress for the given feature
        [beta,Sigma,E,CovB,logL] = mvregress(current_design_matrix, current_observation_matrix);
        
        size(current_design_matrix)
        size(current_observation_matrix)
        size(beta)
        size(Sigma)
        size(E)
        fprintf('AAA\n');
        pause;
        
        %FIXME: We can have iterations where the number of missing values
        %in the current collumn is higher than the number of non-missing
        %values in that collumn. In that case we cannot apply the
        %regression like we are doing.... FIXME: SOLVE THIS FOR THE
        %MENTIONED SITUATIONS!!!!
        
        %{
        
        %Apply regression to the missing data and return it
        for i=1:length(current_lines_missing)
            %yi = xi1 * beta_1 + ... + x1p * beta_p + ei -- CONFIRM!
            
            
            yi = indata(current_lines_missing(i), indexes_without_missing) * beta + E(i);
            outdata(current_lines_missing(i), j) = yi;
        end
        %}
    end
end