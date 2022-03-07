close all;
clear all;
clc;

classLabels = {'A', 'B', 'C', 'D', 'E'};
classSizes = containers.Map(classLabels, {200, 200, 100, 200, 150});
classMeans = containers.Map(classLabels, {[5 10], [10 15], [5 10], [15 10], [10 5]});
classCovariances = containers.Map(classLabels, {[8 0;0 4], [8 0;0 4], [8 4;4 40], [8 0;0 8], [10 -5;-5 20]});
classColors = containers.Map(classLabels, {'#0072BD', '#D95319', '#EDB120', '#7E2F8E', '#77AC30'});

rng(1); % Make the samples consistent for every run
classes = containers.Map();
for label = classLabels
    labelChar = char(label);
    classes(labelChar) = randn(classSizes(labelChar),2)*chol(classCovariances(labelChar)) + classMeans(labelChar);
end

test_points = containers.Map();
for label = classLabels
    labelChar = char(label);
    test_points(labelChar) = randn(classSizes(labelChar),2)*chol(classCovariances(labelChar)) + classMeans(labelChar);
end

contourPoints = 100;
theta = linspace(0, 2*pi, contourPoints);

figure1Labels = ['A','B'];
subplot(1,2,1);
hold on;
axis equal;
for label = figure1Labels
    class = classes(label);
    classColor = classColors(label);
    plot(class(:,1), class(:,2), '.', 'Color', classColor);

    classMean = classMeans(label);
    classCov = classCovariances(label);
    [eigenvectors, eigenvalues] = eig(classCov);
    majorAxisVector = eigenvectors(:,1);
    theta = angle(majorAxisVector(1) + majorAxisVector(2)*1i);
%     plot_ellipse(classMean(:,1), classMean(:,2), theta, sqrt(eigenvalues(1)), sqrt(eigenvalues(4)), classColor);

    plot(classMean(:,1), classMean(:,2), '*', 'Color', classColor);
end
xlabel('x_1');
ylabel('x_2');

%% NN Decision Boundary for Classes A/B
step = 0.05;
start_pt = -4;
end_pt = 22;
x1 = start_pt:step:end_pt;
x2 = start_pt:step:end_pt;
[X1, X2] = meshgrid(x1,x2);
grid = zeros(length(X2), length(X1));
points = [X1(:), X2(:)];
i = 1;
for r = 1:length(X1)
    for c = 1:length(X2)
        sample = points(i,:);
        dist_1 = findkNN(1, classes('A'), sample);
        dist_2 = findkNN(1, classes('B'), sample);
        if dist_2 > dist_1
            grid(c,r) = 1;
        else
            grid(c,r) = 2;
        end
        i = i + 1;
    end
end

contour(x1, x2, grid,[1,2], 'Color', 'k');
sgtitle('NN Decision Boundary for Classes A/B');
legend('Class A', '', 'Class B', '', '', '');

subplot(1,2,2);
hold on;
imagesc(x1, x2, grid);
colormap('jet');
contour(x1, x2, grid, 'Color', 'k');
xlabel('x_1');
ylabel('x_2');
axis equal

%% NN Confusion Matrix for Classes A/B
confusionmat = zeros(2,2);
figure1Labels = ['A','B'];
i = 1;
for label = figure1Labels
    points = test_points(label);
    for j = 1:length(points)
        sample = points(j,:);
        dist_1 = findkNN(1, classes('A'), sample);
        dist_2 = findkNN(1, classes('B'), sample);
        if dist_2 > dist_1
            confusionmat(i,1)=confusionmat(i,1)+1;
        else
            confusionmat(i,2)=confusionmat(i,2)+1;
        end
    end
    i = i + 1;
end

confusionmat
I = eye(2);
error = sum(confusionmat-confusionmat.*I, 'all');
error_rate = error/sum(confusionmat,'all')

%% NN Decision Boundary for Classes C/D/E -- not finished beyond this line
step = 0.05;
start_pt = -4;
end_pt = 22;
x1 = start_pt:step:end_pt;
x2 = start_pt:step:end_pt;
[X1, X2] = meshgrid(x1,x2);
grid = zeros(length(X2), length(X1));
points = [X1(:), X2(:)];
i = 1;
figure2Labels = ['C','D','E'];
dist=zeros(1,3);
for r = 1:length(X1)
    for c = 1:length(X2)
        sample = points(i,:);
        for label = figure1Labels
            dist(label) = findkNN(1, classes(label), sample);
        end
        min_dist = min(dist);
        if dist_1 == min_dist
            grid(c,r) = 1;
        elseif dist_2 == min_dist
            grid(c,r) = 2;
        else
            grid(c,r) = 3;
        end
        i = i + 1;
    end
end

contour(x1, x2, grid,[1,2], 'Color', 'k');
sgtitle('NN Decision Boundary for Classes A/B');
legend('Class A', '', 'Class B', '', '', '');

subplot(1,2,2);
hold on;
imagesc(x1, x2, grid);
colormap('jet');
contour(x1, x2, grid, 'Color', 'k');
xlabel('x_1');
ylabel('x_2');
axis equal

%% NN Confusion Matrix for Classes C/D/E
confusionmat = zeros(2,2);
figure1Labels = ['A','B'];
i = 1;
for label = figure1Labels
    points = test_points(label);
    for j = 1:length(points)
        sample = points(j,:);
        dist_1 = findkNN(1, classes('A'), sample);
        dist_2 = findkNN(1, classes('B'), sample);
        if dist_2 > dist_1
            confusionmat(i,1)=confusionmat(i,1)+1;
        else
            confusionmat(i,2)=confusionmat(i,2)+1;
        end
    end
    i = i + 1;
end

confusionmat
I = eye(2);
error = sum(confusionmat-confusionmat.*I, 'all');
error_rate = error/sum(confusionmat,'all')
