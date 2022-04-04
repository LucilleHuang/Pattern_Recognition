function samplePDF = GaussianEstimation1D(data, x)
    variance = sum((data - mean(data)).^2) / length(data);
    samplePDF = normpdf(x, mean(data), sqrt(variance));
end