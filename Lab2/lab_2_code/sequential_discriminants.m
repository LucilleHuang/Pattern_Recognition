close all;

PATH = "..\lab_2_data\lab2_3.mat";
data = importdata(PATH);
TESTS_TO_RUN = [1];
% rng(0, 'twister');

%%% Learn 3 sequential classifiers and plot %%%
if sum(TESTS_TO_RUN == 1)
    [classifierPrototypes, ~] = GetDiscriminantClassPrototypes(3, data.a, data.b);
    figure('Units','Normalized','OuterPosition',[0 0 1 1]); 
    for j = 1:length(classifierPrototypes)
        subplot(1,3,j);
        hold on; grid on; axis equal;
        set(gca, 'Color', 'k');
        plot(data.a(:,1), data.a(:,2), '.', 'Color', '#0AD3FF');
        plot(data.b(:,1), data.b(:,2), '.', 'Color', '#FF3535');
        legend('\color{white}Class A', '\color{white}Class B');
        
        prototypeA = classifierPrototypes(j,:,1);
        prototypeB = classifierPrototypes(j,:,2);
        plot(prototypeA(1), prototypeA(2), 'x', 'Color', 'w');
        plot(prototypeB(1), prototypeB(2), 'x', 'Color', 'w');
        diff = prototypeA - prototypeB;
        boundarySlope = diff(1) / -diff(2);
        mean = (prototypeA + prototypeB) / 2;
        xlimits = xlim; ylimits = ylim;
        y1 = mean(2) + boundarySlope * (xlimits(1) - mean(1));
        y2 = mean(2) + boundarySlope * (xlimits(2) - mean(1));
        plot([xlimits(1) xlimits(2)], [y1 y2], '--', 'Color', 'w');
        xlim([xlimits(1) xlimits(2)]); ylim([ylimits(1) ylimits(2)]);
        legend('\color{white}Class A', '\color{white}Class B', '','','');
    end
end

if sum(TESTS_TO_RUN == 2)
    [classifierPrototypes, misclassified] = GetDiscriminantClassPrototypes(NUM_DISCRIMINANTS, data.a, data.b);
end
