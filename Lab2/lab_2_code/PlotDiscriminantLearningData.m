function PlotDiscriminantLearningData(data)
    figure; hold on; grid on; axis equal;
    set(gca, 'Color', 'k');
    plot(data.a(:,1), data.a(:,2), '.', 'Color', '#0AD3FF');
    plot(data.b(:,1), data.b(:,2), '.', 'Color', '#FF3535');
    legend('\color{white}Class A', '\color{white}Class B');
end