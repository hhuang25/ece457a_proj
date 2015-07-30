% for theta: 0 is right, 90 is down, 180 is left and 270 is up
function [result] = CameraScore(M, row, col, theta)
    [nrows, ncols] = size(M);
    V = zeros(nrows, ncols);
    for i = 1:nrows
        for j = 1:ncols
            if(i == row && j == col)
                V(i,j) = 0.0; 
            else
                element = M(i, j);
                [distance_camera, angle_camera] = distanceAndAngle(row,col,(i+0.5), (j+0.5));
                f_result = f(distance_camera);
                phi = getPhi(theta, angle_camera);
                g_result = g(phi);
                V(i, j) = g_result * f_result * element;
            end
        end    
    end
    result = V;
end
