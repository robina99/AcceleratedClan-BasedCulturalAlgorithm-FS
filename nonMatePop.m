%
%File name: nonMatePop.m
%
%
% Programmed by Robina Rasanga

% 
% Copyright (c) 2022 Robina Rasanga<robinarasanga@students.uonbi.ac.ke>.
%
% % 
%  This script is  executed during normal year of the CCA. 
%  Evolution occurs within each clan during normal year. 
%  Each individual solution is assessed and the change operator is applied.
%  
%


% 


PopList = {popCA_1,popCA_2,popCA_3,popCA_4}; 
b = [b1,b2,b3,b4];
nPop = 30;

f = 1:nPop;
start = false;


for v = 1:4
       %PopList{d} = SortPop(PopList{d})
        lbest = b(v).Situational.accuracy;
         tp = PopList{v}(f);
        data =SortPop(tp) ;
 
        PopList{v}(f)= (newFunc(data(1),lbest,X,T)); 
     
        PopList{v} = SortPop(PopList{v});
       
        newBeliefs = PopList{v}(1:newBeliefNo);
         
        worst = PopList{v}(nPop);
       
        b(v) = UpdateBeliefSystem(b(v), newBeliefs, worst, start);  
 end
b1 = b(1);
b2 = b(2);
b3 = b(3);
b4 = b(4);

 %% Cleanup
% delete all temporary variables
clear data lbest f1 ;     
clear worst newBeliefs ;