function [classifierPrototypes, classified] = GetDiscriminantClassPrototypes(numDiscriminants, dataA, dataB)
    classifierPrototypes = nan(numDiscriminants,2,2);
    misclassified = false(numDiscriminants,length(dataA),2);
    for j = 1:numDiscriminants
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
                    misclassified(j,misclassifiedBIndices,2) = true;
                end
                if isempty(misclassifiedBIndices)
                    for i = setdiff(1:length(dataA), misclassifiedAIndices)
                        dataA(i,:) = [nan nan];
                    end
                    dataA(any(isnan(dataA),2),:) = [];
                    misclassified(j,misclassifiedAIndices,1) = true;
                end
                classifierPrototypes(j,:,1) = prototypeA;
                classifierPrototypes(j,:,2) = prototypeB;
                break
            end
        end
    end
    classified = false(length(dataA),2);
    for i = 1:length(misclassified)
        pointA = misclassified(:,i,1);
        pointB = misclassified(:,i,2);
        for j = 1:numDiscriminants
            perfectlyClassifiedA = not(sum(misclassified(j,:,1)));
            perfectlyClassifiedB = not(sum(misclassified(j,:,2)));
            if perfectlyClassifiedA
                classified(:,1) = true;
                if not(pointB(j))
                    classified(i,2) = true;
                    break
                end
            end
            if perfectlyClassifiedB
                classified(:,2) = true;
                if not(pointA(j))
                    classified(i,1) = true;
                    break
                end
            end
        end
    end
end
