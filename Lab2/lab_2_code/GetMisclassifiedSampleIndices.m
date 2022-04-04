function misclassifiedSampleIndices = GetMisclassifiedSampleIndices(data, meanA, meanB, expectedClass)
    misclassifiedSampleIndices = nan(length(data), 1);
    for i = 1:length(data)
        point = [data(i,1) data(i,2)];
        distanceA = pdist([point; meanA], 'euclidean');
        distanceB = pdist([point; meanB], 'euclidean');
        if lower(expectedClass) == 'a'
            if (distanceA > distanceB)
                misclassifiedSampleIndices(i) = i;
            end
        elseif lower(expectedClass) == 'b'
            if (distanceB > distanceA)
                misclassifiedSampleIndices(i) = i;
            end
        end
    end
    misclassifiedSampleIndices = misclassifiedSampleIndices(sum(isnan(misclassifiedSampleIndices),2)==0);
end
