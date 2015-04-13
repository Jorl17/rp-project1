function [ret] = arg_with_default_value (args, index, default_value)
    nargs = length(args);
    if nargs >= index
        ret = cell2mat(args(index));
    else
        ret = default_value;
    end
end