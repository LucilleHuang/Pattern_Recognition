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

figure1Labels = ['A', 'B'];
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

% MAP Decision Boundary for Classes A/B
step = 0.05;
x1 = -4:step:22;
x2 = -4:step:22;
[X1, X2] = meshgrid(x1,x2);
grid = zeros(length(X2), length(X1));
meanA = transpose(classMeans('A'));
meanB = transpose(classMeans('B'));
covA = classCovariances('A');
covB = classCovariances('B');
points = [X1(:), X2(:)];
i = 1;
for r = 1:length(X1)
    for c = 1:length(X2)
        x = points(i,:).';
        left = exp(-0.5*transpose(x-meanA)*inv(covA)*(x-meanA));
        right = exp(-0.5*transpose(x-meanB)*inv(covB)*(x-meanB));
        if left > right
            grid(c,r) = 1;
        else
            grid(c,r) = 2;
        end
        i = i + 1;
    end
end

contour(x1, x2, grid,[1,2], 'Color', 'k');
title('MAP Decision Boundary for Classes A/B');
legend('Class A', '', '', 'Class B', '', '', '');

figure2Labels = ['C', 'D', 'E'];
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

step = 0.05;
x1 = -7:step:25;
x2 = -7:step:25;
[X1, X2] = meshgrid(x1,x2);
grid = zeros(length(X2), length(X1));
% MAP Decision Boundary for Classes C/D/E
total_size = classSizes('C') + classSizes('D') + classSizes('E');
points = [X1(:), X2(:)];
i = 1;
for r = 1:length(X1)
    for c = 1:length(X2)
        x = points(i,:).';
        % posterior C
        priorC = classSizes('C')/total_size;
        covarianceC = classCovariances('C');
        meanC = transpose(classMeans('C'));
        num = priorC*exp(-0.5*transpose(x-meanC)*inv(covarianceC)*(x-meanC));
        den = (2*pi)^1.5*sqrt(det(covarianceC));
        max_posterior = num/den;
        grid(c,r) = 1;
        % posterior D
        priorD = classSizes('D')/total_size;
        covarianceD = classCovariances('D');
        meanD = transpose(classMeans('D'));
        num = priorD*exp(-0.5*transpose(x-meanD)*inv(covarianceD)*(x-meanD));
        den = (2*pi)^1.5*sqrt(det(covarianceD));
        posteriorD = num/den;
        if posteriorD > max_posterior
            grid(c,r) = 2;
            max_posterior = posteriorD;
        end
        % posterior E
        priorE = classSizes('E')/total_size;
        covarianceE = classCovariances('E');
        meanE = transpose(classMeans('E'));
        num = priorE*exp(-0.5*transpose(x-meanE)*inv(covarianceE)*(x-meanE));
        den = (2*pi)^1.5*sqrt(det(covarianceE));
        posteriorE = num/den;
        if posteriorE > max_posterior
            grid(c,r) = 3;
            max_posterior = posteriorE;
        end
    i = i + 1;
    end
end
contour(x1, x2, grid,[1,2,3], 'Color', 'k');
legend('Class C', '', '', 'Class D', '', '', 'Class E', '', '', '');
xlabel('x_1');
ylabel('x_2');
title('MAP Decision Boundary for Classes C/D/E');

