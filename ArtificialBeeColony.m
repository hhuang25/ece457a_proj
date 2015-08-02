function [ cameralist, score ] = ArtificialBeeColony( M, numCameras, colony_size, abandon_limit, iterations )
    % default values
    if nargin == 4
        abandon_limit = 5;
        iterations = 100;
    elseif nargin == 2
        colony_size = 8;
        abandon_limit = 5;
        iterations = 100;
    end
    p_mutate = 0.1;
    p_separate = 0.9; % percentage of changing each values separately vs together
    [nrows, ncols] = size(M);
    abandon_values = zeros(1,colony_size);
    best_scores = zeros(1,colony_size);
    
    colony = zeros(colony_size,numCameras,3);
    %generate random initial colony
    for ii = 1 : colony_size
        cameras = zeros(numCameras,3);
        for jj = 1 : numCameras
            % random row, col, angle b/w 0 and 359 with increment of 5
            camera_stat = [randi(nrows),randi(ncols),randi(72)*5-5];
            cameras(jj,:) = camera_stat;
        end
        colony(ii,:,:) = cameras;  
    end
    
    while iterations > 0
        if mod(iterations,10) == 0
            fprintf('%d\n', iterations);
        elseif iterations < 10
            fprintf('%d ', iterations);
        end
        
        iterations = iterations - 1;
        %employee bees modify food and discover neighbouring food
        for ii = 1 : colony_size
            food_source = squeeze(colony(ii,:,:));
            initial_best_score = best_scores(1,ii);
            best_score = 0;
            current_score = 0;
            temp_best = food_source;
            for jj = 1 : numCameras
                possible_neighbour = food_source;
                % separate change vs combined change
                if rand < p_separate
                    if rand < p_mutate
                        temp = rand;
                        if temp < 0.2
                            possible_neighbour(jj,1) = randi(nrows);
                        elseif temp > 0.8
                            possible_neighbour(jj,2) = randi(ncols);
                        else
                            possible_neighbour(jj,3) = randi(72)*5-5;
                        end 
                        [~,current_score] = CameraScoresWithCamList(M,possible_neighbour);
                    end
                else
                    if rand < p_mutate
                        possible_neighbour(jj,1) = randi(nrows);
                        possible_neighbour(jj,2) = randi(ncols);
                        possible_neighbour(jj,3) = randi(72)*5-5;
                        [~,current_score] = CameraScoresWithCamList(M,possible_neighbour);
                    end
                end
                
                if current_score > best_score
                    %onlooker chooses nectar to target
                    best_score = current_score;
                    temp_best = possible_neighbour;
                end
            end
            food_source = temp_best;
            colony(ii,:,:) = food_source;
            if best_score > initial_best_score
                best_scores(1,ii) = best_score;
                abandon_values(1,ii) = 0;
                p_mutate = p_mutate *0.8;
            else
                abandon_values(1,ii) = abandon_values(1,ii)+1;
                p_mutate = p_mutate * 1.25;
                if abandon_values(1,ii) > abandon_limit
                    %employee becomes scout for new food source
                    for jj = 1 : numCameras
                        % random row, col, angle b/w 0 and 359 with increment of 5
                        camera_stat = [randi(nrows),randi(ncols),randi(72)*5-5];
                        cameras(jj,:) = camera_stat;
                    end
                    colony(ii,:,:) = cameras;
                    % adaptation to change abandon limit to prevent frequent abandons
                    abandon_values(1,ii) = 0;
                    abandon_limit = abandon_limit + 1;
                end
            end
        end
    end
    [max_val,max_index] = max(best_scores(:));
    cameralist = squeeze(colony(max_index,:,:));
    score = max_val;
end

