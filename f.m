function [ result ] = f( r )
    % distance in metres
    % r_0 is usually 16 mm
    % sigma_r ^2 is some constant
    sigma_r_sq = 10;
    result = 100*(r - 16/1000) / sigma_r_sq * exp(-(r - 16/1000)^2/(2*sigma_r_sq));
end
