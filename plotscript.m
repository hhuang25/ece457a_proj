%declare matrix M
M = [1 1 1 1; 1 1 1 1; 1 1 2 3; 1 2 3 4];
[nrows ncols] = size(M);
%number of times the 3 configurations are repeatedly ran
test = 10;
%other parameters
w1 = 0.792;
c11 = 1;
c21 = 1;

w2 = 0.792;
c12 = 0.5;
c22 = 2;

w3 = 0.792;
c13 = 2;
c23 = 0.5;

particles = 20;
iteration = 100;

error = 0.001;

%temporary storage matrixes
fit1 = zeros(1,test);
it1 = zeros(1,test);
cam1 = zeros(particles,3);
fit2 = zeros(1,test);
it2 = zeros(1,test);
cam2 = zeros(particles,3);
fit3 = zeros(1,test);
it3 = zeros(1,test);
cam3 = zeros(particles,3);


for ii = 1:test
    [cam1, fit1(ii), it1(ii)] = CameraPSO(M, particles, w1, c11, c21, iteration, error);
end
for ii = 1:test
    [cam2, fit2(ii), it2(ii)] = CameraPSO(M, particles, w2, c12, c22, iteration, error);
end
for ii = 1:test
    [cam3, fit3(ii), it3(ii)] = CameraPSO(M, particles, w3, c13, c23, iteration, error);
end
figure
d1 = scatter(fit1, it1, 'g');
hold on
d2 = scatter(fit2, it2, 'r');
hold on
d3 = scatter(fit3, it3, 'b');
title('Graph of Iterations to Fitness value');
xlabel('Fitness Value');
ylabel('Iterations');
legend([d1, d2, d3],'M, 20, 0.792, 1, 1, 100, 0.001', 'M, 20, 0.792, 0.5, 2, 100, 0.001', 'M, 20, 0.792, 2, 0.5, 100, 0.001','Location','northwest');

figure
l1 = scatter(cam1(:,1), nrows-cam1(:,2), 'g.');
hold on
l2 = scatter(cam2(:,1), nrows-cam2(:,2), 'r.');
hold on
l3 = scatter(cam3(:,1), nrows-cam3(:,2), 'b.');
title('Scatter Graph of Camera location');
xlabel('x');
ylabel('y (inverted to match matrix)');
legend([l1, l2, l3],'M, 20, 0.792, 1, 1, 100, 0.001', 'M, 20, 0.792, 0.5, 2, 100, 0.001', 'M, 20, 0.792, 2, 0.5, 100, 0.001','Location','northwest');
cam1
cam2
cam3
