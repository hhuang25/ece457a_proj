function [camList, result] = TSCamPlacement(M, camList, maxTabuLen, iters)
    [nRows, nCols] = size(M);
    [numOfCams, ~] = size(camList);
    [~, currentScore] = CameraScoresWithCamList(M, camList);
    tabuList = containers.Map();
    bestSoFar = currentScore;
    tabuLen = int16(sqrt(nRows * nCols));
    offset = 4;
    
    % Generate candidate solutions based on neighborhood
    for nItrs = 1:iters
        candidates = [];
        
        for camNum = 1:numOfCams
            rowPos = camList(camNum, 1);
            colPos = camList(camNum, 2);
            angle = camList(camNum, 3);

            % Neighborhood is random camera movements UP/DOWN/LEFT/RIGHT
            % from each camera and random changes in the camera 
            % angle using offset
            for ii = -1:2:1
                camList(camNum, 1) = mod(rowPos + ii*randi(offset), nRows);
                if camList(camNum, 1) == 0
                    camList(camNum, 1) = nRows;
                end
                
                for n = -1:1
                    camList(camNum, 3) = computeAngle(angle, offset, n);
                    [~, score] = CameraScoresWithCamList(M, camList);
                    if not(camList(camNum, 1) == rowPos && camList(camNum, 3) == angle)
                        candidates = [candidates; [score, camNum, camList(camNum, 1), ...
                                      colPos, camList(camNum, 3)]];
                    end
                end
            end
            
            for ii = -1:2:1
                camList(camNum, 2) = mod(colPos + ii*randi(offset), nCols);
                if camList(camNum, 2) == 0
                    camList(camNum, 2) = nCols;
                end
                
                for n = -1:1
                    camList(camNum, 3) = computeAngle(angle, offset, n);
                    [~, score] = CameraScoresWithCamList(M, camList);
                    if not(camList(camNum, 2) == colPos && camList(camNum, 3) == angle)
                        candidates = [candidates; [score, camNum, rowPos, ...
                                      camList(camNum, 2), camList(camNum, 3)]];
                    end
                end
            end
            
            camList(camNum, 1) = rowPos;
            camList(camNum, 2) = colPos;
            camList(camNum, 3) = angle;
        end
        
        candidates = unique(candidates, 'rows');
        candidates = sortrows(candidates, -1);
        
        % Look at the best candidates first
        for ii = 1:size(candidates, 1)
            score = candidates(ii, 1);
            camera = candidates(ii, 2);
            rowPos = candidates(ii, 3);
            colPos = candidates(ii, 4);
            angle = candidates(ii, 5);
            
            key = strcat(int2str(rowPos),',',int2str(colPos), ...
                         ',',int2str(angle));
                
            if score > currentScore || not(isKey(tabuList, key)) || tabuList(key) == 0
                camList(camera, 1) = rowPos;
                camList(camera, 2) = colPos;
                camList(camera, 3) = angle;   
                
                % Decrement elements in tabu list
                tabus = keys(tabuList);
                for elem = 1:size(tabus, 2)
                    elemKey = char(tabus(elem));
                    value = tabuList(elemKey);
                    if value > 0
                        tabuList(elemKey) = value - 1;
                    end
                end
                
                % Adaptive tabu length
                if score > bestSoFar
                    tabuLen = 1;
                    bestSoFar = score;
                elseif score < currentScore && tabuLen < maxTabuLen
                    tabuLen = tabuLen + 1;
                elseif score > currentScore && tabuLen > 1
                    tabuLen = tabuLen - 1;
                end
                 
                % Update current solution and tabu list
                currentScore = score;
                tabuList(key) = tabuLen;         
                break;
            end
        end
    end
    
    result = currentScore;
end

function [angle] = computeAngle(angle, offset, index)
    angle = mod(angle + index*10*randi(offset), 360);
end