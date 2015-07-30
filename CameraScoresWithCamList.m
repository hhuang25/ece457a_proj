function [result, score] = CameraScoresWithCamList(M, CamList)
    [nCameras,~] = size(CamList);
    [nrows,ncols] = size(M);
    V = zeros(nrows, ncols);
    for i = 1:nCameras
        x = CamList(i,1);
        y = CamList(i,2);
        theta = CamList(i,3);
        V1 = CameraScore(M, x, y, theta);
        [nrows1, ncols1] = size(V1);
        for j = 1:nrows1
            for k = 1:ncols1
                if (V1(j, k) > V(j, k))
                    V(j, k) = V1(j, k);
                end
            end    
        end
    end
    result = V;
    score = sum(result(:));
end
