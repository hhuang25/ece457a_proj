function [result] = runtests()
% 15x15 for 10 cameras
CamList1 = [[1 1 360]; [4 1 135]; [3 4 45]; [2 5 111]; [1 2 23]; [2 2 77]; [1 5 32]; [5 1 65]; [5 4 20]; [4 4 1]];

M1 = ones(15, 15);
M1(10, 1) = 0;
M1(10, 2) = 0;

fprintf('\nACO 15x15 for 10 cameras\n');
t = cputime;
[anslist, ansScore, ansMat] = AntColonyOptimization(M1, 32, 10, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nABC 15x15 for 10 cameras\n');
t = cputime;
[anslist, ansScore] = ArtificialBeeColony(M1, 10, 6, 2, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nGA 15x15 for 10 cameras\n');
t = cputime;
[anslist, ansScore] = GeneticAlgorithm(M1, 10, 0.9, 0.1, 20, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nPSO 15x15 for 10 cameras\n');
t = cputime;
[anslist, ansScore, actual] = CameraPSO(M1, 10, 0.792, 1, 1, 100, 0.001);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);


% 25x25 for 10 cameras
M1 = ones(25, 25);

fprintf('\nACO 25x25 for 10 cameras\n');
t = cputime;
[anslist, ansScore, ansMat] = AntColonyOptimization(M1, 32, 10, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nABC 25x25 for 10 cameras\n');
t = cputime;
[anslist, ansScore] = ArtificialBeeColony(M1, 10, 6, 2, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nSA 25x25 for 10 cameras\n');
t = cputime;
[ansScore, anslist] = SA(62.5, 0.85, 1e-10, 2, M1, CamList1);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nPSO 25x25 for 10 cameras\n');
t = cputime;
[anslist, ansScore, actual] = CameraPSO(M1, 10, 0.792, 1, 1, 100, 0.001);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);


% 15x15 for 20 cameras
CamList1 = [[1 1 360]; [4 1 135]; [3 4 45]; [2 5 111]; [1 2 23]; [2 2 77]; [1 5 32]; [5 1 65]; [5 4 20]; [4 4 1]; [4 8 34]; [7 9 90]; [4 4 1]; [7 7 80]; [1 10 55]; [2 9 31]; [9 3 10]; [6 8 360]; [5 10 45]; [1 10 100]];

M1 = ones(15, 15);
M1(10, 1) = 0;
M1(10, 2) = 0;

fprintf('\nACO 15x15 for 20 cameras\n');
t = cputime;
[anslist, ansScore, ansMat] = AntColonyOptimization(M1, 32, 20, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nABC 15x15 for 20 cameras\n');
t = cputime;
[anslist, ansScore] = ArtificialBeeColony(M1, 20, 6, 2, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nSA 15x15 for 20 cameras\n');
t = cputime;
[ansScore, anslist] = SA(62.5, 0.85, 1e-10, 2, M1, CamList1);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nGA 15x15 for 20 cameras\n');
t = cputime;
[anslist, ansScore] = GeneticAlgorithm(M1, 20, 0.9, 0.1, 20, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nTS 15x15 for 20 cameras\n');
t = cputime;
[anslist, ansScore] = TSCamPlacement(M1, CamList1, 20, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nPSO 15x15 for 20 cameras\n');
t = cputime;
[anslist, ansScore, actual] = CameraPSO(M1, 20, 0.792, 1, 1, 100, 0.001);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);


% 15x15 for 30 cameras
CamList1 = [[1 1 360]; [4 1 135]; [3 4 45]; [2 5 111]; [1 2 23]; [2 2 77]; [1 5 32]; [5 1 65]; [5 4 20]; [4 4 1]; [4 8 34]; [7 9 90]; [4 4 1]; [7 7 80]; [1 10 55]; [2 9 31]; [9 3 10]; [6 8 360]; [5 10 45]; [1 10 100]; [9 9 34]; [9 7 99]; [1 2 67]; [5 7 80]; [10 10 55]; [9 2 31]; [3 9 10]; [8 6 360]; [10 5 45]; [10 1 100]];

M1 = ones(15, 15);
M1(10, 1) = 0;
M1(10, 2) = 0;

fprintf('\nACO 15x15 for 30 cameras\n');
t = cputime;
[anslist, ansScore, ansMat] = AntColonyOptimization(M1, 32, 30, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nABC 15x15 for 30 cameras\n');
t = cputime;
[anslist, ansScore] = ArtificialBeeColony(M1, 30, 6, 2, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nSA 15x15 for 30 cameras\n');
t = cputime;
[ansScore, anslist] = SA(62.5, 0.85, 1e-10, 2, M1, CamList1);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nGA 15x15 for 30 cameras\n');
t = cputime;
[anslist, ansScore] = GeneticAlgorithm(M1, 30, 0.9, 0.1, 20, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nTS 15x15 for 30 cameras\n');
t = cputime;
[anslist, ansScore] = TSCamPlacement(M1, CamList1, 20, 100);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);

fprintf('\nPSO 15x15 for 30 cameras\n');
t = cputime;
[anslist, ansScore, actual] = CameraPSO(M1, 30, 0.792, 1, 1, 100, 0.001);
e = cputime;
d = e - t;
fprintf('score = %f \n', ansScore);
fprintf('Start CPU time = %f \n', t);
fprintf('End CPU time = %f \n', e);
fprintf('CPU time = %f \n', d);
end