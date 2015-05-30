function sprt_data = feature_extraction_from_model(sprt_data, m)
    if strcmp(m.type, 'linproj')
        sprt_data = linproj(sprt_data, m.m);
        sprt_data.X = real(sprt_data.X);
    elseif strcmp(m.type, 'kernelproj')
        sprt_data = kernelproj(sprt_data, m.m);
    end
    
    sprt_data.num_data = size(sprt_data.X, 2);
    sprt_data.name = 'Higgs Data';
end