function [ result ] = f( r )
    % distance in metres
    % r_0 is usually 16 mm
    result = (r - 16/1000) / 25 * exp(-(r - 16/1000)^2/(2*25));
end
