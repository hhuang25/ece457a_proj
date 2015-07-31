function [result, score] = CameraScoresWithCamList(M, CamList)
    [nCameras,~] = size(CamList);
    [nrows,ncols] = size(M);
    V = zeros(nrows, ncols);
    for ii = 1:nCameras
        x = CamList(ii,1);
        y = CamList(ii,2);
        theta = CamList(ii,3);
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
    score = sum(result(:));
end
