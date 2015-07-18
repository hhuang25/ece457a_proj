% calculates phi
function [phi] = getPhi(cameraPointingAngle, angleBetweenPoints)
    phi = abs(cameraPointingAngle - angleBetweenPoints);
end
