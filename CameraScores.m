function [result] = CameraScores(M)
    [nrows, ncols] = size(M);
    nCameras = (nrows+1)*(ncols+1);
    V = zeros(nrows, ncols);
    for ii = 1:nCameras
        x = randi(ncols+1);
        y = randi(nrows+1);
        theta = randi(360);
        V1 = CameraScore(M, x, y, theta);
        [nrows1, ncols1] = size(V1);
        for jj = 1:nrows1
            for k = 1:ncols1
                if (V1(jj, k) > V(jj, k))
                    V(jj, k) = V1(jj, k);
                end
            end    
        end
    end
    result = V;
end
