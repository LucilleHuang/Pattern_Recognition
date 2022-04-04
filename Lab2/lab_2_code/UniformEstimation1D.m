% See https://www.statology.org/mle-uniform-distribution/
function samplePDF = UniformEstimation1D(data, x)
    samplePDF = unifpdf(x, min(data), max(data));
end