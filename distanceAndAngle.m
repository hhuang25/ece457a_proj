% x and y coordinates of camera and current position
function [distance, angle] = distanceAndAngle(x1, y1, x2, y2)
    % distance in metres
    x = [x1,y1;x2,y2];
    distance = sqrt((x2-x1)^2+(y2-y1)^2);
    angle = atan2d(y2-y1,x2-x1);
end
