% for theta: 0 is right, 90 is down, 180 is left and 270 is up
function [result] = CameraScore(M, row, col, theta)
    [nrows, ncols] = size(M);
    if row < 1 || col < 1 || row > nrows || col > ncols
        error('Invalid input: row %d, col %d for matrix with size %d by %d',row,col,size(M));
    end
    V = zeros(nrows, ncols);
    walls = [];
    for ii = 1:nrows
        for jj = 1:ncols
            if M(ii,jj) == 0
               wall = [ii , jj];
               walls = [walls;wall];
            end
        end
    end
    [wall_rows,wall_cols] = size(walls);
    % wallstats has distance, angle
    wall_stats = zeros(wall_rows,2);
    for ii = 1 : wall_rows
        [dist,ang] = distanceAndAngle(row,col,walls(ii,1)+0.5,walls(ii,2)+0.5);
        wall_stats(ii,1) = dist;
        wall_stats(ii,2) = ang;
    end
    
    for ii = 1:nrows
        for jj = 1:ncols
            if(ii == row && jj == col)
                V(ii,jj) = 0.0; 
            else
                element = M(ii, jj);
                % offset of 0.5 is used to center the square
                [distance_camera, angle_camera] = distanceAndAngle(row,col,double(ii+0.5), double(jj+0.5));
                if isBlocked(distance_camera,angle_camera,wall_stats) == 1
                    V(ii, jj) = 0.0;
                else
                    f_result = f(distance_camera);
                    phi = getPhi(theta, angle_camera);
                    g_result = g(double(phi));
                    V(ii, jj) = g_result * f_result * element;
                end
                
            end
        end    
    end
    result = V;
end

%function to check if a cell is blocked from seeing the camera by a wall
function result = isBlocked(distanceCamera, angleCamera, walls)
    result = 0;
    for ii = 1 : size(walls)
        angleDifference = abs(angleCamera - walls(ii,2));
        if distanceCamera > walls(ii,1) && angleDifference < 5
            result = 1;
        end
    end
end