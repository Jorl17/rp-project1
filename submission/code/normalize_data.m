function normalized_data = normalize_data(features)
    normalized_data = features;
    
    %Don't normalize the last column (it's the label)
    for i=1:size(normalized_data,2)-1
        normalized_data(:,i) = scalestd(normalized_data(:,i));
    end
end