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
contourPoints = 100;
theta = linspace(0, 2*pi, contourPoints);

figure1Labels = ['A','B'];
figure;
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
    plot_ellipse(classMean(:,1), classMean(:,2), theta, sqrt(eigenvalues(1)), sqrt(eigenvalues(4)), classColor);

    plot(classMean(:,1), classMean(:,2), '*', 'Color', classColor);
end
xlabel('x_1');
ylabel('x_2');

% MED Decision Boundary for Classes A/B
xlimits = xlim;
x = linspace(xlimits(:,1), xlimits(:,2), 100);
y = -x + 20;
plot(x, y, 'Color', 'k'); % Hard-coded A/B decision boundary
xlim(xlimits);

figure2Labels = ['C','D','E'];
figure;
hold on;
axis equal;
for label = figure2Labels
    class = classes(label);
    classColor = classColors(label);
    plot(class(:,1), class(:,2), '.', 'Color', classColor);

    classMean = classMeans(label);
    classCov = classCovariances(label);
    [eigenvectors, eigenvalues] = eig(classCov);
    majorAxisVector = eigenvectors(:,1);
    theta = angle(majorAxisVector(1) + majorAxisVector(2)*1i);
    plot_ellipse(classMean(:,1), classMean(:,2), theta, sqrt(eigenvalues(1)), sqrt(eigenvalues(4)), classColor);

    plot(classMean(:,1), classMean(:,2), '*', 'Color', classColor);
end

% MED Decision Boundary for Classes C/D/E
ylimits = ylim;
x = zeros(100) + 10; y = linspace(10, ylimits(:,2), 100);
plot(x, y, 'Color', 'k'); % Hard-coded C/D decision boundary
ylim(ylimits);
xlimits = xlim;
x = linspace(xlimits(:,1), 10, 100); y = x;
plot(x, y, 'Color', 'k'); % Hard-coded C/E decision boundary
xlim(xlimits);
xlimits = xlim;
x = linspace(10, xlimits(:,2), 100); y = 20 - x;
plot(x, y, 'Color', 'k'); % Hard-coded D/E decision boundary
xlim(xlimits);

legend('Class C', '', '', 'Class D', '', '', 'Class E', '', '', '');

