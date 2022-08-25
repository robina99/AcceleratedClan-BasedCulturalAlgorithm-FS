function [popdata] = newFunc(popdata,lbest,X,T)

  featSize    = size(X,2);
  cProb = 0.2; % probability of change
  nChange  = round(cProb*featSize); % number of features changed

            if (popdata.accuracy < lbest)                 
                %apply change operator (flip the values at the gene location)%                 
                 f = randperm(featSize, nChange);
                for i=1:size(f,2)
                   popdata.Position(f(i)) = mod(( popdata.Position(f(i)))+1,2);
                end
                f1 = find(popdata.Position ==1);
                popdata.nfeat = size(f1,2);
                X1 = X(:,(f1));
                %
                [popdata.accuracy, popdata.AUCval,popdata.mse,...
                    popdata.OPTROCPT,popdata.precision,popdata.F1,popdata.recall ] = knn(X1,T);
            end

end
                     