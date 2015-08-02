M = [1 1 1 1; 1 1 1 1; 1 1 2 3; 1 2 3 4];
test = 10;
fit1 = zeros(1,test);
it1 = zeros(1,test);
cam1 = zeros(20,3);
fit2 = zeros(1,test);
it2 = zeros(1,test);
cam2 = zeros(20,3);
fit3 = zeros(1,test);
it3 = zeros(1,test);
cam3 = zeros(20,3);


for ii = 1:test
    [cam1, fit1(ii), it1(ii)] = CameraPSO(M, 20, 0.792, 1, 1, 100, 0.001);
end
for ii = 1:test
    [cam2, fit2(ii), it2(ii)] = CameraPSO(M, 20, 0.792, 0.5, 2, 100, 0.001);
end
for ii = 1:test
    [cam3, fit3(ii), it3(ii)] = CameraPSO(M, 20, 0.792, 2, 0.5, 100, 0.001);
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
l1 = scatter(cam1(:,1), 4-cam1(:,2), 'g.');
hold on
l2 = scatter(cam2(:,1), 4-cam2(:,2), 'r.');
hold on
l3 = scatter(cam3(:,1), 4-cam3(:,2), 'b.');
title('Scatter Graph of Camera location');
xlabel('x');
ylabel('y (inverted to match matrix)');
