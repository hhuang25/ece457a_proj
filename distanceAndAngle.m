% x and y coordinates of camera and current position
% row1 and col1 are the origin, row2 and col2 are destination
function [distance, angle] = distanceAndAngle(row1, col1, row2, col2)
    % distance in metres
    row1 = double(row1);
    row2 = double(row2);
    col1 = double(col1);
    col2 = double(col2);
    distance = sqrt((row2-row1)^2+(col2-col1)^2);
    angle = atan2d(row2-row1,col2-col1);
    if angle < 0
        angle = angle + 360;
    end
end
