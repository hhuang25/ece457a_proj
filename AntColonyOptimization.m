function [ResultingCamList, ScoreOfResultCamList, PheromoneDepositMatrixr] = AntColonyOptimization(M, NumAnts, NumCam, it)
    %Set Variables
    [nRow, nColumn] = size(M);
    TotalDegree = 360;
    VaryingDegree = 8;
    %Construct Pheromone Deposit
    PheromoneDepositMatrix = ones(nRow, nColumn, VaryingDegree);
    %Construct Value Matrix
    CostMatrix = zeros(nRow, nColumn, VaryingDegree);
    for i=1:nRow
        for j=1:nColumn
            for k=1:VaryingDegree
                CostMatrix(i,j,k) = MatrixSummation(CameraScore(M, i, j, (k-1)*TotalDegree/VaryingDegree));
            end
        end
    end
    %ACO
    for iteration=1:it
        %Construct Movement Record Matrix
        MovementRecordMatrix = zeros(nRow, nColumn, VaryingDegree);
        DeltaCostMatrix = zeros(nRow, nColumn, VaryingDegree);
        fprintf('Iteration: %d\n', iteration);
        for ant=1:NumAnts
            CamList = zeros(NumCam, 3);
            for camera=1:NumCam
                camPosition = CameraPlacement(PheromoneDepositMatrix, CostMatrix);
                MovementRecordMatrix(camPosition(1), camPosition(2), camPosition(3)) = MovementRecordMatrix(camPosition(1), camPosition(2), camPosition(3)) + 1;
                CamList(camera,:) = camPosition;
            end
            CamListEval = CamList;
            CamListEval(:,3) = CamListEval(:,3)*TotalDegree/VaryingDegree;
            [~, deltaCost] = CameraScoresWithCamList(M, CamListEval);
            for camera=1:NumCam
                DeltaCostMatrix(CamList(camera, 1), CamList(camera, 2), CamList(camera, 3)) = deltaCost;
            end
        end
        CostMatrix = CostMatrix + DeltaCostMatrix*5;
        PheromoneDepositMatrix = PheromoneDepositMatrix/5 + MovementRecordMatrix;
    end
    %Return Cam List
    ResultingCamList = zeros(NumCam, 3);
    PheromoneDepositMatrixr = PheromoneDepositMatrix;
    for camera=1:NumCam
        [~, loc] = max(PheromoneDepositMatrix(:));
        [R,C,T] = ind2sub([nRow,nColumn,VaryingDegree],loc);
        PheromoneDepositMatrix(R,C,T) = 0;
        ResultingCamList(camera,:) = [R,C,T*TotalDegree/VaryingDegree];
    end
    [~, ScoreOfResultCamList] = CameraScoresWithCamList(M, ResultingCamList);
end

function summation = MatrixSummation(M)
    summation = sum(M(:));
end

function [CamPos] = CameraPlacement(PheromoneDepositMatrix, CostMatrix)
    TotalProb = MatrixSummation(PheromoneDepositMatrix) + MatrixSummation(CostMatrix);
    pos = rand * TotalProb;
    [xMax, yMax, thetaMax] = size(CostMatrix);
    x = 1;
    y = 1;
    theta = 0;
    while pos > 0
        theta = theta + 1;
        if theta > thetaMax
            theta = 1;
            y = y + 1;
        end
        if y > yMax
            y = 1;
            x = x + 1;
        end
        if x > xMax
            msgID = 'MYFUN:incorrectSize';
            msg = 'x position is too large.';
            baseException = MException(msgID,msg);
            throw(baseException)
        end
        pos = pos - (PheromoneDepositMatrix(x, y, theta) + CostMatrix(x, y, theta));
    end
    CamPos = [x, y, theta];
end
