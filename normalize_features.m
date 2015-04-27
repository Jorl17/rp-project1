function normalized_features = normalize_features(features)
    normalized_features = features;
    for i=1:size(normalized_features,2)
        normalized_features(:,i) = scalestd(normalized_features(:,i));
    end
end