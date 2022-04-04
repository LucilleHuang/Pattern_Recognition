    close all;

PATH = "..\lab_2_data\lab2_1.mat";
TESTS_TO_RUN = [1,2,3,4];
RESOLUTION = 200;
data = importdata(PATH);

% Dataset Parameters
muA = 5; sigmaA = 1;
lambdaB = 1;

%%% 1. Parametric Estimation -- Gaussian %%%
if sum(TESTS_TO_RUN == 1)
    % Dataset a
    x = linspace(0, 10, RESOLUTION);
    samplePDF = GaussianEstimation1D(data.a, x);
    PlotPDFs(x, normpdf(x, muA, sigmaA), samplePDF, "Gaussian Parametric Estimation — Dataset A");
    % Dataset b
    x = linspace(-3, 5, RESOLUTION);
    samplePDF = GaussianEstimation1D(data.b, x);
    PlotPDFs(x, exppdf(x, 1/lambdaB), samplePDF, "Gaussian Parametric Estimation — Dataset B");
end

%%% 2. Parametric Estimation -- Exponential %%%
if sum(TESTS_TO_RUN == 2)
    % Dataset a
    x = linspace(-1, 11, RESOLUTION);
    samplePDF = ExponentialEstimation1D(data.a, x);
    PlotPDFs(x, normpdf(x, muA, sigmaA), samplePDF, "Exponential Parametric Estimation — Dataset A");
    % Dataset b
    x = linspace(-1, 5, RESOLUTION);
    samplePDF = ExponentialEstimation1D(data.b, x);
    PlotPDFs(x, exppdf(x, 1/lambdaB), samplePDF, "Exponential Parametric Estimation — Dataset B");
end

%%% 3. Parametric Estimation -- Uniform %%%
if sum(TESTS_TO_RUN == 3)
    % Dataset a
    x = linspace(0, 10, RESOLUTION);
    samplePDF = UniformEstimation1D(data.a, x);
    PlotPDFs(x, normpdf(x, muA, sigmaA), samplePDF, "Uniform Parametric Estimation — Dataset A");
    % Dataset b
    x = linspace(-1, 5, RESOLUTION);
    samplePDF = UniformEstimation1D(data.b, x);
    PlotPDFs(x, exppdf(x, 1/lambdaB), samplePDF, "Uniform Parametric Estimation — Dataset B");
end

%%% 4. Non-Parametric Estimation -- Gaussian %%%
H_PARAMETERS = [0.1, 0.4];
if sum(TESTS_TO_RUN == 4)
    for h = H_PARAMETERS
        % Dataset a
        x = linspace(0, 10, RESOLUTION);
        samplePDF = GaussianParzenEstimation1D(data.a, x, h);
        PlotPDFs(x, normpdf(x, muA, sigmaA), samplePDF, "Non-Parametric Estimation — Dataset A (Gaussian \sigma = " + num2str(h) + ")");
        % Dataset b
        x = linspace(-1, 5, RESOLUTION);
        samplePDF = GaussianParzenEstimation1D(data.b, x, h);
        PlotPDFs(x, exppdf(x, 1/lambdaB), samplePDF, "Non-Parametric Estimation — Dataset B (Gaussian \sigma = " + num2str(h) + ")");
    end
end