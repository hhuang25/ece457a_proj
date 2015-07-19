function [result] = CameraScore(M, x, y, theta)
    [nrows, ncols] = size(M);
    V = zeros(nrows, ncols);
    
    for i = 1:ncols
        for j = 1:nrows
            if (i~=x && j~=y)
                element = M(i,j);
                [distance_camera, angle_camera] = distanceAndAngle(x, y, i, j);
                f_result = f(distance_camera);
                phi = getPhi(theta, angle_camera);
                g_result = g(phi);
                V(i,j) = g_result * f_result * element;
            end
        end    
    end

    result = sum(sum(V));
end
