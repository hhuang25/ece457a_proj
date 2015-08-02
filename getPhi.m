% calculates phi
function [phi] = getPhi(cameraPointingAngle, angleBetweenPoints)
    phi1 = abs(cameraPointingAngle - angleBetweenPoints);
    phi2 = abs(cameraPointingAngle-360 - angleBetweenPoints);
    phi3 = abs(cameraPointingAngle+360 - angleBetweenPoints);
    phi = min([phi1,phi2,phi3]);
end
