function [ Xout ] = scalestd( Xin )
    Xout=Xin-mean(Xin(:));
    Xout=Xout/std(Xout(:));
end

