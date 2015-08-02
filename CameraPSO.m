%M is a matrix containing the mapping
%n is the number of particles
%w is the inertial weight
%c1 and c2 are weights given to personal and global best
%iterations is the number of iterations
%error is error margin criteria
%the algorithm assumes an initial particle velocity of 0 (at rest)
function [CamResult, FitnessOutput, ActualIterations] = CameraPSO(M, n, w, c1, c2, iterations, error)
    %enforce minimum for number of particles to 5
    if n<5
        n = 5;
    end
    %get size of matrix as bounds for particles to be initialized
    [nrows,ncols] = size(M);
    %initialize matrix which will contain random particles in bound, each
    %particle contains 3 parameters (columns)
    CamList = zeros(n,3);
    %initialize velocity matrixes
    v = zeros(n,3);
    %pbest stores the best personal fitness particle positions
    pbest = zeros(n,3);
    %pbestfitness fitness stores the best personal fitness values
    tempfitness = zeros(1,n);
    pbestfitness = zeros(1,n);
    %gbest stores the best global fitness particle position
    gbest = [0 0 0];
    %gbestfitness stores the best global fitness value
    gbestfitness = 0;
    %no localbest is currently used
    %Initialize a Fitness value\
    FitnessOutput = 0;
    %Fitness array used for error checking
    Fitness = zeros(1,iterations+1);
    %Initialize iterations counter
    ActualIterations = 0;
    
    %generate random starting locations and angle for each particle and
    %populate matrix
    rng shuffle;
    for ii = 1:n
        %x coordinate
        CamList(ii, 1) = (ncols).*rand(1);
        %y coordinate
        CamList(ii, 2) = (nrows).*rand(1);
        %theta
        CamList(ii, 3) = (360).*rand(1);
    end
    
    %minimum error criteria is very vague
    for jj = 1:iterations
        %main fitness calculation loop
        for iii = 1:n
            %calculate fitness value for each particle
            resultMatrix = CameraScoresWithCamList(M, CamList(iii,:));
            result = sum(resultMatrix(:));
            tempfitness(iii) = result;
            %if this is a new personal best, set current values as new pbest
            if(pbestfitness(iii) < result)
                pbestfitness(iii) = tempfitness(iii);
                pbest(iii,:) = CamList(iii,:);
                %if new global best, sets gbest
                if(gbestfitness < result)
                    gbestfitness = tempfitness(iii);
                    gbest = CamList(iii,:);
                end
            end 
        end

        %tenative break condition, if error margin is very small
        if(abs(Fitness(jj) - sum(pbestfitness))<error)
            CamResult = CamList;
            break    
        end
        %record of total fitness for error checking
        Fitness(jj+1) = sum(tempfitness);
        %assigns previous average total fitness value
        FitnessOutput = sum(tempfitness)/n;
        
        %calculate velocity
        for iiii = 1:n
            v(iiii,:) = w*v(iiii,:)+ c1*rand()*(pbest(iiii,:)-CamList(iiii,:))+c2*rand()*(gbest-CamList(iiii,:));
            CamList(iiii,:) = CamList(iiii,:) + v(iiii,:);
            %corrects positions if going out of bounds
            CamList = max(CamList, 0);
            CamList(:,1) = min(CamList(:,1), ncols);
            CamList(:,2) = min(CamList(:,2), nrows);
            CamList(:,3) = min(CamList(:,3), 360);
        end
        ActualIterations = ActualIterations+ 1;
        CamResult = CamList;
    end
end
