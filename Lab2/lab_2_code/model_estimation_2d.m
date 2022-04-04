close all;

PATH = "..\lab_2_data\lab2_2.mat";
TESTS_TO_RUN = [1,2];
RESOLUTION = 100;
STEP_SIZE = 2;
PARZEN_SIGMA = 20;
data = importdata(PATH);

%%% 1. Parametric Estimation -- Gaussian %%%
if sum(TESTS_TO_RUN == 1)
    PlotLearningData(data);

    % Dataset a
    meanA = mean(data.al);
    covA = cov(data.al);
    % Dataset b
    meanB = mean(data.bl);
    covB = cov(data.bl);
    % Dataset c
    meanC = mean(data.cl);
    covC = cov(data.cl);

    [X1, X2] = meshgrid(linspace(0, 450, RESOLUTION));
    classifiedPoints = zeros(size(X1));
    for index = 1:numel(X1)
        point = [X1(index), X2(index)];
        pA = mvnpdf(point, meanA, covA);
        pB = mvnpdf(point, meanB, covB);
        pC = mvnpdf(point, meanC, covC); 
        if pA > pB && pA > pC
            classifiedPoints(index) = 1;
        elseif pB > pC
            classifiedPoints(index) = 2;
        else
            classifiedPoints(index) = 3;
        end
    end

    contour(X1, X2, classifiedPoints, [1,2,3], 'Color', 'w');
    legend('\color{white}Class A', '\color{white}Class B','\color{white}Class C');
end

%%% 2. Non-Parametric Estimation -- Gaussian %%%
if sum(TESTS_TO_RUN == 2)
    PlotLearningData(data);

    res = [STEP_SIZE 0 0 450 450];
    [samplePdfA, X1, X2] = parzen(data.al, res, PARZEN_SIGMA);
    [samplePdfB, ~, ~] = parzen(data.bl, res, PARZEN_SIGMA);
    [samplePdfC, ~, ~] = parzen(data.cl, res, PARZEN_SIGMA);

    classifiedPoints = zeros(size(samplePdfA));
    for index = 1:numel(samplePdfA)
        pA = samplePdfA(index);
        pB = samplePdfB(index);
        pC = samplePdfC(index);
        if pA > pB && pA > pC
            classifiedPoints(index) = 1;
        elseif pB > pC
            classifiedPoints(index) = 2;
        else
            classifiedPoints(index) = 3;
        end
    end

    contour(X1, X2, classifiedPoints, [1,2,3], 'Color', 'w');
    legend('\color{white}Class A', '\color{white}Class B','\color{white}Class C');
end