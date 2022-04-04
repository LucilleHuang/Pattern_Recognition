function [classifierPrototypes, misclassified] = GetDiscriminantClassPrototypes(n, dataA, dataB)
    perfectlySeparatedClasses = blanks(n);
    classifierPrototypes = nan(n,2,2);
    misclassified = false(n,length(dataA),2);
    for j = 1:n
        while 1
            prototypeA = dataA(randi(length(dataA)),:);
            prototypeB = dataB(randi(length(dataB)),:);
            misclassifiedAIndices = GetMisclassifiedSampleIndices(dataA, prototypeA, prototypeB, 'a');
            misclassifiedBIndices = GetMisclassifiedSampleIndices(dataB, prototypeA, prototypeB, 'b');
    
            if isempty(misclassifiedAIndices) || isempty(misclassifiedBIndices)
                if isempty(misclassifiedAIndices)
                    for i = setdiff(1:length(dataB), misclassifiedBIndices)
                        dataB(i,:) = [nan nan];
                    end
                    dataB(any(isnan(dataB),2),:) = [];
                    perfectlySeparatedClasses(j) = 'a';
                    misclassified(j,misclassifiedBIndices,2) = true;
                end
                if isempty(misclassifiedBIndices)
                    for i = setdiff(1:length(dataA), misclassifiedAIndices)
                        dataA(i,:) = [nan nan];
                    end
                    dataA(any(isnan(dataA),2),:) = [];
                    perfectlySeparatedClasses(j) = 'b';
                    misclassified(j,misclassifiedAIndices,2) = true;
                end
                classifierPrototypes(j,:,1) = prototypeA;
                classifierPrototypes(j,:,2) = prototypeB;
                break
            end
        end
    end
end