function samplePDF = GaussianParzenEstimation1D(data, x, h)
    samplePDF = zeros(size(x));
    for sample = data
        samplePDF = samplePDF + normpdf(x, sample, h);
    end
    samplePDF = samplePDF ./ length(data);  
end