% phi is the angle between camera pointing direction minus
% the angle of the distanceAndAngle function 
function [result] = g(phi)
    % sigma_phi is some constant value
    sigma_phi = 10;
    result = 1/(sigma_phi*sqrt(2*pi))*exp(-phi^2/(2*sigma_phi^2));
end
