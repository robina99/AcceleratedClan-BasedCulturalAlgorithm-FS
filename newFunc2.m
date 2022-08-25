function [o1,o2] = newFunc2(p1,p2,featSize,X,T)

% structure of the offspring
indv.Position  = []; % t
indv.nfeat     = 0;  % the number of features in the individual solution
indv.accuracy  = []; % store the accruracy values for each class
indv.AUCval    = []; % the AUC values of the individual
indv.OPTROCPT  = []; % the TPR and FPR values 
indv.precision = []; % the precion value
indv.recall    = []; % the precion value
indv.F1        = []; % the F1 values 
indv.mse       = []; % define the mean squared error for each class
o1 = repmat(indv,1,1);
o2 = repmat(indv,1,1);
nCrpt = 3 ;  
crpt = sort(randperm(featSize, nCrpt));
 
        o1.Position = [p1.Position(1,(1:crpt(1,1))),p2.Position(1,(crpt(1,1)+1:(crpt(1,2)))),...
                p1.Position(1,(crpt(1,2)+1:(crpt(1,3)))),p1.Position(1,(crpt(1,3)+1:featSize))];
        o2.Position = [p2.Position(1,(1:crpt(1,1))),p1.Position(1,(crpt(1,1)+1:(crpt(1,2)))),...
                p2.Position(1,(crpt(1,2)+1:(crpt(1,3)))),p1.Position(1,(crpt(1,3)+1:featSize))];
        %o1.Position = a1;
        %o2.Position = a2;
        o1.nfeat = size(find(o1.Position == 1),2);
        o2.nfeat = size(find(o2.Position == 1),2);
        % When no features are selected
        if o1.nfeat == 0
            o1.accuracy = 0;
            o1.AUCval   = 0;
            o1.OPTROCPT = 0;
        else
            %assess the offsprings
            
            t = find(o1.Position ==1);
            X3 = X(:,(t));
           %X1 = X(:,(find(o1.Position ==1)));
           
            [o1.accuracy,o1.AUCval,o1.mse, ...
                    o1.OPTROCPT,o1.precision,o1.F1,o1.recall] = knn(X3, T );
        end
        % When no features are selected
        if o2.nfeat == 0
            o2.accuracy = 0;
            o2.AUCval   = 0;
            o2.OPTROCPT = 0;
        else  
            t = find(o2.Position ==1);
            X3 = X(:,(t)); 
           % X1 = X(:,(find(o2.Position ==1)));
            [o2.accuracy,o2.AUCval,o2.mse, ...
                    o2.OPTROCPT,o2.precision,o2.F1,o2.recall] = knn(X3, T );
        end
       