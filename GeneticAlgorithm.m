function [ cameralist, score ] = GeneticAlgorithm( M, numCameras, init_crossover, init_mutation, population_number, generations )
    % default values   
    if nargin == 4
        population_number = 40;
        generations = 300;
    elseif nargin == 2
        init_crossover = 0.9;
        init_mutation = 0.1;
        population_number = 40;
        generations = 300;
    elseif nargin == 1
        numCameras = 1;
        init_crossover = 0.9;
        init_mutation = 0.1;
        population_number = 40;
        generations = 300;
    end
    [nrows, ncols] = size(M);
    p_crossover = init_crossover;
    p_mutate = init_mutation;
    
    multigen_parents = 4;
    %current_gen_weight = [1:population_number].^2;
    viable_parents = int16((population_number - multigen_parents));
    if mod(viable_parents,2) ~= 0
        viable_parents = int16(viable_parents - 1);
        multigen_parents = multigen_parents + 1;
    end
    population = zeros(population_number,numCameras,3,'int16');
    %generate random initial population
    for ii = 1 : population_number
        cameras = zeros(numCameras,3);
        for jj = 1 : numCameras
            % random row, col, angle b/w 0 and 359 with increment of 5
            camera_stat = [randi(nrows),randi(ncols),randi(72)*5-5];
            cameras(jj,:) = camera_stat;
        end
        population(ii,:,:) = cameras;  
    end
    scored_population = sortPopulation(M,population);
    current_highest = scored_population(1,2);
    %cameralist = scored_population(1:10,:);

    while generations > 0
        if mod(generations,10) == 0
            fprintf('%d\n', generations);
        elseif generations < 10
            fprintf('%d ', generations);
        end
        
        generations = generations - 1;
        %crossover on top viable parents
        new_population = zeros(population_number,numCameras,3,'int16');
        for ii = 1:2:viable_parents
            id_parent1 = int16(scored_population(ii,1));
            id_parent2 = int16(scored_population(ii+1,1));
            parent1 = squeeze(population(id_parent1,:,:));
            parent2 = squeeze(population(id_parent2,:,:));
            child1 = zeros(numCameras,3,'int16');
            child2 = zeros(numCameras,3,'int16');
            for jj = 1 : numCameras
                % crossover on cameras
                if rand < p_crossover
                    child1(jj,:) = parent2(jj,:);
                    child2(jj,:) = parent1(jj,:);
                else
                    child1(jj,:) = parent2(jj,:);
                    child2(jj,:) = parent1(jj,:);
                end
                % mutation on each camera value (row, column, degree b/w 0 and
                % 359 with increment of 5
                if rand < p_mutate
                    child1(jj,1) = randi(nrows);
                    child2(jj,1) = randi(nrows);
                end
                if rand < p_mutate
                    child1(jj,2) = randi(ncols);
                    child2(jj,2) = randi(ncols);
                end
                if rand < p_mutate
                    child1(jj,3) = randi(72)*5-5;
                    child2(jj,3) = randi(72)*5-5;
                end
            end
            new_population((ii-1)*1+1,:,:) = child1;
            new_population((ii-1)*1+2,:,:) = child2;
        end
        for ii = 1 : multigen_parents
            new_population(viable_parents+ii,:,:) = squeeze(population(scored_population(ii,1),:,:));
        end
        %new_population(viable_parents*2+1:population_number,:,:) = ...
            %population(viable_parents+1:viable_parents+remaining_population,:,:);
        population = new_population;
        scored_population = sortPopulation(M,population);
        %adaptation of mutation and crossover probability
        if scored_population(1,2) > current_highest
            current_highest = scored_population(1,2);
            p_mutate = 0.02;
        else
            p_mutate = init_mutation;
        end
        
    end
    cameralist = squeeze(population(scored_population(1,1),:,:));
    [~,score] = CameraScoresWithCamList(M,cameralist);
end

% returns list of vectors, 1st number is camera number, 2nd number is score
function [result] = sortPopulation(M,population)
    [population_number,~,~] = size(population);
    population_scores = zeros(population_number,2);
    for ii = 1 : population_number
        population_scores(ii,1) = ii;
        [~,population_scores(ii,2)] = CameraScoresWithCamList(M,squeeze(population(ii,:,:)));
    end
    result = sortrows(population_scores,-2);
end