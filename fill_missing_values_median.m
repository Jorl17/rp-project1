function [ outdata ] = fill_missing_values_median( indata )
    num_features = size(indata,2);
    outdata = indata;
    for i=1:num_features-1
            feat = indata(:,i);
            feat(feat == -999) = median(feat(feat ~= -999));
            outdata(:,i) = feat;
    end
end