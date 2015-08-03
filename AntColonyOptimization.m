function [ResultingCamList, ScoreOfResultCamList, PheromoneDepositMatrixr] = AntColonyOptimization(M, NumAnts, NumCam, it)
    %Set Variables
    [nRow, nColumn] = size(M);
    TotalDegree = 360;
    VaryingDegree = 8;
    EvaporationRate = 0.5;
    %Construct Pheromone Deposit
    PheromoneDepositMatrix = ones(nRow, nColumn, VaryingDegree);
    %Construct Value Matrix
    ValueMatrix = ones(nRow, nColumn, VaryingDegree);
    %ACO
    for iteration=1:it
        %Construct Movement Record Matrix
        DeltaValueMatrix = zeros(nRow, nColumn, VaryingDegree);
        fprintf('Iteration: %d\n', iteration);
        for ant=1:NumAnts
            CamList = zeros(NumCam, 3);
            for camera=1:NumCam
                camPosition = CameraPlacement(PheromoneDepositMatrix, ValueMatrix);
                CamList(camera,:) = camPosition;
            end
            CamListEval = CamList;
            CamListEval(:,3) = CamListEval(:,3)*TotalDegree/VaryingDegree;
            [~, deltaValue] = CameraScoresWithCamList(M, CamListEval);
            deltaValue = deltaValue*10;
            for camera=1:NumCam
                DeltaValueMatrix(CamList(camera, 1), CamList(camera, 2), CamList(camera, 3)) = ...
                    DeltaValueMatrix(CamList(camera, 1), CamList(camera, 2), CamList(camera, 3)) + deltaValue/NumCam;
            end
        end
        ValueMatrix = ValueMatrix + DeltaValueMatrix;
        PheromoneDepositMatrix = PheromoneDepositMatrix*EvaporationRate + DeltaValueMatrix;
    end
    %Return Cam List
    ResultingCamList = zeros(NumCam, 3);
    PheromoneDepositMatrixr = PheromoneDepositMatrix;
    for camera=1:NumCam
        [~, loc] = max(PheromoneDepositMatrix(:));
        [R,C,T] = ind2sub([nRow,nColumn,VaryingDegree],loc);
        PheromoneDepositMatrix(R,C,T) = 0;
        ResultingCamList(camera,:) = [R,C,(T-1)*TotalDegree/VaryingDegree];
    end
    [~, ScoreOfResultCamList] = CameraScoresWithCamList(M, ResultingCamList);
end

function summation = MatrixSummation(M)
    summation = sum(M(:));
end

function [CamPos] = CameraPlacement(PheromoneDepositMatrix, ValueMatrix)
    TotMat = (PheromoneDepositMatrix.*ValueMatrix);
    TotalProb = MatrixSummation(TotMat)^2;
    pos = rand * TotalProb;
    [xMax, yMax, thetaMax] = size(ValueMatrix);
    for x=1:xMax
        for y=1:yMax
            for theta=1:thetaMax
                CamPos = [x, y, theta];
                pos = pos - (TotMat(x, y, theta))^0.5;
                if pos < 0
                    return;
                end
            end
        end
    end
end
