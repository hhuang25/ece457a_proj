% phi is the angle between camera pointing direction minus
% the angle of the distanceAndAngle function 
function [result] = g(phi)
    result = 1/(25*sqrt(2*pi))*exp(-phi^2/(2*25));
end
