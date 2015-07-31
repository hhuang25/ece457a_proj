function [ cameralist, score ] = GeneticAlgorithm( M, numCameras, init_crossover, init_mutation )
    [nrows, ncols] = size(M);
    population_number = 80;
    p_crossover = init_crossover;
    p_mutate = init_mutation;
    generations = 200;
    multigen_parents = 4;
    %viable_parents = round(population_number / 3);
    viable_parents = (population_number - multigen_parents);
    if mod(viable_parents,2) ~= 0
        viable_parents = viable_parents - 1;
    end
    population = zeros(population_number,numCameras,3);
    %generate random initial population
    for ii = 1 : population_number
        cameras = zeros(numCameras,3);
        for jj = 1 : numCameras
            % random row, col, angle b/w 0 and 359 with increment of 5
            camera_stat = [randi(nrows),randi(ncols),randi(72)*5-1];
            cameras(jj,:) = camera_stat;
        end
        population(ii,:,:) = cameras;  
    end
    scored_population = sortPopulation(M,population);
    current_highest = scored_population(1,2);
    %cameralist = scored_population(1:10,:);

    while generations > 0
        generations = generations - 1;
        %crossover on top viable parents
        new_population = zeros(population_number,numCameras,3);
        for ii = 1:2:viable_parents
            id_parent1 = scored_population(ii,1);
            id_parent2 = scored_population(ii+1,1);
            parent1 = squeeze(population(id_parent1,:,:));
            parent2 = squeeze(population(id_parent2,:,:));
            child1 = zeros(numCameras,3);
            child2 = zeros(numCameras,3);
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
                    child1(jj,3) = randi(randi(72)*5-1);
                    child2(jj,3) = randi(randi(72)*5-1);
                end
            end
            %new_population((ii-1)*2+1,:,:) = parent1;
            %new_population((ii-1)*2+2,:,:) = parent2;
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
            p_crossover = 0.95;
            p_mutate = 0.02;
        else
            p_crossover = init_crossover;
            p_mutate = init_mutation;
        end
        current_highest = scored_population(1,2);
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