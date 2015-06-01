function [ data, indexes ] = mrmr_aditive( data, target_number_of_features )
%mRMR ADITIVE The MID scheme of minimum redundancy maximal relevance (mRMR) feature selection
%Taken and adapted from http://www.mathworks.com/matlabcentral/fileexchange/14608-mrmr-feature-selection--using-mutual-information-computation-
%
% Parameters:
%   data is a stprtool data type, containing the features/observed data and
%        the respective classes, in the format (data.X, data.y)
%   target_number_of_features is the desired number of features to select
%
% The data parameter is converted in the old "d" and "f" parameters while
% "target_number_of_features" is directly converted into the old "K"
% parameter (see next paragraph with Original Parameters information)
%
% Original Parameters:
%  d - a N*M matrix, indicating N samples, each having M dimensions. Must be integers.
%  f - a N*1 matrix (vector), indicating the class/category of the N samples. Must be categorical.
%  K - the number of features need to be selected
%
% Note: This version only supports discretized data, thus if you have continuous data in "d", you 
%       will need to discretize them first. This function needs the mutual information computation 
%       toolbox written by the same author, downloadable at the Matlab source codes exchange site. 
%       Also There are multiple newer versions on the Hanchuan Peng's web site 
%       (http://research.janelia.org/peng/proj/mRMR/index.htm).
%
% More information can be found in the following papers.
%
% H. Peng, F. Long, and C. Ding, 
%   "Feature selection based on mutual information: criteria 
%    of max-dependency, max-relevance, and min-redundancy,"
%   IEEE Transactions on Pattern Analysis and Machine Intelligence,
%   Vol. 27, No. 8, pp.1226-1238, 2005. 
%
% C. Ding, and H. Peng, 
%   "Minimum redundancy feature selection from microarray gene 
%    expression data," 
%    Journal of Bioinformatics and Computational Biology,
%   Vol. 3, No. 2, pp.185-205, 2005. 
%
% C. Ding, and H. Peng, 
%   "Minimum redundancy feature selection from microarray gene 
%    expression data," 
%   Proc. 2nd IEEE Computational Systems Bioinformatics Conference (CSB 2003),
%   pp.523-528, Stanford, CA, Aug, 2003.
%  
%
% By Hanchuan Peng (hanchuan.peng@gmail.com)
% April 16, 2003
%

    d = data.X';
    f = data.y;
    K = target_number_of_features;
    
    bdisp=0;

    nd = size(d,2);
    nc = size(d,1);

    t1=cputime;
    for i=1:nd, 
       t(i) = mutualinfo(d(:,i), f);
    end; 
    fprintf('calculate the marginal dmi costs %5.1fs.\n', cputime-t1);

    [tmp, idxs] = sort(-t);
    fea_base = idxs(1:K);

    fea(1) = idxs(1);

    KMAX = min(1000,nd); %500

    idxleft = idxs(2:KMAX);

    k=1;
%     if bdisp==1,
%     fprintf('k=1 cost_time=(N/A) cur_fea=%d #left_cand=%d\n', ...
%           fea(k), length(idxleft));
%     end;

    for k=2:K,
       t1=cputime;
       ncand = length(idxleft);
       curlastfea = length(fea);
       for i=1:ncand,
          t_mi(i) = mutualinfo(d(:,idxleft(i)), f); 
          mi_array(idxleft(i),curlastfea) = getmultimi(d(:,fea(curlastfea)), d(:,idxleft(i)));
          c_mi(i) = mean(mi_array(idxleft(i), :)); 
       end;

       [tmp, fea(k)] = max(t_mi(1:ncand) - c_mi(1:ncand));

       tmpidx = fea(k); fea(k) = idxleft(tmpidx); idxleft(tmpidx) = [];

%        if bdisp==1,
%        fprintf('k=%d cost_time=%5.4f cur_fea=%d #left_cand=%d\n', ...
%           k, cputime-t1, fea(k), length(idxleft));
%        end;
    end;
    
    indexes = fea;
    data.X = data.X(indexes,:);

    return;

end

%===================================== 
function c = getmultimi(da, dt) 
    for i=1:size(da,2), 
       c(i) = mutualinfo(da(:,i), dt);
    end; 
end
    