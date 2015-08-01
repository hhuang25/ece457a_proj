function [bestScore, bestCamList] = SA(Ti, alpha, Tf, iterPerT, M, CamList)
    % Ti - initial temperature
    % alpha - geometric coefficient
    % Tf - final temperature
    % iterPerT - iterations per temperature
    % M - matrix representing the room
    % CamList - initial list of cameras
    curr_T = Ti;
    [~,bestScore] = CameraScoresWithCamList(M, CamList);
    bestCamList = CamList;
    [nrows,ncols] = size(M);
    maxNoProgresslimit = 5;
    counter = 0;
    while curr_T >= Tf
        for i = 1:iterPerT
            [nCameras,~] = size(bestCamList);
            i_curr_cam = randi([1, nCameras]);
            new_x = randi([1, ncols]);
            new_y = randi([1, nrows]);
            new_CamList = bestCamList;
            new_deg = rand*360;
            new_CamList(i_curr_cam, 1) = new_y;
            new_CamList(i_curr_cam, 2) = new_x;
            new_CamList(i_curr_cam, 3) = new_deg;
            
            [~,score] = CameraScoresWithCamList(M, new_CamList);
            if (score >= bestScore)
                bestScore = score;
                bestCamList = new_CamList;
            else
                counter = counter + 1;
                diff = bestScore - score;
                r = rand;
                p = exp(-1*diff/curr_T);
                if (p > r)
                    bestScore = score;
                    bestCamList = new_CamList;
                end;
            end;
        end
        if (counter >= maxNoProgresslimit)
            counter = 0;
            curr_T = curr_T*alpha;
        end;
    end
end