function PlotLearningData(data)
    figure; hold on; grid on; axis equal;
    set(gca, 'Color', 'k');
    plot(data.al(:,1), data.al(:,2), '.', 'Color', '#0AD3FF');
    plot(data.bl(:,1), data.bl(:,2), '.', 'Color', '#FF3535');
    plot(data.cl(:,1), data.cl(:,2), '.', 'Color', '#FFF200');
end