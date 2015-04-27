function [ sprt_data ] = convert_to_sprt_data( data )
    sprt_data.X = data(:, 1:30)';
    sprt_data.y = data(:,31);
    sprt_data.dim = size(sprt_data.X, 1);
    sprt_data.num_data = size(sprt_data.X, 2);
    sprt_data.name = 'Higgs Data';
end