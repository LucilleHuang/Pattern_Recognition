close all;

PATH = "..\lab_2_data\lab2_3.mat";
data = importdata(PATH);
TESTS_TO_RUN = [2];
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
        prototypeMean = (prototypeA + prototypeB) / 2;
        xlimits = xlim; ylimits = ylim;
        y1 = prototypeMean(2) + boundarySlope * (xlimits(1) - prototypeMean(1));
        y2 = prototypeMean(2) + boundarySlope * (xlimits(2) - prototypeMean(1));
        plot([xlimits(1) xlimits(2)], [y1 y2], '--', 'Color', 'w');
        xlim([xlimits(1) xlimits(2)]); ylim([ylimits(1) ylimits(2)]);
        legend('\color{white}Class A', '\color{white}Class B', '','','');
    end
end

if sum(TESTS_TO_RUN == 2)
    NUM_CLASSIFIERS = 20;
    NUM_DISCRIMINANTS = [1 2 3 4 5];
    errorRates = nan(NUM_CLASSIFIERS, length(NUM_DISCRIMINANTS));
    for jIndex = 1:length(NUM_DISCRIMINANTS)
        j = NUM_DISCRIMINANTS(jIndex);
        for i = 1:NUM_CLASSIFIERS
            [classifierPrototypes, classified] = GetDiscriminantClassPrototypes(j, data.a, data.b);
            errorRates(i,jIndex) = sum(classified(:) == false) / numel(classified);
        end
    end

    figure; hold on;
    set(gca, 'Color', 'k');
    plot(NUM_DISCRIMINANTS, min(errorRates), '_', 'Color', 'white', 'MarkerSize', 30);
    plot(NUM_DISCRIMINANTS, mean(errorRates), 'x', 'Color', '#0AD3FF', 'MarkerSize', 15);
    plot(NUM_DISCRIMINANTS, max(errorRates), '_', 'Color', 'white', 'MarkerSize', 30);
    xticks(NUM_DISCRIMINANTS);
    xlim([0.5 5.5]);
    yticks(0:0.05:1);
    ylimits = ylim; ylim([-0.03 ylimits(2)]);
    set(gca, 'YGrid', 'on', 'XGrid', 'off', 'GridColor', 'white');
    legend('\color{white}Min/Max Error Rate', '\color{white}Mean Error Rate','');
    title('Extrema and Mean Error Rates of Learned Sequential Discriminants');
    xlabel('Linear discriminants per classifier');
    ylabel('Error rate [decimal]');

    figure; hold on;
    set(gca, 'Color', 'k');
    plot(NUM_DISCRIMINANTS, std(errorRates), 'x', 'Color', '#0AD3FF', 'MarkerSize', 15);
    xticks(NUM_DISCRIMINANTS);
    xlim([0.5 5.5]);
    yticks(0:0.005:0.25);
    set(gca, 'YGrid', 'on', 'XGrid', 'off', 'GridColor', 'white');
    title('Error Rate Standard Deviation of Learned Sequential Discriminants');
    xlabel('Linear discriminants per classifier');
    ylabel('Error rate standard deviation [decimal]');
end
