function [ accuracy,  aucValues, msError, OPTROCPT,precision, f1,recall] = knn(X,T)

 

nSample = size(T,1);  % determine the sample size of the data
k = 10;

% initialise the holding arrays
[accuracyM,aucValuesM,msErrorM ,precisionM, F1m ,recallM ] = deal(zeros(k,1));
optrocptM     = zeros(k,2);
%%%% convert the target data into a one-hot vector for 
% calculating AUC values for each class   
t = labelconv(T);
 for nFold = 1:k     
% % % % %
    %cvp = cvpartition(nSample,'HoldOut',0.1); % partition the data 
    cvp = cvpartition(nSample, 'KFold',10);
    r = find(training(cvp,1)==1);
    X1 = X(r,:);
    T1 = T(r,:);
    t1 = t(r,:);
    r2  = find(test(cvp,1) == 1);
    X2 = X(r2,:);
    T2 = T(r2,:);
    t2 = t(r2,:);
% % % % %     
    nNeighbors = 3; % define the number of neighbours for each datapoint in the KNN model
    model = fitcknn(X1,T1,'NumNeighbors',nNeighbors,...
    'NSMethod','exhaustive','Distance','minkowski','Standardize',1);  
   
% % % % % 
    [predicted,~] = predict(model,X2);
    pp2 = labelconv(predicted);
    accuracyM(nFold) = sum(T2 == predicted) / numel(T2);
   
    [c,~] = confusionmat(predicted, T2);
    % calculate the AUC values
    % use the one-hot encoding vector and apply perfcurve function to each column. 
    %loop through the classes a
    j = size(pp2,2);   
  
for m =1:j 
    [~,~,~,a1(m,1), b1(m,:)] = perfcurve(t2(:,m), pp2(:,m), '1');
end 
% % % % % 
    
    a = nanmean(a1);     
    b = nanmean(b1);
    aucValuesM(nFold,1)   = a; %AUC values
    optrocptM(nFold,1:2)  = b;%OPTROCPT  values
     
% % % % %     
    rloss = loss(model,X2,T2);
    msErrorM(nFold) = rloss;
    for i=1:size(c,1)
        p(i,1) = c(i,i)/(nansum(c(i,:))); % recall
        rl(i,1) = c(i,i)/(nansum(c(:,i))); % precision
    end
    prec = nanmean(p);
    precisionM(nFold,1) = prec;
    rec = mean(rl);
    recallM(nFold,1) = rec;
    f1 = 2 * ((prec * rec) / (prec + rec));
    F1m(nFold,1) = f1;
 end
% calculate the mean values over the kFolds ignoring any nan values
 accuracy  = nanmean(accuracyM);
 aucValues = nanmean(aucValuesM);
 OPTROCPT  = nanmean(optrocptM);
 msError   = nanmean(msErrorM);
 precision = nanmean(precisionM);  
 f1        = nanmean(F1m);
 recall    = nanmean(recallM); 
 
end