function PlotPDFs(x, truePDF, samplePDF, title_)
    figure; grid on; hold on;
    plot(x, truePDF);
    plot(x, samplePDF);
    title(title_);
    legend('True PDF', 'Sample PDF');
    xlabel('x');
    ylabel('P(x)');
    xlim([min(x) max(x)]);
end