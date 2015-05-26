function [ balanced_dataset ] = balance_dataset( sprt_data, method )
    classes = unique(sprt_data.y);
    %FIXME: Should make sure there are only two classes
    indexes_1 = find(sprt_data.y == classes(1));
    indexes_2 = find(sprt_data.y == classes(2));
    indexes_1 = shuffle(indexes_1);
    indexes_2 = shuffle(indexes_2);
        
    if strcmp(method,'undersample')
             
        max_idx = min(length(indexes_1),length(indexes_2));
        balanced_dataset_idx = [ indexes_1(1:max_idx) ; indexes_2(1:max_idx) ];
    elseif strcmp(method,'oversample')
        diff = length(indexes_1) - length(indexes_2);
        if diff > 0
            indexes_2 = [indexes_2 ; indexes_2(1:abs(diff))];
        elseif diff < 0
            indexes_1 = [indexes_1 ; indexes_1(1:abs(diff))];
        end
        balanced_dataset_idx = [indexes_1 ; indexes_2];
    end
    
    if strcmp(method,'undersample') || strcmp(method,'oversample')
        data_x = sprt_data.X(:,balanced_dataset_idx)';
        data_y = sprt_data.y(balanced_dataset_idx);
        size(data_x)
        size(data_y)
        data = [data_x data_y];
        balanced_dataset = convert_to_sprt_data(data);
    end
end

