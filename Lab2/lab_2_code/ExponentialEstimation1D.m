% See https://www.wikiwand.com/en/Exponential_distribution#/Parameter_estimation
function samplePDF = ExponentialEstimation1D(data, x)
    samplePDF = exppdf(x, mean(data));
end