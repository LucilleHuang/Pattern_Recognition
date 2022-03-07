function [meanDist] = findkNN(k, model, sample)
    kDist=Inf(1,k);
    for i = 1 : length(model)
        dist = sqrt((model(i,1)- sample(1))^2+(model(i,2)- sample(2))^2);
        for j = 1 : k
            if kDist(j)> dist
                for n = k:-1:j+1
                    kDist(n) = kDist(n-1);
                end
                kDist(j)=dist;
                break
            end
        end
    end
    meanDist = mean(kDist);
end 