function outdata = fill_missing_values_design(indata, method,varargin)
% FILL_MISSING_VALUES_DESIGN Replaces missing values with estimations
% computed using either a multivariate regression or a neural network.
%   indata is a matrix MxN, with M the number of events and N the number of
%          features of each event, containing missing or invalid values
%          (represented by the value -999.0)
%   method is the desired method to used when computing the estimations for
%          the missing values

    %FIXME: We can have this or interpolation or any other thing
    if ~exist('method', 'var')
        method = 'mvregress';%FIXME: CHANGE THIS
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
        
        %FIXME: Store the training parameters/data/wtv
        
        %Call mvregress for the given feature
        if strcmp(method,'mvregress')
            [beta,~,~,~,~] = mvregress(current_design_matrix, current_observation_matrix);
            outdata(current_lines_missing, j) = indata(current_lines_missing, indexes_without_missing) * beta;
        elseif strcmp(method,'neuralnetwork')
            outdata(current_lines_missing, j) = fill_missing_values_neuralnetwork(current_design_matrix, current_observation_matrix, indata(current_lines_missing, indexes_without_missing), varargin{:});
        end    
    end
end