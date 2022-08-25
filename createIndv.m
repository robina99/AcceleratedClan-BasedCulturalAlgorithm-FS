function [indv] = createIndv(X,T)
%
%File name: createIndv.m
%
%
% Programmed by Robina Rasanga

% 
% 
% Copyright (c) 2022 Robina Rasanga<robinarasanga@students.uonbi.ac.ke>.
%
%  Function to create new individual solutions in the population
%
featSize = size(X,2);
maxVal = 1;
t= zeros(1,featSize);%create the vector 
for k = 1:featSize
    t(k) = round(rand(maxVal));
end        
 indv.Position = t;
 %indv.nfeat = size(find(indv.Position == 1),2);       
 f1 = find(indv.Position ==1);
 indv.nfeat = size(f1,2);
 X1 = X(:,(f1));
 [indv.accuracy,indv.AUCval,indv.mse,...
     indv.OPTROCPT,indv.precision,indv.F1, indv.recall] = knn(X1,T);


end
