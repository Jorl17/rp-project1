function [ train_data, test_data, validate_data ] = split_training_test_validate( sprt_data, train_pct, test_pct, validate_pct )
    [~,num_data] = size(sprt_data.X);    
    [train_idx,validate_idx,test_idx]=dividerand(num_data,train_pct,validate_pct,test_pct);
    
    train_data_x    = sprt_data.X(:,train_idx);
    train_data_y    = sprt_data.y(train_idx);
    validate_data_x = sprt_data.X(:,validate_idx);
    validate_data_y = sprt_data.y(validate_idx);
    test_data_x     = sprt_data.X(:,test_idx);
    test_data_y     = sprt_data.y(test_idx);
    
    train_data      = convert_to_sprt_data([train_data_x' train_data_y]);
    validate_data   = convert_to_sprt_data([validate_data_x' validate_data_y]);
    test_data       = convert_to_sprt_data([test_data_x' test_data_y]);
end

