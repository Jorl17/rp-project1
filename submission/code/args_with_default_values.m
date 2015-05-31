function [varargout] = args_with_default_values (args,varargin)
    nargs = length(varargin);
    varargout = cell(size(varargin));
    for i=1:nargs
        varargout{i}=arg_with_default_value(args,i,cell2mat(varargin(i)));
    end
end